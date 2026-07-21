#import "../lib.typ": *

#let interpretations = json("interpretations.json")

#let inflammatory-microbiome(report) = page(background: standard-page-background(
  section-header: [Inflammatory Microbiome],
))[
  #pad(x: 2cm, text(size: 12pt, align(
    center,
  )[*_Pathogenic bacteria detected earlier (p.3-5) in the report may contribute to inflammatory dysbiosis and microbial imbalance_*]))

  #show: it => pad(x: 0.8cm, align(center, it))

  #set par(spacing: 0pt)
  #platinum-table(
    columns: (27%, 38%, 17.5%, 17.5%),
    left-align-cols: (0, 1),
    tnum-cols: (2, 3),
    small-font-cols: (1,),
    inset: (x: 0.7em, y: 0.9em),
    table.header(
      align(left)[Bacterial Species],
      align(left)[Interpretation],
      [Result],
      [Reference],
    ),
    ..for (i, (bacteria, interpretation)) in report
      .inflammatory_microbiome
      .slice(0, 11)
      .zip(interpretations.bacteria)
      .enumerate() {
      (
        [_#bacteria.species#if range(1, 7).contains(i) [\*]_],
        [#interpretation],
        text(fill: rank-to-color(bacteria.result.rank))[*#numfmt(bacteria.result.value)*],
        [#bacteria.logic_operator],
      )
    },
  )

  #platinum-table(
    columns: (27%, 38%, 17.5%, 17.5%),
    left-align-cols: (0, 1),
    tnum-cols: (2, 3),
    small-font-cols: (1,),
    table.header(
      align(left)[Fungi / Yeast],
      align(left)[Interpretation],
      [Result],
      [Reference],
    ),
    ..for (bacteria, interpretation) in report.inflammatory_microbiome.slice(11).zip(interpretations.fungi) {
      (
        [_#bacteria.species _],
        [#interpretation],
        text(fill: rank-to-color(bacteria.result.rank))[*#numfmt(bacteria.result.value)*],
        [#bacteria.logic_operator],
      )
    },
  )
  #v(1em)
  #text(
    size: 8.3pt,
  )[Organisms marked (\*) are associated with histamine production through bacterial metabolism of histidine. In susceptible individuals, this may contribute to histamine-related symptoms and inflammatory responses.]
]
