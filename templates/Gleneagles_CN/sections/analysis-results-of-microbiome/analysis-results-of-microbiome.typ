#import "../../lib.typ": *

#let analysis-results-of-microbiome(section, report) = page(margin: (x: 0pt, top: 3.8cm))[
  #section-heading[#i18n.at(section).zh_HK\ #section]

  #align(center, pad(top: 2em, bottom: 1em, slider(
    value: none,
    caption-scheme: deficient-abundant-caption,
    caption-show-zh-hk: true,
    color-scheme: deficient-abundant-colors,
    width: 370pt,
    graphics-scheme: range(5).map(i => pad(bottom: 1em, image("images/slider-graphics/" + str(i) + ".png"))),
  )))

  #let microbiome-table(img: "", title: [], data: none, prefix: "") = table(
    columns: (2fr, 6fr, 11fr),
    gutter: 0pt,
    stroke: none,
    inset: 0pt,
    fill: (_, y) => if calc.even(y) and y > 0 { primary.lighten(93%) },
    rows: (auto, 2.44em),
    table.header(
      table.cell(colspan: 2, pad(left: 2em, bottom: 1em, grid(
        columns: (auto, 1fr),
        image(img), pad(left: 4pt, text(weight: "extrabold", size: 16pt, fill: primary.darken(30%), title)),
      ))),
      table.cell(pad(right: 1em, grid(
        columns: (87pt, 1fr, 87pt),
        align(center + bottom, stack(text(
          fill: rgb(deficient-abundant-colors.at(0)),
          weight: "bold",
          size: 8pt,
        )[#(
            deficient-abundant-caption.at(0).zh_HK
          )\ #(deficient-abundant-caption.at(0).en_HK.split().join("\n"))])),
        pad(bottom: 1.5em, align(center, text(
          fill: primary.darken(30%),
          size: 12pt,
          weight: "extrabold",
        )[相對豐度\ Relative Abundance])),
        align(center + bottom, text(
          fill: rgb(deficient-abundant-colors.at(4)),
          weight: "bold",
          size: 8pt,
        )[#(
            deficient-abundant-caption.at(4).zh_HK
          )\ #(deficient-abundant-caption.at(4).en_HK.split().join("\n"))]),
      ))),
    ),
    ..for (i, bacterium) in data.enumerate() {
      (
        pad(left: 2em, align(horizon)[#prefix #(i + 1)]),
        pad(y: 4pt, align(horizon)[
          #set par(leading: 0.3em)
          #text(size: 11pt, i18n.at(bacterium.name).zh_HK)\ #text(size: 10pt, bacterium.name)]),
        align(center + horizon, pad(left: 1em, right: 2em, top: 1pt, bottom: 8pt, slider(
          value: bacterium.level - 1,
          color-scheme: deficient-abundant-colors,
          bar-height: 6pt,
          arrow-width: 12pt,
        ))),
      )
    },
  )

  #microbiome-table(
    img: "images/probiotics.png",
    title: [益生菌\ Probiotics],
    data: report.main_species.slice(0, 7),
    prefix: "PB",
  )
  #microbiome-table(
    img: "images/pathogenic.png",
    title: [有害菌\ Pathogenic Bacteria],
    data: report.main_species.slice(7, 11),
    prefix: "HB",
  )
  #pagebreak()
  #align(center, underline(offset: 0.5em, stroke: 1pt, text(weight: "extrabold", size: 24pt, fill: primary.darken(20%), hyphenate: false)[
    #set par(justify: false, spacing: 1em)
    \3. 微生物組分析結果\ Analysis Results of Microbiome
  ])) // Hack -- Gabriel wants repeated title without adding entry to outline
  #microbiome-table(
    img: "images/commensal.png",
    title: [共生菌\ Commensal Bacteria],
    data: report.main_species.slice(11),
    prefix: "CB",
  )
]
