#import "../../lib.typ": *

#let health-level-descriptions = (
  "Your gut health exhibits a severe imbalance, indicating a high risk of inflammation and digestive issues. It is advised to closely monitor and follow up on your health condition.",
  "Your gut microbiome shows some imbalance, which may affect overall health and immune function. It is advisable to consider adjusting your diet and lifestyle.",
  "Your gut health condition is stable, but there is room for improvement to strengthen immunity and reduce potential health risks.",
  "Your gut microbiota is in a balanced state, contributing to robust immunity and digestive health. It is beneficial to maintain your current habits.",
  "Your gut health is in an ideal state, supporting excellent immune function, digestion, and overall physical and mental well-being.",
)

#let health-conditions-overview(section, report) = page(margin: (x: 0pt))[
  #pad(x: 2.3cm)[
    #section-heading[#section.zh_hk\ #section.en]
    #v(1.5cm)
    #align(center, slider(
      value: report.overall-health,
      caption-scheme: generic-caption,
      width: 380pt,
      semantics: bad-excellent,
    ))
    #v(1cm)
    #align(center, text(weight: "bold", size: 17.5pt)[
      Your overall health level: #text(fill: rgb(default-colors.at(report.overall-health)), generic-caption.at(report.overall-health).en)
    ])

    We utilize advanced artificial intelligence technology for analysis, assessing your overall health based on the specific composition of bacteria in your gut microbiome. By analyzing and calculating the diversity and abundance of key probiotic strains, our AI model evaluates the balance of your gut ecosystem and correlates it with broader physical and mental health impacts.

    Our analytical approach provides a data-driven perspective on how your gut health influences your overall well-being, while also offering alerts for potential health risks.
  ]

  #let health-level-bar(i) = table(
    fill: rgb(default-colors.at(i)).lighten(80%),
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
    align(center + horizon, pad(x: 1em, text(fill: rgb(default-colors.at(i)), weight: "extrabold", size: 14pt)[#set par(
        leading: 0.3em,
      )
      #generic-caption.at(i).zh_hk\ #generic-caption.at(i).en])),
    align(horizon, pad(
      right: 1em,
      y: 0.3em,
    )[#set par(leading: 0.4em)
      #health-level-descriptions.at(i)
    ]),
  )

  #grid(
    ..range(0, 5).map(i => health-level-bar(i))
  )
]
