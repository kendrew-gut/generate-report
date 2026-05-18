#import "../../lib.typ": *


// TODO: refactor to use outline()
#let table-of-contents(report) = page(margin: (top: 4cm, bottom: 1cm, x: 2.3cm))[
  #let outline-row(i, section) = (
    table.cell(line(angle: 90deg, stroke: 8pt + primary.darken(20%), length: 50pt)),
    table.cell(text(size: 47pt, weight: "black", leftpad(2, "0", i))),
    table.cell(text(fill: secondary.darken(20%), size: 16pt, weight: "bold")[#section.en\ #section.zh_hk]),
    table.cell(text(fill: secondary.darken(20%), size: 17pt, weight: "extrabold")[3]),
  )

  #place(left, dx: -200pt, image("images/anatomy.png"))
  #place(right, box(width: 80%, pad(top: 40pt, place(left)[
    = 報告目錄\ Table of Contents

    #pad(left: 4pt, table(
      align: left + horizon,
      stroke: none,
      columns: (30pt, 80pt, 250pt, 10pt),
      row-gutter: 8pt,
      ..report.sections.enumerate(start: 1).map(((i, section)) => outline-row(i, section)).flatten(),
    ))
  ])))
]
