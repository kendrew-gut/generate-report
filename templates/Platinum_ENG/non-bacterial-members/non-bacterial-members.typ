#import "../lib.typ": *

#let display-range(range) = align(center + horizon, if range.lower == none {
  [<#numfmt(range.upper)]
} else if range.upper == none {
  [>#numfmt(range.lower)]
} else {
  box(align(center)[#numfmt(range.lower)-\ #numfmt(range.upper)])
})
#let rank-to-color(rank) = if rank == 2 { yellow } else if rank == 3 { red } else { green }

#let non-bacterial-members(report) = page(
  background: standard-page-background(
    section-header: [Non-Bacterial Members],
  ),
  footer: text(
    size: 8pt,
  )[\* Retesting timelines may vary depending on intervention type, clinical presentation, and individual response. Times for reference only],
)[
  #set par(spacing: 0em)

  #set table(fill: (x, y) => if y == 0 { primary-container }, inset: (x: 0.7em, y: 0.6em), stroke: grey.lighten(60%))
  #show table.cell: it => if it.y > 0 { text(size: 10pt, it) } else { it }
  #show table.cell.where(y: 0): strong
  #show table.cell: it => align(horizon, it)
  #{
    show table.cell.where(x: 0, y: 0).or(table.cell.where(x: 3, y: 0)): it => align(start, it)
    show (
      table.cell.where(y: 0).or(table.cell.where(x: 1)).or(table.cell.where(x: 2)).or(table.cell.where(x: 4))
    ): it => align(center, it)
    show table.cell.where(x: 1).or(table.cell.where(x: 2)): it => text(features: ("tnum",), it)

    table(
      columns: (23%, 15%, 15%, 32%, 15%),
      table.header(
        [Parasitic Pathogens], [Result], [Reference], [Role / Gut & Gost Function / Impact], [Re-test Interval\*]
      ),
      ..for parasite in report.non_bacterial_members.parasites {
        (
          [_#parasite.name _],
          text(fill: rank-to-color(parasite.result.rank))[*#numfmt(parasite.result.value)*],
          display-range(parasite.reference_range),
          text(size: 8pt)[#parasite.impact],
          [#parasite.retest_interval],
        )
      },
    )
    table(
      columns: (23%, 15%, 15%, 32%, 15%),
      table.header(
        [Viral Pathogens], [Result], [Reference], [Role / Gut & Gost Function / Impact], [Re-test Interval\*]
      ),
      ..for virus in report.non_bacterial_members.virus {
        (
          [_#virus.name _],
          text(fill: rank-to-color(virus.result.rank))[*#numfmt(virus.result.value)*],
          display-range(virus.reference_range),
          text(size: 8pt)[#virus.impact],
          [#virus.retest_interval],
        )
      },
    )
    table(
      columns: (23%, 15%, 15%, 32%, 15%),
      table.header([Fungi/Yeast], [Result], [Reference], [Role / Gut & Gost Function / Impact], [Re-test Interval\*]),
      ..for fungi in report.non_bacterial_members.fungi {
        (
          [_#fungi.name _],
          text(fill: rank-to-color(fungi.result.rank))[*#numfmt(fungi.result.value)*],
          display-range(fungi.reference_range),
          text(size: 8pt)[#fungi.impact],
          [#fungi.retest_interval],
        )
      },
    )
  }

  #{
    show table.cell.where(x: 1).or(table.cell.where(x: 3)): it => align(center, it)
    table(
      columns: (23%, 15%, 40%, 22%),
      table.header([Protozoa & Worms], [Result], [Role / Gut & Gost Function / Impact], [Re-test Interval\*]),
      ..for protozoa in report.non_bacterial_members.protozoa {
        (
          [_#protozoa.name _],
          text(fill: if protozoa.detected { red } else { green })[*#if protozoa.detected [Detected] else [Not Detected]*],
          text(size: 8pt)[#protozoa.impact],
          [#protozoa.retest_interval],
        )
      },
    )
  }
]
