#import "../../lib.typ": *

#let report-information(report) = page[
  #section-heading(is-numbered-section: false)[報告資料\ Report Information]

  #{
    set table(
      stroke: (x, y) => (
        top: if y == 0 { 3pt + secondary.transparentize(38%) },
        right: if x == 0 { 1pt + secondary.transparentize(38%) },
        bottom: 1.5pt + secondary.transparentize(38%),
      ),
      fill: (x, y) => if x == 0 and calc.odd(y) { secondary.transparentize(92%) },
    )
    show table.cell: it => {
      pad(
        align(horizon, if (it.x == 0) {
          set text(weight: "bold")
          show math.equation: set text(weight: "bold")
          it
        } else {
          it
        }),
        x: 13pt,
        y: 10pt,
      )
    }
    table(
      columns: (40%, 60%),
      [Sample ID], report.sample_id,
      [User Name], report.user-name,
      [Sex], report.sex,
      [Date of Birth], report.date-of-birth.display(date-format),
      [Sample Mass ($mu g$)], [#report.sample-mass],
      [Sample Quality\ (A/B/C/NA)], report.sample-quality,
      [Report Date], report.date.display(date-format),
      [Testing Date], report.testing-date.display(date-format),
      [Testing Item], report.testing-item,
    )
  }
]
