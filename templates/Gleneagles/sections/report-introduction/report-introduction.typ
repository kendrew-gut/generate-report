#import "../../lib.typ": *

#let report-introduction(section, report) = [
  #section-heading[#section.zh_hk\ #section.en]
  #box(
    fill: primary.transparentize(90%),
    inset: 8pt,
  )[Your gut microbiome is a unique ecosystem within your body, consisting of trillions of microorganisms, including bacteria, viruses, fungi, and other microbes, primarily residing in your intestines. These tiny organisms play a crucial role in maintaining overall health, influencing everything from digestion and immunity to mood and metabolism. Each person's gut microbiome is as unique as a fingerprint, shaped by factors such as diet, lifestyle, environment, and genetics.

    A balanced gut microbiome helps sustain a healthy digestive system, supports immune function, and even impacts mental well-being. However, when the gut microbiome becomes imbalanced --- often due to poor diet, stress, or antibiotic use --- it can lead to a range of health issues, from digestive discomfort and inflammation to chronic diseases.

    In this report, we will explore your gut microbiome in detail, helping you understand how it affects your health, and provide personalised recommendations to optimize it for a healthier, more balanced life.]

  == Gut Microbiome and Overall Health
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
    #figure-box(top + left, 20pt, 0pt, "images/gut-microbiome.png", font-size: 15pt)[Gut Microbiome]
    #place(bottom + left, dx: 60pt, dy: -35pt, image("images/curved-arrow-1.png"))
    #align(center, box(
      radius: 20pt,
      fill: primary.transparentize(90%),
      width: 250pt,
      height: 190pt,
    )[
      #figure-box(top + left, 35pt, 8pt, "images/food.png")[Food]
      #figure-box(top + right, -35pt, 8pt, "images/exercise.png")[Exercise]
      #figure-box(bottom + left, 35pt, -8pt, "images/habit.png")[Habit]
      #figure-box(bottom + right, -35pt, -8pt, font-size: 14.7pt, "images/supplement.png")[Supplement]
    ])
    #place(top + right, dx: -60pt, dy: 35pt, image("images/curved-arrow-2.png"))
    #figure-box(bottom + right, -20pt, 0pt, font-size: 13pt, "images/overall-health.png")[Overall Health]
  ]
  #v(0.5em)
  Each person's microbiome is unique. Understanding its composition can provide valuable insights into one's health. By identifying specific bacterial signatures and assessing their function, we can uncover potential imbalances that may be affecting well-being. This report provides an in-depth analysis of your unique microbiome profile and its relationship to various aspects of health, offering personalised recommendations to support a balanced and resilient gut ecosystem.

  We believe that nurturing the gut microbiome and maintaining gut health are fundamental to overall physical and mental wellness. Through this report, we provide actionable recommendations to help you achieve a healthier and more vibrant life.

  #pagebreak()

  #page(margin: (x: 0pt))[
    == Gut Microbiome Species
    #let gut-microbiome-species-tab(alignment, background-img, img, title, title-color, description) = context {
      let background = image(background-img)
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
              pad(left: 20pt)[
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
      [Probiotics are beneficial microorganisms for the human body, primarily including lactic acid bacteria. They maintain intestinal balance and promote nutrient absorption by inhibiting the growth of harmful bacteria, strengthening the gut barrier function, and enhancing immune responses. The human body requires probiotics to sustain a healthy gut environment.],
    )

    #gut-microbiome-species-tab(
      right,
      "images/commensal-bacteria-background.png",
      "images/commensal-bacteria.png",
      [共生菌 Commensal Bacteria],
      rgb("1C4A7D"),
      [Commensal bacteria refer to bacterial groups commonly present in the gut of healthy individuals. These bacteria play a crucial role in maintaining the stability and functionality of the gut microbial. They contribute to nutrient metabolism, help regulate intestinal pH, and enhance immune function. The presence of commensal bacteria is essential for maintaining human health.],
    )
    #gut-microbiome-species-tab(
      left,
      "images/harmful-bacteria-background.png",
      "images/harmful-bacteria.png",
      [有害菌 Harmful Bacteria],
      rgb("B83143"),
      [Pathogenic bacteria (harmful bacteria) are microorganisms that negatively impact health. These bacteria can cause infections, inflammation, and digestive issues in the gut. While they play roles in ecosystems, such as decomposing dead cells, an overabundance of them poses a health threat. Therefore, their numbers should be kept at appropriate levels.],
    )

    === Scientifically Assess the Balance of Gut Microbiome
    #pad(x: 1.8cm)[
      To truly understand gut health, it is essential to assess the microbiome by examining three key bacterial groups: pathogenic bacteria, commensal bacteria, and probiotics. The balance among these groups determines gut health, and merely measuring probiotics is insufficient. Even with adequate probiotics, an overgrowth of harmful bacteria or a deficiency of core bacteria can disrupt the harmony of the microbiome.
    ]
  ]

  #page(background: {
    place(bottom, box(
      width: 100%,
      height: 14.5cm,
      fill: primary.lighten(90%),
    ))
    standard-page-background(report)
  })[
    == Limitations of Standardised Probiotics
    While there are many probiotic products on the market, most of them are standardized—meaning they offer the same strains and dosages for everyone. However, each individual's gut microbiome is unique, shaped by personal factors such as diet, lifestyle, and health status. Standardized probiotics do not account for these differences, often leading to trial-and-error usage and inconsistent results. Moreover, they may lack the specific strains or combinations needed to address particular gut imbalances, limiting their effectiveness in meeting individualized health needs.

    == Choosing Personalised Probiotics
    Precision probiotics take Personalisation to a new level by recommending probiotic strains that are best suited for you, tailored to your unique gut microbiome and health profile. Through advanced microbiome analysis, we can identify specific bacterial strains that are most beneficial for you based on your health report. This approach maximizes the effectiveness of probiotics, ensuring they address your individual gut needs and support your health goals—whether it is improving digestion, boosting immunity, or balancing the microbiota. Precision probiotics offer a targeted, scientifically supported solution to help you achieve better gut health and overall wellness.
    #v(1.25cm)
    === Precision Probiotic Formulation:\ Optimizing Health Solutions Through Microbiome Science
    #align(center, box(
      width: 12.88cm,
    )[Our precision probiotics leverage advanced scientific technology to provide highly effective, personalised support for your overall wellness.])

    #let precision-probiotics-box(symbolic, title, body) = box(
      fill: primary.darken(15%),
      width: 100%,
      align(center, pad(y: 15pt, x: 8pt)[
        #set text(fill: white, hyphenate: true)
        #image(symbolic)

        #text(size: 16pt)[*#title*]

        #align(left, body)
      ]),
    )
    #table(
      columns: (1fr, 1fr, 1fr),
      inset: 0pt,
      column-gutter: 20pt,
      stroke: none,
      precision-probiotics-box(
        "images/personalised-symbolic.png",
        "Personalized",
      )[Our precision probiotics are tailored to your unique microbiome, matching with your specific health needs to deliver a personalised gut health solution.],
      precision-probiotics-box(
        "images/precise-symbolic.png",
        "Precise",
      )[Through advanced analysis, we identify the exact probiotics your gut requires, offering a targeted, science-backed approach to balancing your microbiome.],
      precision-probiotics-box(
        "images/efficient-symbolic.png",
        "Efficient",
      )[To maximize effectiveness, we select strains that align with your individual gut profile, delivering outcomes for long-term gut health and overall wellness.],
    )
  ]
]
