#import "../../lib.typ": *

#let report-introduction(section, report) = [
  #section-heading[#i18n.at(section).zh_HK\ #section]
  #box(
    fill: primary.transparentize(90%),
    inset: 8pt,
  )[
    #set par(leading: 0.7em, spacing: 1.5em)
    您的腸道微生物群是您體內的一個獨特生態系統，由數萬億微生物組成，包括細菌、病毒、真菌和其他微生物，主要生活在您的腸道中。這些微小的生物在維持整體健康方面起着至關重要的作用，影響着從消化、免疫到情緒和新陳代謝的各個方面。每個人的腸道微生物群都像指紋一樣獨一無二，由飲食、生活方式、環境和遺傳等因素所塑造。

    平衡的腸道微生物群有助於保持健康的消化系統，支持免疫功能，甚至影響心理健康。然而，當腸道微生物群失衡時，通常是由於不良飲食、壓力或抗生素引起的，可能會導致一系列健康問題，從消化不適和炎症到慢性疾病。

    在本報告中，我們將詳細探討您的腸道微生物群，幫助您了解它如何影響您的健康，並提供個人化的優化建議，以實現更健康、更平衡的生活。]

  == 腸道微生物群與身心健康
  #let figure-box(alignment, dx, dy, img, box-width: 80pt, font-size: 16.7pt, caption) = context {
    place(alignment, dx: dx, dy: dy, box(width: box-width, align(center, stack(
      image(img),
      pad(top: 5pt, text(
        size: font-size,
        weight: "bold",
        fill: secondary.darken(20%),
        caption,
      )),
    ))))
  }
  #box(width: 100%)[
    #figure-box(top + left, 10pt, 0pt, "images/gut-microbiome.png", box-width: 10em, font-size: 16pt)[腸道微生物群]
    #place(bottom + left, dx: 60pt, dy: -35pt, image("images/curved-arrow-1.png"))
    #align(center, box(
      radius: 20pt,
      fill: primary.transparentize(90%),
      width: 250pt,
      height: 190pt,
    )[
      #figure-box(top + left, 35pt, 8pt, "images/food.png")[飲食]
      #figure-box(top + right, -35pt, 8pt, "images/exercise.png")[運動]
      #figure-box(bottom + left, 35pt, -8pt, "images/habit.png")[日常習慣]
      #figure-box(bottom + right, -35pt, -8pt, "images/supplement.png")[藥物調節]
    ])
    #place(top + right, dx: -60pt, dy: 20pt, image("images/curved-arrow-2.png"))
    #figure-box(bottom + right, -20pt, 0pt, font-size: 16pt, "images/overall-health.png")[身心健康]
  ]
  #v(0.5em)
  腸道微生物群日益被認為是個人健康的基石，影響着除消化之外的廣泛身體功能。這個主要存在於腸道的多樣化微生物群體對免疫力、新陳代謝、情緒，甚至慢性病的風險都有深遠的影響。研究顯示，腸道微生物群的不平衡——稱為腸道微生物群失調——可能導致健康問題，如炎症、肥胖、糖尿病、皮膚病和心理健康障礙。

  每個人的微生物群都是獨特的，了解其組成可以為個人健康提供寶貴的見解。通過識別特定的細菌特徵並評估其功能，我們能發現可能影響健康的潛在失衡。本報告深入分析您的獨特微生物群特徵及其與健康方面的關係，並提供個性化建議，以支持平衡且有韌性的腸道生態系統。

  我們相信調節腸道微生物群、維持腸道健康對於身心健康至關重要。我們會通過此報告提供建議，幫助您得到更健康、更活力的生活。

  #pagebreak()

  #page(margin: (x: 0pt))[
    == 腸道微生物群菌種介紹
    #let gut-microbiome-species-tab(alignment, background-img, img, title, title-color, description) = context {
      let background = image(background-img)
      set text(size: 14pt)
      box(width: 100%, height: measure(background).height, {
        place(alignment, background)
        place(alignment, box(
          width: measure(background).width,
          height: measure(background).height,
          align(horizon, table(
            align: left,
            columns: if alignment == left { (1fr, auto) } else { (auto, 1fr) },
            stroke: none,
            if alignment == left {
              pad(left: 40pt)[
                #h(1fr) #text(size: 20pt, fill: title-color, weight: "extrabold", title)\
                #description
              ]
            } else {
              pad(left: 40pt, image(img))
            },
            if alignment == left {
              pad(right: 40pt, image(img))
            } else {
              pad(right: 20pt)[
                #text(size: 20pt, fill: title-color, weight: "extrabold", title)\
                #description
              ]
            }
          )),
        ))
      })
    }
    #gut-microbiome-species-tab(
      left,
      "images/probiotics-background.png",
      "images/probiotics.png",
      [益生菌 Probiotics],
      rgb("1E7080"),
      [益生菌是對人體有益的活性微生物，主要包括乳酸桿菌，如嗜酸乳桿菌和雙歧桿菌。它們在腸道中通過抑制有害菌的生長、增強腸道屏障功能和促進免疫反應等方式，幫助維護腸道平衡，促進營養吸收。人體需要益生菌來維持健康的腸道環境。],
    )

    #gut-microbiome-species-tab(
      right,
      "images/commensal-bacteria-background.png",
      "images/commensal-bacteria.png",
      [共生菌 Commensal Bacteria],
      rgb("1C4A7D"),
      [共生菌是指在健康個體腸道中普遍存在的細菌群體，典型的如腸球菌和乳酸桿菌。共生菌在維持腸道微生物群落的穩定性和功能中起著關鍵作用，它們有助於營養代謝、維持腸道pH值和增強免疫功能。共生菌的存在是人體維持健康所必需的。],
    )
    #gut-microbiome-species-tab(
      left,
      "images/harmful-bacteria-background.png",
      "images/harmful-bacteria.png",
      [有害菌 Harmful Bacteria],
      rgb("B83143"),
      [有害菌是對健康產生負面影響的微生物，典型的如大腸桿菌和沙門氏菌。這些細菌在腸道中可能導致感染、炎症及消化不良等問題。雖然有害菌在生態系統中扮演著清除死細胞等角色，但其數量過多會對健康產生威脅，因此應控制在適當水平。],
    )

    === 如何科學地評估腸道微生物群的平衡？
    #pad(x: 1.8cm)[
      要真正理解腸道健康，必須通過檢查三類關鍵細菌群來評估微生物群：有害菌、共生菌和益生菌。這些細菌群的平衡會影響腸道健康，僅僅測量益生菌是不夠的。即使有足夠的益生菌，有害細菌的過度生長或核心細菌的缺乏也會破壞微生物群的和諧。
    ]
  ]

  #page(background: {
    place(bottom, box(
      width: 100%,
      height: 16cm,
      fill: primary.lighten(90%),
    ))
    standard-page-background(report)
  })[
    == 標準化益生菌的局限性
    雖然市場上許多益生菌產品提供了通用的「有益菌」，但大多數是標準化的，也就是説，它們為每個人提供相同的菌株和劑量。然而，每個人的腸道微生物群都是獨特的，由飲食、生活方式和健康狀況等個體因素所塑造。標準化的益生菌並未考慮這些差異，往往導致要反覆試驗和錯誤的試用以及參差不齊的效果。此外，它們可能缺乏解決特定腸道失衡所需的特定菌株或組合，限制了它們在改善個人健康需求方面的有效性。

    == 選擇個人化的益生菌
    精準益生菌通過推薦最適合您的益生菌菌株，將個性化提昇到一個新的水平，這些菌株是根據您的獨特腸道微生物群和健康狀況定製的。通過先進的微生物群分析，我們能夠根據您的健康報告識別出對您最有益的特定細菌菌株。這種方法最大限度地提高了益生菌的效果，確保它們能解決您的個人腸道需求並支持您的健康目標——無論是改善消化、增強免疫力，還是平衡微生物群等。精準益生菌提供了一種有針對性、具科學支持的解決方案，幫助您實現更好的腸道健康和整體健康。
    #v(1cm)
    === 益生菌精準配方：\ 通過微生物群開創最佳健康方案
    #align(center)[我們的精準益生菌利用先進的科學技術，為您的整體健康提供高度有效的個性化支持。]
    #v(0.5em)

    #let precision-probiotics-box(symbolic, title, body) = box(
      fill: primary.darken(15%),
      width: 100%,
      height: 9cm,
      align(center, pad(top: 15pt, bottom: 20pt, x: 1.2em)[
        #set text(fill: white, hyphenate: false)
        #set par(justify: false)
        #image(symbolic)

        #text(size: 16pt)[*#title*]

        #align(center, body)
      ]),
    )
    #table(
      columns: (1fr, 1fr, 1fr),
      inset: 0pt,
      column-gutter: 20pt,
      stroke: none,
      precision-probiotics-box(
        "images/personalised-symbolic.png",
        "個人化",
      )[我們的精準益生菌根據您的獨特微生物群量身定製，將每種菌株與您的特定健康需求相匹配，提供個性化的腸道健康解決方案。],
      precision-probiotics-box(
        "images/precise-symbolic.png",
        "精確",
      )[通過先進的分析，我們找出您的腸道所需的確切益生菌，提供有針對性、具科學支持的方法來平衡您的微生物群。],
      precision-probiotics-box(
        "images/efficient-symbolic.png",
        "高效",
      )[為了達到最大效果，精準益生菌與您的獨特腸道狀況相契合，為長期腸道健康和整體健康帶來顯著結果。],
    )
  ]
]
