#import "../../lib.typ": *

#let health-level-descriptions = (
  "您的腸道健康存在嚴重失衡，顯示出高風險的炎症和消化問題。建議密切觀察和跟進健康狀況。",
  "您的腸道微生物群顯示出一些失衡，這可能會影響整體健康和免疫力。建議考慮調整飲食和生活方式。",
  "您的腸道健康狀況穩定，但可以進一步改善，以增強抵抗力並減少潛在的健康風險。",
  "您的腸道微生物群處於平衡狀態，有助於強健的免疫力和消化健康。保持目前的習慣是有益的。",
  "您的腸道健康狀況理想，維持了優秀的免疫力、消化功能和整體身心健康。繼續保持當前的習慣即可。",
)

#let health-conditions-overview(section, report) = page(margin: (x: 0pt))[
  #pad(x: 2.3cm)[
    #section-heading[#i18n.at(section).zh_HK\ #section]
    #v(1.5cm)
    #align(center, slider(
      value: report.health_condition_overview - 1,
      caption-scheme: bad-excellent-caption,
      width: 380pt,
      semantics: bad-excellent,
    ))
    #v(1cm)
    #align(center, text(weight: "bold", size: 17.5pt)[
      您的健康情況是#text(fill: rgb(bad-excellent-colors.at(report.health_condition_overview - 1)), bad-excellent-caption.at(report.health_condition_overview - 1).zh_HK)
    ])

    我們的利用先進的人工智能技術進行分析，根據您腸道微生物群中細菌的特定組成來檢測您的整體健康狀況。通過分析和計算關鍵益生菌菌株的多樣性和豐度，我們的人工智能模型可以評估您腸道生態系統的平衡狀況，並將其與更廣泛的身心健康影響聯繫起來。
    我們的分析方法提供了一個數據驅動的視角，顯示您的腸道健康如何影響您的整體健康，並提供潛在的健康風險預警。
    #v(1.5cm)
  ]

  #let health-level-bar(i) = table(
    fill: rgb(bad-excellent-colors.at(i)).lighten(80%),
    columns: (1.8cm, auto, 7em, 1fr),
    stroke: none,
    column-gutter: 0pt,
    [],
    align(center + horizon, [#image("images/health-conditions-tab-" + str(i) + ".png") #place(horizon + left, pad(
        8pt,
        circle(
          stroke: white + 1.5pt,
          inset: 4pt,
          text(size: 16.7pt, weight: "extrabold", fill: white)[#(i + 1)],
        ),
      ))]),
    align(center + horizon, pad(x: 1em, text(
      fill: rgb(bad-excellent-colors.at(i)),
      weight: "extrabold",
      size: 14pt,
    )[#set par(
        leading: 0.3em,
      )
      #bad-excellent-caption.at(i).zh_HK\ #bad-excellent-caption.at(i).en_HK])),
    align(horizon, pad(
      right: 1em,
      y: 0.3em,
    )[#set par(leading: 0.4em)
      #text(size: 11pt, health-level-descriptions.at(i))
    ]),
  )

  #grid(
    ..range(0, 5).map(i => health-level-bar(i))
  )
]
