#import "../../lib.typ": *

#let integrated-analysis-palette = (
  "473C38",
  "B83143",
  "F5BD37",
  "94B143",
  "3F7792",
).map(hex => rgb(hex))
#let integrated-analysis-display = (
  [嚴重失衡],
  [中度失衡],
  [輕度失衡],
  [大致平衡],
  [高度平衡],
)

#let integrated-analysis(report) = page[
  = *綜合腸道微生態分析  Integrated Gut Microbiome Analysis*
  #let normalized-balance-rating = report.integrated_balance_rating - 1
  #align(center, {
    par(leading: 1.5em, text(
      size: 12pt,
    )[綜合分析 1）核心菌、2）有害菌、3）益生菌 以及 4）寄生蟲 四個主要因素之數據，\ *您的腸道微生態平衡結果為 #underline(text(fill: integrated-analysis-palette.at(normalized-balance-rating), integrated-analysis-display.at(normalized-balance-rating)))*])

    v(0.5cm)

    table(
      columns: (1fr,) * 5,
      inset: 0pt,
      stroke: none,
      ..range(5).map(i => if i == normalized-balance-rating { arrow-down(width: 1.2cm) }),
      ..range(5).map(i => pad(8pt, text(size: 12.5pt, integrated-analysis-display.at(i)))),
      ..range(5).map(i => box(fill: integrated-analysis-palette.at(i), height: 0.6cm, width: 100%))
    )
  })

  #set text(size: 10pt)
  #box(
    width: 100%,
    inset: (x: 10pt, y: 15pt),
    fill: gray.lighten(70%),
  )[
    #set par(spacing: 1.5em)
    *為甚麼於科學上評估人體腸道微生態平衡，需要將有害菌、核心菌以及寄生蟲等因素綜合計算分析？*

    人體腸道微生態平衡受多種因素影響，如僅評估益生菌不能全面反映腸道健康狀況。在益生菌足夠的情況下，有害菌過度生長或核心菌不足仍會破壞腸道微生態平衡，寄生蟲亦仍有可能存在於腸道，導致腹瀉、營養不良或免疫系統失調。

    次世代宏基因測序技術通過分析腸道內微生物的基因組，能準確地辨識出核心菌、有害菌以及其他微生物，提供相對豐度數據，顯示樣本中每種微生物在整體群落中的比例。相比qPCR技術，次世代宏基因測序的通量非常高，能在一次運行中同時對成千上萬個基因、RNA或基因組變異進行分析。通過深度測序，還能更準確地呈現低豐度微生物來進行深度分析，如微生物群體結構的研究、未知病原體的鑑定和微生物多樣性分析。
  ]
  \
  \
  濕疹是一種常見的慢性皮膚病，在香港，每五人便有一人在不同時期患上。常見症狀包括皮膚乾燥、劇烈瘙癢和出現紅斑，這些症狀可能導致不適，甚至引發繼發性感染。
  \
  \
  *近期研究顯示，濕疹與腸道健康有著密切關係，因為腸道微生物菌叢失衡可能會導致免疫系統功能失調，進而加劇濕疹症狀。*想有效解決濕疹問題，不僅需要局部治療如遠離過敏原、注意護膚保濕，還應通過個人化營養補充益生菌和支持腸道微生物菌叢
  平衡的生活方式來改善腸道健康，從而減少濕疹的發作次數，並提升整體皮膚健康狀況。

  #v(1.5cm)
  #table(
    columns: (1fr,) * 2,
    align: center + bottom,
    stroke: none,
    stack(
      spacing: 6pt,
      image("images/eczema-symptoms.png"),
      pill(text(fill: white, size: 9pt)[濕疹常見症狀： 皮膚乾燥、劇烈痕癢、紅斑皮疹]),
    ),
    stack(
      spacing: 10pt,
      image("images/people.png"),
      pill(text(fill: white, size: 9pt)[數據指每5個香港人，便有一人在不同時期患有濕疹]),
    ),
  )
]
