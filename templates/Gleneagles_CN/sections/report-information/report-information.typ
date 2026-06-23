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
    v(1em)
    table(
      columns: (40%, 60%),
      [樣品編號], report.sample_id,
      [用戶姓名], report.report_information.user_full_name,
      [用戶性別], report.report_information.gender,
      [出生日期], report.report_information.date_of_birth.display(date-format),
      [樣品總質量 (µg)], [#report.report_information.sample_total_mass_ug],
      [樣品質量等級\ (A/B/C/NA)], report.report_information.sample_quality_level,
      [報告日期], report.report_information.date_of_report.display(date-format),
      [檢測日期], report.report_information.date_collected.display(date-format),
      [檢測項目], i18n.at(report.product).zh_HK,
    )
  }
]
