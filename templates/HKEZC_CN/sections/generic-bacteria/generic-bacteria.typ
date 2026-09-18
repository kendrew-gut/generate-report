#import "../../lib.typ": *

#let relative-abundance-palette = (
  "8562EA",
  "76B9F0",
  "67902C",
  "B83143",
  "473C38",
).map(hex => rgb(hex))

#let relative-abundance-slider(rating) = table(
  columns: (1fr,) * 5,
  align: center + horizon,
  inset: (x: 0pt, y: 1.5pt),
  stroke: none,
  ..range(5).map(i => if i == rating { arrow-down(width: 10pt) }),
  ..range(5).map(i => box(fill: relative-abundance-palette.at(i), height: 0.2cm, width: 100%))
)

#let generic-bacteria-section(
  report,
  data,
  effects,
  section-heading: [= *Core bacteria 核心菌 -- _8 species/genus in total 共8個菌種/屬_*],
  bacteria-group-name: (
    en-HK: "Core bacteria",
    zh-HK: "核心菌",
  ),
  id-label: "CB"
) = page(margin: (x: 0pt), header: pad(x: 1.1cm, page-header(report)), footer: pad(x: 1.1cm, page-footer))[
  #set par(spacing: 0.2cm)
  #let num_bacteria = data.len()
  #pad(x: 1.1cm, heading(level: 1, section-heading))
  #set text(weight: 500)
  #table(
    columns: (10%, 40%, 50%),
    stroke: none,
    inset: (y: 3pt),
    align: (x, y) => (if x == 0 { right }) + horizon,
    fill: (x, y) => if y != 0 and calc.rem(y, 2) == 0 { gray.lighten(70%) },
    table.header(
      [], [], box(width: 92%, align(center, text(size: 10pt, fill: primary.darken(30%))[*Relative Abundance* 相對豐度]))
    ),
    ..for (i, bacteria) in data.enumerate() {
      (
        text(number-width: "tabular")[#id-label #(i + 1)],
        [#bacteria.name.zh_HK #bacteria.name.en_HK],
        box(width: 92%, relative-abundance-slider(bacteria.relative_abundance - 1)),
      )
    },
  )
  #v(0.7cm)
  #pad(x: 1.1cm, {
    rect(width: 100%, stroke: primary.darken(20%) + 1.3pt, inset: 0.7cm, {
      align(center, text(
        fill: primary.darken(30%),
        size: 12pt,
      )[*Detailed introduction of #lower(bacteria-group-name.en-HK) #{ bacteria-group-name.zh-HK }詳細講解*])
      v(0.7cm)
      {
        set text(size: 9pt, weight: 600)
        table(
          columns: (1fr,) * 2,
          fill: gray.lighten(50%),
          gutter: 0.6cm,
          stroke: none,
          inset: 0pt,
          ..for (i, bacteria) in data.enumerate() {
            (
              stack(
                dir: ttb,
                stack(
                  dir: ltr,
                  box(width: 78%, inset: 6pt, align(horizon)[#id-label #(i + 1) -- #bacteria.name.zh_HK]),
                  box(
                    width: 22%,
                    fill: relative-abundance-palette.at(bacteria.relative_abundance - 1),
                    inset: 4pt,
                    align(center + horizon, text(fill: white, size: 11pt)[輕微過少]),
                  ),
                ),
                pad(top: 4pt, x: 6pt, bottom: 15pt)[
                  影響：#effects.at(bacteria.name.en_HK)
                ],
              ),
            )
          }
        )
      }
    })
  })
]
