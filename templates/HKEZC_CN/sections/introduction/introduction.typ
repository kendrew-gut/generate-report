#import "../../lib.typ": *

#let introduction(report) = page[
  = *mNGS (metagenomic next generation sequencing) technology – Comprehensive microbiome analysis in Hong Kong Science Park’s laboratory\ mNGS（次世代宏基因測序）技術 - 香港科學園實驗室微生物組分析*

  腸道微生物菌叢是生活在腸道中的微生物群體，在消化、免疫系統、大腦功能、新陳代謝和疾病預防方面發揮著至關重要的作用。腸道微生物菌叢失衡可能會引發如濕疹和過敏等多種健康問題。精準找出腸道微生物菌叢失衡狀況是預防這些問題的關鍵第一步。

  次世代宏基因測序技術能夠同時檢測多種微生物，不需要針對特定的目標序列或物種設計引物，因此可以檢測樣本中所有存在的微生物，包括未知或難以培養的微生物，較傳統技術優勝。次世代宏基因測序技術能夠鑑定到菌種甚至菌株水平，提供更精細的微生物群體組成信息，還能提供有關微生物代謝功能和基因組特徵的信息。在特定條件下可提供更準確的微生物相對豐度信息，特別是在分析多樣性高的樣本時。

  #{
    show table.cell.where(y: 0): it => pad(top: 2em, text(
      fill: primary,
      weight: "bold",
      size: 13.9pt,
      tracking: -0.05em,
      it,
    ))
    show table.cell.where(y: 1): it => pad(bottom: 2em, text(fill: primary, weight: "semibold", size: 14pt, it))
    table(
      columns: (1fr,) * 3,
      stroke: (x, y) => if y == 0 { (bottom: 1pt + primary) },
      inset: (x, y) => if y >= 2 { (left: 5pt, right: 23pt) } else { 5pt },
      [BIO-TECHNOLOGY], [MEDICAL R&D], [ARTIFICIAL INTELLIGENCE],
      [生物科技], [醫學研究], [人工智能],
      [了解人體的自然組織和演化，有助於我們解讀個人健康的複雜性。透過分析每個人獨特的身體機能，可以發現疾病背後的原因，並確定保持最佳健康狀態的必要條件。],
      [本檢測方法整合了全球研究人員和醫療保健專業人員的前沿發現。這種集體智慧有助於我們了解外部和內部生態系統，從而更深入地掌握個人的健康需求。],
      [我們的random forest人工智能模型在識別這些數據中的有意義模式方面發揮著至關重要的作用，幫助為每個人量身定制精準的健康解決方案。透過對這些資訊進行數位化和解碼，引領您走向更平衡、更健康的生活。],
    )
  }
  #v(1fr)
  #text(size: 8pt, fill: primary.darken(10%))[
    #underline(offset: 0.25em, stroke: 0.5pt)[*Disclaimer 免責聲明*]\
    Precision Probiotics Programs are not intended to diagnose, cure, or prevent any disease or medical condition. Our program is designed to support and optimize gut health but is not a substitute for medical advice from a licensed healthcare professional. The program has not been evaluated by the Food and Drug Administration (FDA) and we cannot make any claims regarding the safety or efficacy of our program for any specific medical condition. As with any supplement or health program, there are risks associated with any Precision Probiotics Program. Please consult with your healthcare provider before starting our program if you have any pre-existing medical conditions or medical circumstances.\
    精準益生菌計劃無意診斷、治療或預防任何疾病或病症。我們的計劃旨在支持和優化腸道健康，但不能取代持證醫療保健專業人員的醫療建議。本計劃未經美國食品藥物管理局評估，我們不能聲稱本計劃對任何特定病症的安全性或有效性。與任何補充劑或健康計劃一樣，任何精準益生菌計劃都存在相關風險。如果您有任何既往病症或醫療狀況，請在開始我們的計畫之前諮詢您的醫療保健提供者。
  ]
  #v(0.3cm)

  #pagebreak()

  = *The Role of the Gut-Brain-Skin Axis\ 【腸-腦-皮軸】的關係及針對處理濕疹及其他皮膚症狀之應用*


  The gut microbiome, comprising trillions of microorganisms, is no longer viewed as a mere local ecosystem, but rather as a key player in our overall health and well-being. Dysbiosis, or imbalance in the gut microbiome, has been implicated in various inflammatory skin conditions, including acne, atopic dermatitis, and psoriasis. The connection between the gut and skin is complex, involving multiple pathways and mechanisms, including:\
  由數萬億微生物組成的腸道微生物菌叢不再僅僅被視為局部生態系統，而是影響我們整體健康的關鍵之一。腸道微生物菌叢失衡與各種發炎性皮膚狀況有關，包括痤瘡、異位性皮膚炎和牛皮癬。腸道和皮膚之間的聯繫是複雜的，涉及多種途徑和機制，
  包括:

  #set par(spacing: 0.5cm)

  - *Metabolic pathways* 代謝途徑: The gut microbiome influences the skin through the production of short-chain fatty acids, which modulate the immune system and regulate inflammation. These metabolites also play a crucial role in maintaining the integrity of the skin barrier, regulating epidermal differentiation, and modulating the expression of genes involved in skin homeostasis.\ 腸道微生物菌叢透過產生短鏈脂肪酸來影響皮膚，短鏈脂肪酸可以調節免疫系統和調節發炎。這些代謝物在維持皮膚屏障的完整性、調節表皮分化和調節皮膚穩態相關的基因表現方面也起著至關重要的作用。

  - *Immunological pathways* 免疫途徑: The gut microbiome influences the immune system, regulating inflammation and modulating the immune response. The gut-associated lymphoid tissue (GALT) and skin-associated lymphoid tissue (SALT) are key components of the immune system, and dysbiosis can lead to impaired immune function and increased susceptibility to skin disorders.\ 腸道微生物菌叢影響免疫系統，調節發炎和免疫反應。腸道相關淋巴組織(GALT)和皮膚相關淋巴組織(SALT)是免疫系統的關鍵組成部分，生態失調可導致免疫功能受損和對皮膚疾病的敏感度增加。

  - *Neuroendocrine pathways* 神經內分泌途徑: The gut microbiome produces neurotransmitters and hormones, such as serotonin, dopamine, and cortisol, which influence mood, behavior, and skin health. The gut-brain-skin axis is a complex network of bidirectional communication, where the gut microbiome influences the brain, and the brain, in turn, influences the gut and skin.\ 腸道微生物菌叢產生神經傳導物質和激素，如血清素、多巴胺和皮質醇，它們影響情緒、行為和皮膚健康。腸-腦-皮軸是一個雙向交流的複雜網絡，腸道微生物菌叢會影響大腦，大腦反過來影響腸道和皮膚。

  #align(center, image("images/gut-brain-skin-axis.jpg"))

  #page(background: align(bottom, {
    box(height: 35%, fill: gray.lighten(70%), width: 100%)
  }))[
    = *The Limitations of Generic Probiotics\ 通用益生菌的局限性*

    Generic probiotics have long been touted as a solution for gut health, but they are often a one-size-fits-all approach. This can lead to inconsistent results and limited efficacy. Generic probiotics may not colonize the gut effectively, may not produce the desired metabolites, or may even exacerbate existing conditions. Furthermore, the gut microbiome is highly individualized, and what works for one person may not work for another.

    近年科學界對於腸道菌微生態有更深入研究，益生菌一直被視為腸道健康的解決方案，但往往是以同一款產品賣給所有不同種類的人。這可能導致成效的差異和有限的療效。益生菌可能無法有效地定植腸道，亦可能無法產生所需的代謝物，甚至有機會加劇現有的疾病。腸道微生物菌叢是高度個人化的，所以對一個人有效的益生菌可能對另一個人無效。

    = *The Importance of Precision Probiotics\ 精準益生菌的重要性*

    Precision probiotics have the potential to unlock the full potential of probiotics and transform the field of dermatology. By targeting the gut microbiome, we can restore microbial balance and alleviate symptoms of skin conditions. The use of advanced gut microbiome sequencing and AI technology is key to developing these precision probiotics.

    精準益生菌是解鎖益生菌潛力的契機，並為皮膚病學領域帶來重大改變。透過針對腸道微生物菌叢，我們可以恢復腸道微生物平衡，緩解皮膚症狀。而先進的腸道微生物菌叢測序和人工智能技術正正是開發精準益生菌關鍵。

    #v(1cm)
    #align(center)[
      *Microbiome Precision: Pioneering the Gut-Skin Axis with Probiotics\ Effectiveness on handling eczema and allergy cases*\
      #text(weight: 500)[精準微生態：利用益生菌開創【腸皮軸】\ 處理濕疹及敏感體質的有效性]

      #set text(fill: white, weight: "bold")
      #table(
        columns: (24%, 24%, 24%),
        gutter: 1.5cm,
        fill: (x, y) => if x == 0 {
          rgb("9BBCBE")
        } else if x == 1 {
          rgb("6C7A83")
        } else {
          rgb("5E8485")
        },
        stroke: none,
        inset: (x: 0.6em, y: 1.8em),
        [
          #image("images/personalized-care.png")
          #underline(offset: 0.25em)[個人化治療：]

          #text(
            size: 10pt,
          )[益生菌是根據患者的身體狀況和特定需求量身定制，當中考慮到患者獨特的腸道微生物菌叢特徵、遺傳傾向和環境因素。]
        ],
        [
          #image("images/precision.png")
          #underline(offset: 0.25em)[精準解決方案：]

          #text(
            size: 10pt,
          )[益生菌可以調節腸道微生物菌叢和調節免疫系統，為痤瘡、異位性皮膚炎、牛皮癬等特定皮膚狀況，提供針對性解決方案。]
        ],
        [
          #image("images/effectivness.png")
          #underline(offset: 0.25em)[提高療效：]

          #text(
            size: 10pt,
          )[精準益生菌的攝取有機會能透過最大限度地減少使用抗生素或其他苛刻的治療方法，來改善治療效果，並降低不良反應的風險。]
        ],
      )
    ]
  ]

  = *科學化了解腸道微生態 -- 為免疫系統提供更全面數據分析*
  #rect(stroke: primary + 1.5pt, inset: (y: 2em, x: 1em), width: 100%)[
  綜合分析 1）核心菌、2）有害菌、3）益生菌 以及 4）寄生蟲 四個主要因素之數據

  #show table.cell: set text(size: 10pt)
  #table(
    columns: (1fr,) * 2,
    gutter: 1cm,
    inset: 1em,
    stroke: none,
    fill: (x, y) => rgb(if (x, y) == (0, 0) {
      "C8D5FF"
    } else if (x, y) == (1, 0) {
      "FFCCCC"
    } else if (x, y) == (0, 1) {
      "C5FFC2"
    } else if (x, y) == (1, 1) {
      "DFC0FF"
    } else {
      "D9D9D9"
    }).transparentize(66%),
    [*因素一：核心菌*

      核心菌是在人體內常見且具有穩定生存能力的微生物群體，對維持微生物平衡、功能和人體健康起著重要作用。核心菌能與宿主相互作用，能夠抑制有害菌、促進營養吸收、支持免疫系統等。當核心菌群失衡時，可能導致免疫功能低下、過敏及炎症等問題。
    ],
    [*因素二：有害菌*

      腸道微生物菌叢中的致病細菌會破壞微生物平衡，導致感染、炎症及疾病。有害菌的主要來源包括受污染的食物和水、空氣中的病菌、接觸受感染的人或物體，以及環境中的污染物。它們能夠通過口腔、皮膚破損處或呼吸道等途徑進入人體，擾亂體內的微生物平衡，導致疾病。
    ],
    [*因素三：益生菌*

      益生菌是活的微生物，攝取足夠數量的益生菌可為宿主帶來健康益處。它們存在於發酵食品、膳食補充劑和特定乳製品中，透過與病原體抗爭、產生抗菌物質、調節免疫反應和強化腸道屏障等機制發揮作用。在飲食中包括富含益生菌的食物或補充劑，可以幫助消化系統健康，增強免疫系統，提高整體健康水平。
    ],
    [*因素四：寄生蟲*

      寄生蟲是指依賴宿主生存、從宿主體內或體外獲取養分的生物。它們通常會對宿主造成不同程度的損害，從輕微的不適到嚴重的疾病。它們通過各種方式進入宿主體內，如經由污染的食物或水源、直接接觸等。寄生蟲感染可導致貧血、過敏反應、免疫系統過度活躍或免疫功能受損、腹痛、腹瀉、噁心、嘔吐等問題。
    ],
    table.cell(colspan: 2)[
      *服用益生菌的科學*

      腸道微生物菌叢是生活在腸道中的微生物群體，在消化、免疫系統、大腦功能、新陳代謝和疾病預防方面發揮著至關重要的作用。腸道微生物菌叢失衡會導致一系列健康問題。為了防止這種情況的發生，我們的精準益生菌計畫旨在恢復平衡，促進腸道微生物菌叢的健康。透過改善消化和免疫功能，精準益生菌可以幫助您保持最佳狀態。益生菌是由細菌和酵母菌組成的有益微生物，服用益生菌可以改善腸道微生物菌叢的功能和整體平衡。我們體內的微生物菌叢龐大而複雜，因此我們的精準益生菌方案會根據您的腸道狀況精心挑選合適的益生菌。
    ],
  )]

]
