#import "../../lib.typ": *

#let front-cover(report) = page[
  = #text(weight: "bold")[mNGS (metagenomic next generation sequencing) technology -- microbiome analysis in Hong Kong Science Park's laboratory]\ mNGS（次世代宏基因測序）技術 -- 香港科學園實驗室微生物組分析

  == 報告資料
  #v(1cm)
  #align(center, {
    {
      set text(size: 12pt)
      show table.cell.where(x: 0): it => align(right + horizon, text(weight: "semibold", fill: white, it))
      show table.cell.where(x: 1): it => align(left + horizon, text(weight: "bold", it))
      table(
        columns: (35%, 45%),
        fill: (x, y) => if x == 0 { if calc.rem(y, 2) == 0 { cyan } else { bluegray } },
        stroke: rgb("95B3D7"),
        inset: (x: 1em, y: 1.5em),
        [樣品編號：], report.sample.id,
        [收集日期：], report.sample.collected_date.display(date-format),
        [樣品質量等級（A/B/C/NA）：], report.sample.quality,
        [樣品總質量（#{ sym.mu }g）：], [#report.sample.mass],
        [樣品濃度檢測方法：], [Qubit 螢光定量儀],
        [樣品完整性檢測方法：], [瓊脂糖凝膠電泳技術],
      )
    }
    v(0.8cm)
    {
      show table.cell.where(x: 1): set text(weight: "bold")
      box(width: 80%, align(left, center-aligned-columns(
        [用戶編號：],
        report.client.id,
        [出生日期：],
        report.client.date_of_birth.display(date-format),
        [性別：],
        report.client.gender,
        [報告編號：],
        report.report_id,
      )))
    }
  })
]
