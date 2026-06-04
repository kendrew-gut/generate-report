#import "../../lib.typ": *

#let table-of-contents(report) = page(margin: (top: 4cm, bottom: 1cm, x: 2.3cm))[
  #let outline-row(i, section, page) = (
    table.cell(line(angle: 90deg, stroke: 8pt + primary.darken(20%), length: 50pt)),
    table.cell(text(size: 42pt, weight: "black", leftpad(2, "0", i))),
    table.cell(text(fill: secondary.darken(20%), size: 16pt, weight: "bold")[#section.zh_hk\ #section.en]),
    table.cell(text(fill: secondary.darken(20%), size: 17pt, weight: "extrabold")[#page]),
  )

  #place(left, dx: -200pt, image("images/anatomy.png"))
  #let outline-counter = counter("outline")
  #show outline.entry: it => if to-string(it.element.body).starts-with(regex("^[0-9]")) {
    outline-counter.step()
    let i = outline-counter.get().at(0)
    let page = it.element.location().page() - 1 // Hack: no idea why - 1 is needed
    link(it.element.location(), pad(left: 4pt, table(
      align: left + horizon,
      stroke: none,
      columns: (20pt, 70pt, 270pt, 10pt),
      row-gutter: 8pt,
      ..outline-row(i + 1, report.sections.at(i), page),
    )))
  }
  #place(right, box(width: 80%, pad(top: 40pt, place(left, outline(
    title: [= 報告目錄\ Table of Contents],
    target: heading.where(level: 1),
  )))))
]
