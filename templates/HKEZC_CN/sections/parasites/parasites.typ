#import "../../lib.typ": *

#let descriptions = yaml("descriptions.yml")

#let parasite-row(parasite) = {
  box(
    fill: gray.lighten(70%),
    width: 100%,
    radius: (left: 50%, right: 20pt),
    table(
      columns: (auto, 1fr),
      inset: 0pt,
      gutter: 0.5cm,
      stroke: none,
      image("images/" + parasite.name.en_HK + ".png"),
      table(
        columns: (60%, 40%),
        inset: 5pt,
        align: (left + horizon, center + horizon),
        stroke: none,
        text(size: 12pt)[*#parasite.name.zh_HK #parasite.name.en_HK*],
        pill(
          radius: (top-right: 15pt, left: 6pt, bottom-right: 6pt),
          inset: (y: 0.8em),
          width: 100%,
          fill: if parasite.result { rgb("C0504D") } else { primary },
          if parasite.result [*Positive 陽性*] else [*Negative 陰性*],
        ),
        table.cell(colspan: 2, pad(right: 8pt, bottom: 8pt, text(size: 9pt, descriptions.at(parasite.name.en_HK)))),
      ),
    ),
  )
}

#let parasites(report) = page[
  #let parasites-len = report.parasites.len()
  = *Parasite Test Report -- #parasites-len in total\ 寄生蟲檢測結果 -- 共分析#{ parasites-len }種*

  #rect(width: 100%, stroke: primary.darken(20%) + 1.3pt, inset: 0.7cm, {
    par(text(
      size: 10pt,
    )[如體內含有寄生蟲，可引起腹痛、腹瀉、營養不良、疲倦、體重減輕、炎症、肛門周圍瘙癢，特別是夜間，並可能導致失眠和易怒等問題。次世代宏基因測序能在樣本中檢測所有微生物的DNA，這使次世代宏基因測序可以識別多種寄生蟲及其卵，並提供詳細的物種分類信息。而傳統的顯微鏡技術依賴於寄生蟲的形態學特徵、技術人員的識別和診斷，且容易受到樣本質量和寄生蟲數量影響，可能會漏掉一些較小或不明顯的寄生蟲。相比之下，次世代宏基因測序可提供更全面的檢測。])
    v(0.7cm)
    for parasite in report.parasites {
      parasite-row(parasite)
    }
  })
]
