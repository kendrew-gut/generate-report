import json

with open("temp/input.txt", encoding="utf8") as f:
    contents = f.read()
    paragraphs = contents.split("\n\n")
    lines = [ "".join(paragraph.split("\n")).strip() for paragraph in paragraphs ]
    with open("temp/output.txt", 'w', encoding="utf8") as results:
        with open("temp/effects.txt") as effects:
            for i, species in enumerate(effects):
                results.write(species.strip() + " \"" + lines[i] + "\"" + "\n")