// Prevent console window in addition to Slint window in Windows release builds when, e.g., starting the app via file manager. Ignored on other platforms.
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use std::{
    fs::OpenOptions,
    io::{BufReader, BufWriter, Read, Write},
    path::Path,
    sync::{Arc, Mutex},
    thread,
    time::Duration,
};

use derive_typst_intoval::{IntoDict, IntoValue};
use include_dir::{Dir, include_dir};
use rayon::iter::{IntoParallelRefIterator, ParallelIterator};
use rfd::AsyncFileDialog;
use slint::{Model, ModelRc, SharedString, VecModel, spawn_local};
use typst::foundations::{Bytes, IntoValue};
use typst_as_lib::{TypstEngine, TypstTemplateMainFile};

static TEMPLATES: Dir = include_dir!("$CARGO_MANIFEST_DIR/templates/");

#[derive(Debug, Clone, IntoValue, IntoDict)]
struct TemplateInput {
    input_json: Bytes,
}

slint::include_modules!();

fn templates() -> Vec<String> {
    TEMPLATES
        .dirs()
        .map(|dir| dir.path().to_str().unwrap().to_string())
        .collect()
}

fn template(name: impl AsRef<str>) -> anyhow::Result<TypstEngine<TypstTemplateMainFile>> {
    let name = name.as_ref();
    let gleneagles_template = TEMPLATES.get_dir(name).unwrap();
    let fonts = gleneagles_template.find(&format!("{name}/**/*.ttf"))?;
    let source_files = gleneagles_template.find(&format!("{name}/**/*.typ"))?;
    let other_files = gleneagles_template
        .find(&format!("{name}/**/*.png"))?
        .chain(gleneagles_template.find(&format!("{name}/**/*.jpg"))?)
        .chain(gleneagles_template.find(&format!("{name}/**/*.json"))?)
        .chain(gleneagles_template.find(&format!("{name}/**/*.yml"))?)
        .chain(gleneagles_template.find(&format!("{name}/**/*.yaml"))?);
    Ok(TypstEngine::builder()
        .main_file(
            gleneagles_template
                .get_file(format!("{name}/{name}.typ"))
                .unwrap()
                .contents_utf8()
                .unwrap(),
        )
        .with_static_source_file_resolver(source_files.map(|src| {
            (
                {
                    let mut p = src.path().components();
                    p.next();
                    p
                }
                .as_path()
                .to_str()
                .unwrap(),
                src.as_file().unwrap().contents_utf8().unwrap(),
            )
        }))
        .with_static_file_resolver(other_files.map(|src| {
            (
                {
                    let mut p = src.path().components();
                    p.next();
                    p
                }
                .as_path()
                .to_str()
                .unwrap(),
                src.as_file().unwrap().contents(),
            )
        }))
        .with_package_file_resolver()
        .fonts(fonts.map(|font| font.as_file().unwrap().contents()))
        .build())
}

fn compile(input: &String, selected_template: &String) -> anyhow::Result<()> {
    println!("Reading input json");
    let mut reader = BufReader::new(OpenOptions::new().read(true).open(input)?);
    let mut input_json = Vec::new();
    reader.read_to_end(&mut input_json)?;
    println!("Finished reading input json");
    let input_json = Bytes::new(input_json);
    let output_filename = input.split(".json").nth(0).unwrap().to_string() + ".pdf";
    println!(
        "Compiling:\n\ttemplate: {selected_template}\n\tinput: {input}\n\toutput: {output_filename}"
    );
    match template(&selected_template)?
        .compile_with_input(TemplateInput { input_json }.into_dict())
        .output
    {
        Ok(doc) => {
            print!("Successfully compiled input {input}. ");
            match typst_pdf::pdf(&doc, &Default::default()) {
                Ok(pdf) => {
                    println!("Writing output PDF to {output_filename}");
                    let mut writer = BufWriter::new(
                        OpenOptions::new()
                            .read(true)
                            .write(true)
                            .create(true)
                            .open(output_filename)?,
                    );
                    writer.write(&pdf)?;
                    writer.flush()?;
                    println!("Successful!")
                }
                Err(err) => {
                    eprintln!("Error while generating output PDF:\n{:?}", err)
                }
            }
        }
        Err(err) => {
            eprintln!("Error while compiling Gleneagles template:\n{}", err)
        }
    }
    Ok(())
}

fn main() -> anyhow::Result<()> {
    let app = AppWindow::new()?;
    app.set_templates(ModelRc::new(VecModel::from_iter(templates().iter().map(
        |template| SelectItem {
            label: SharedString::from(template),
            value: SharedString::from(template),
        },
    ))));
    app.on_select_inputs({
        let app = app.clone_strong();
        move || {
            _ = spawn_local({
                let app = app.clone_strong();
                async move {
                    if let Some(files) = AsyncFileDialog::new()
                        .add_filter("Report Input", &["json"])
                        .pick_files()
                        .await
                    {
                        app.set_inputs(ModelRc::new(VecModel::from_iter(files.iter().map(
                            |file| {
                                Input {
                                    name: SharedString::from(
                                        file.path()
                                            .components()
                                            .next_back()
                                            .unwrap()
                                            .as_os_str()
                                            .to_str()
                                            .unwrap(),
                                    ),
                                    path: SharedString::from(file.path().to_str().unwrap()),
                                }
                            },
                        ))));
                    }
                }
            })
            .inspect_err(|e| eprintln!("Could not select file: {e}"));
        }
    });
    app.on_clear_inputs({
        let app = app.clone_strong();
        move || app.set_inputs(ModelRc::new(VecModel::from_iter([])))
    });
    let is_successful = Arc::new(Mutex::new(None as Option<bool>));
    app.on_generate({
        let is_successful = is_successful.clone();
        let app = app.clone_strong();
        move |inputs, template_index| {
            app.set_is_generating(true);
            let inputs = inputs
                .iter()
                .map(|input| input.path.as_str().to_string())
                .collect::<Vec<_>>();
            let selected_template = templates()[template_index as usize].clone();
            println!("Inputs: {inputs:?}, selected template: {selected_template}");
            thread::spawn({
                let is_successful = is_successful.clone();
                move || {
                    println!("Spawned thread");
                    if inputs
                        .par_iter()
                        .map(|input| compile(input, &selected_template))
                        .all(|result| result.is_ok())
                    {
                        *is_successful.lock().unwrap() = Some(true);
                    } else {
                        *is_successful.lock().unwrap() = Some(false);
                    }
                }
            });
            let is_successful = is_successful.clone();
            let app = app.clone_strong();
            _ = spawn_local(async_compat::Compat::new(async move {
                let mut resolved = false;
                for _ in 0..400 {
                    match *is_successful.lock().unwrap() {
                        Some(is_successful) => {
                            if is_successful {
                                app.set_show_success(true);
                                tokio::time::sleep(Duration::from_secs(1)).await;
                                app.set_show_success(false);
                                resolved = true;
                            }
                            break;
                        }
                        None => {}
                    }
                    tokio::time::sleep(Duration::from_millis(100)).await;
                }
                if !resolved {
                    app.set_show_failure(true);
                    tokio::time::sleep(Duration::from_secs(1)).await;
                    app.set_show_failure(false);
                }
                *is_successful.lock().unwrap() = None;
                app.set_is_generating(false);
            }));
        }
    });
    app.run()?;
    Ok(())
}
