#import "../../lib.typ": *

#let disease-risks-assessment(section, report) = page(margin: (bottom: 0cm))[
  #section-heading[#i18n.at(section).zh_HK\ #section]

  #let disease-group-img = (
    "IBS - Diarrhea": "images/ibs-diarrhea.png",
    "IBS - Constipation": "images/ibs-constipation.png",
    "IBD": "images/ibd.png",
    "Colorectal Cancer": "images/colorectal-cancer.png",
    "Diabetes": "images/diabetes.png",
    "NAFLD": "images/nafld.png",
    "Hormonal Imbalance": "images/hormonal-imbalance.png",
    "Sleep Disorder": "images/sleep-disorder.png",
    "Anxiety": "images/anxiety.png",
    "Depression": "images/depression.png",
    "Cognitive Impairment": "images/cognitive-impairment.png",
    "Alzheimer's Disease": "images/alzheimers-disease.png",
    "Allergy": "images/allergy.png",
    "Eczema": "images/eczema.png",
  )

  #let disease-domains = (
    (
      name: "Gut Health",
      disease-groups: (
        (
          name: "Gastrointestinal Disease",
          risk: report.disease_domains.at("Gastrointestinal Disease"),
          diseases: (
            "IBS - Diarrhea",
            "IBS - Constipation",
            "IBD",
          ),
        ),
        (
          name: "Colorectal Cancer",
          risk: report.disease_domains.at("Colorectal Cancer"),
          diseases: (
            "Colorectal Cancer",
          ),
        ),
      ),
    ),
    (
      name: "Metabolism",
      disease-groups: (
        (
          name: "Metabolic Disease",
          risk: report.disease_domains.at("Metabolism"),
          diseases: (
            "Diabetes",
            "NAFLD",
            "Hormonal Imbalance",
          ),
        ),
      ),
    ),
    (
      name: "Mental Health",
      disease-groups: (
        (
          name: "Mental Disease",
          risk: report.disease_domains.at("Mental Health"),
          diseases: (
            "Sleep Disorder",
            "Anxiety",
            "Depression",
          ),
        ),
      ),
    ),
    (
      name: "Cognition",
      disease-groups: (
        (
          name: "Cognitive Disease",
          risk: report.disease_domains.at("Cognition"),
          diseases: (
            "Cognitive Impairment",
            "Alzheimer's Disease",
          ),
        ),
      ),
    ),
    (
      name: "Autoimmunity",
      disease-groups: (
        (
          name: "Autoimmunity Disease",
          risk: report.disease_domains.at("Autoimmunity"),
          diseases: (
            "Allergy",
            "Eczema",
          ),
        ),
      ),
    ),
  )

  #let disease-group-summary(disease-group) = {
    let num-constituents = disease-group.diseases.len()

    align(center + horizon, stack(
      box(height: 7em, align(top, stack(dir: ltr, spacing: 1em, ..for constituent in disease-group.diseases {
        (
          box(width: 6em, stroke: none, stack(
            image(disease-group-img.at(constituent)),
            v(0.5em),
            text(fill: secondary.darken(30%), weight: "bold", size: 12.5pt)[
              #set par(leading: 0.4em, justify: false)
              #i18n.at(constituent).zh_HK
            ],
          )),
        )
      }))),
      [*您的#(i18n.at(disease-group.name).zh_HK) 風險:*],
      pad(top: 0.5em, risk-pill(risk: disease-group.risk)),
    ))
  }

  #let disease-domain-summary(
    disease-domain,
  ) = pad(1em)[
    #let name = (en_HK: disease-domain.name, zh_HK: i18n.at(disease-domain.name).zh_HK)
    #text(fill: secondary.darken(30%), weight: "extrabold", size: 16pt)[#name.zh_HK #name.en_HK]

    #box(width: 100%, height: 12em, align(center + bottom, stack(
      dir: ltr,

      ..for group in disease-domain.disease-groups {
        (
          disease-group-summary(
            group,
          ),
        )
      },
    )))
  ]

  #grid(
    columns: 2,
    gutter: 0.5em,
    grid.cell(
      colspan: 2,
      fill: neutral.lighten(70%),
      pad(1em)[
        #let name = (en_HK: disease-domains.at(0).name, zh_HK: i18n.at(disease-domains.at(0).name).zh_HK)
        #pad(text(fill: secondary.darken(30%), weight: "extrabold", size: 16pt)[#name.zh_HK #name.en_HK])

        #align(left, stack(
          dir: ltr,
          spacing: 6.3em,
          ..for group in disease-domains.at(0).disease-groups {
            (
              align(left, stack(
                align(center, box(height: 7.5em, align(top, stack(dir: ltr, spacing: 0em, ..for constituent in (
                  group.diseases
                ) {
                  (
                    box(width: 6.5em, stroke: none, stack(
                      image(disease-group-img.at(constituent)),
                      v(0.5em),
                      text(fill: secondary.darken(30%), weight: "bold", size: 13pt)[
                        #set par(leading: 0.4em, justify: false)
                        #i18n.at(constituent).zh_HK
                      ],
                    )),
                  )
                })))),
                align(center, text(weight: "bold")[您的#(i18n.at(group.name).zh_HK)風險為:]),
                align(center, pad(top: 0.7em, risk-pill(risk: group.risk))),
              )),
            )
          },
        ))
      ],
    ),
    ..for (i, domain) in disease-domains.enumerate().slice(1) {
      (
        grid.cell(
          fill: neutral.lighten(70%),
          disease-domain-summary(
            domain,
          ),
        ),
      )
    },
  )

  #pagebreak()

  == 腸道健康 Gut Health
  #set par(spacing: 1em)
  #set text(size: 12pt)

  #let disease-info-card(title: [], img: "", description: []) = box(
    width: 100%,
    inset: (left: 0.7em, right: 1em, y: 1em),
    fill: primary.lighten(90%),
    grid(
      columns: (auto, 1fr),
      gutter: 0.5em,
      align: horizon,
      image(img),
      [#set par(spacing: 0.7em, leading: 0.4em)
        #text(
          fill: primary.darken(30%),
          weight: "bold",
          size: 13pt,
          title,
        )

        #description
      ],
    ),
  )


  #let bacteria-effects-gut-health = json("bacteria-effects-gut-health.json")
  #let bacteria-effects-metabolism = json("bacteria-effects-metabolism.json")
  #let bacteria-effects-mental-health = json("bacteria-effects-mental-health.json")
  #let bacteria-effects-cognition = json("bacteria-effects-cognition.json")
  #let bacteria-effects-autoimmunity = json("bacteria-effects-autoimmunity.json")

  #let bacteria-summary(id, bacteria, bacteria-effect) = grid.cell(
    stack(
      stack(
        dir: ltr,
        box(pad(left: 0.7em, top: 0.7em, par(leading: 0.7em, text(
          size: 11pt,
        )[*#id - #(i18n.at(bacteria.name).zh_HK)\ #text(size: 10pt, bacteria.name)*]))),
        align(top + right, pad(0.7pt, box(
          fill: rgb(deficient-abundant-colors.at(bacteria.level - 1)),
          width: 28%,
          height: 2em,
          pad(
            0.45em,
            align(center + horizon, par(leading: 0.3em, justify: false, text(
              size: 12pt,
              weight: "bold",
              fill: white,
            )[#deficient-abundant-caption.at(bacteria.level - 1).zh_HK])),
          ),
        ))),
      ),
      pad(0.7em, par(justify: false, leading: 0.4em, text(size: 9pt, bacteria-effect))),
    ),
  )

  #let bacteria-summary-grid(
    title: [],
    id-prefix: "PB",
    bacteria-effects-for: "Gut Health",
    bacteria-index-range: (0, 0),
    bacteria-id: range(0, 0),
    card-index-offset: 0,
    bacteria-effects: (none,),
  ) = {
    let (bacteria-start-index, bacteria-end-index) = bacteria-index-range
    if bacteria-end-index == none {
      bacteria-end-index = report.disease_domain_details.at(bacteria-effects-for).len()
    }
    let len = bacteria-end-index - bacteria-start-index
    assert(len >= 0)
    [
      #grid(
        columns: (1fr, 1fr),
        fill: (x, y) => if y != 0 and y * 2 + x < len + 2 { white },
        stroke: (x, y) => if y != 0 and y * 2 + x < len + 2 { secondary.darken(20%) + 1.5pt },
        grid.header(
          grid.cell(
            colspan: 2,
            pad(bottom: 0.7em, text(fill: primary.darken(30%), weight: "bold", size: 14pt, title)),
          ),
        ),
        ..for (i, bacteria) in report
          .disease_domain_details
          .at(bacteria-effects-for)
          .slice(bacteria-start-index, bacteria-end-index)
          .enumerate() {
          (
            bacteria-summary(
              [#id-prefix #bacteria-id.at(i, default: (card-index-offset + i + 1))],
              bacteria,
              bacteria-effects.at(
                bacteria-start-index + i,
              ),
            ),
          )
        },
      )
    ]
  }

  #grid(
    columns: (auto, 1fr, auto),
    align: horizon,
    par(leading: 0.5em, text(
      fill: secondary.darken(20%),
      size: 16pt,
      weight: "bold",
    )[您的胃腸道疾病測試結果\ Your Gastrointestinal Disease Risk]),
    grid.cell(align: end, risk-pill(
      risk: disease-domains
        .find(it => it.name == "Gut Health")
        .disease-groups
        .find(it => it.name == "Gastrointestinal Disease")
        .risk,
    )),
  )

  胃腸道疾病是指影響消化系統，包括胃、腸及相關器官（如食道、肝臟、膽囊和胰腺）功能的各類疾病。常見的胃腸道疾病包括胃炎、胃潰瘍、胃食道逆流病、腸易激綜合症、炎症性腸病及消化道感染等。這些疾病的發病原因多種多樣，可能與飲食不當、細菌或病毒感染、壓力、遺傳因素及免疫系統異常有關。常見的症狀包括腹痛、胃灼熱、噁心、嘔吐、腹脹、腹瀉、便秘及體重減輕等，某些疾病如胃潰瘍可能伴隨出血或潛在惡化為癌症的風險。早期診斷和治療對於控制症狀及預防進一步併發症至關重要。通過健康飲食、規律運動、減少壓力和避免不良生活習慣，可以降低胃腸道疾病的發生風險。

  #disease-info-card(
    title: [大腸激躁症 - 便祕型 Irritable Bowel Syndrome - Constipation / \
      大腸激躁症 - 腹瀉型 Irritable Bowel Syndrome - Diarrhea],
    description: [大腸激躁症是一種腸道功能性障礙，病因可能與腸道蠕動異常、壓力過大、飲食不當以及腸道菌群失衡有關。便秘型患者主要表現為便秘、腹痛和排便不規則，患者常感到腹脹，排便後無法完全排空。腹瀉型患者主要表現為腹瀉、腹痛和脹氣，導致頻繁的急性腹瀉，患者常感到排便迫切且不受控制。治療通常包括改變飲食結構、增加膳食纖維，以及緩解壓力。],
    img: "images/Irritable Bowel Syndrome.png",
  )
  #disease-info-card(
    title: [炎症性腸病 Inflammatory Bowel Disease (IBD)],
    description: [炎症性腸病是一組由免疫系統異常引起的慢性腸道疾病，包括克羅恩病和潰瘍性結腸炎。症狀通常有腹痛、腹瀉、體重減輕和血便。其發病原因與遺傳、免疫系統異常以及環境因素有關。患者的腸道會出現長期的慢性炎症，可能導致腸道結構損傷。治療方式通常包括藥物控制免疫反應、抗炎藥物和某些情況下需要手術。],
    img: "images/Inflammatory Bowel Disease.png",
  )

  #grid(
    columns: (auto, 1fr, auto),
    align: horizon,
    par(leading: 0.5em, text(
      fill: secondary.darken(20%),
      size: 16pt,
      weight: "bold",
    )[您的大腸癌風險測試結果\ Your Colorectal Cancer Risk]),
    grid.cell(align: end, risk-pill(
      risk: disease-domains
        .find(it => it.name == "Gut Health")
        .disease-groups
        .find(it => it.name == "Colorectal Cancer")
        .risk,
    )),
  )
  #disease-info-card(
    title: [大腸癌 Colorectal cancer],
    description: [大腸癌是一種發病於大腸的結腸或直腸的癌症。它是全球最常見的癌症之一。早期發現和改變生活方式可大幅降低罹患此疾病的風險。常見症狀包括排便習慣改變、便血、腹痛、不明原因的體重下降和疲勞。

    我們的數據模型會將您的微生物群組資料與健康樣本和結腸直腸癌患者的樣本進行比較。如果您的分數顯示風險較高，表示您的微生物組與大腸癌病例中的微生物組有相似之處。建議諮詢醫生按需要進行更詳細檢查，同時增加纖維攝取量、限制紅肉和加工肉類，以及保持健康體重以幫助降低風險是非常重要的。風險正常表示您的微生物組狀況更符合健康人的狀況，請繼續遵循均衡飲食以維持低風險。],
    img: "images/Colorectal Cancer.png",
  )

  #pagebreak()

  #par(leading: 0.5em, text(
    fill: secondary.darken(20%),
    size: 16pt,
    weight: "bold",
  )[腸道健康相關菌種\ Gut Health Related Strains])

  #box(
    fill: primary.lighten(90%),
    stroke: secondary.lighten(40%) + 1.5pt,
    inset: 1em,
  )[
    #bacteria-summary-grid(
      title: [益生菌 Probiotics],
      bacteria-effects-for: "Gut Health",
      bacteria-index-range: (0, 7),
      bacteria-effects: bacteria-effects-gut-health,
      id-prefix: "PB",
    )
    #bacteria-summary-grid(
      title: [有害菌 Pathogenic Bacteria],
      bacteria-effects-for: "Gut Health",
      bacteria-index-range: (7, 9),
      bacteria-effects: bacteria-effects-gut-health,
      id-prefix: "HB",
    )
    #bacteria-summary-grid(
      title: [共生菌 Commensal Bacteria],
      bacteria-effects-for: "Gut Health",
      bacteria-index-range: (9, 13),
      bacteria-effects: bacteria-effects-gut-health,
      id-prefix: "CB",
    )
  ]

  #pagebreak()
  #par(leading: 0.5em, text(
    fill: secondary.darken(20%),
    size: 16pt,
    weight: "bold",
  )[腸道健康相關菌種\ Gut Health Related Strains])
  #box(
    fill: primary.lighten(90%),
    stroke: secondary.lighten(40%) + 1.5pt,
    inset: 1em,
  )[
    #bacteria-summary-grid(
      title: [共生菌 Commensal Bacteria],
      bacteria-effects-for: "Gut Health",
      bacteria-index-range: (13, none),
      card-index-offset: 4,
      bacteria-effects: bacteria-effects-gut-health,
      id-prefix: "CB",
    )
  ]

  #pagebreak()

  == 代謝水平 Metabolism

  #grid(
    columns: (auto, 1fr, auto),
    align: horizon,
    par(leading: 0.5em, text(
      fill: secondary.darken(20%),
      size: 16pt,
      weight: "bold",
    )[您的代謝疾病測試結果\ Your Metabolic Disease Risk]),
    grid.cell(align: end, risk-pill(
      risk: disease-domains
        .find(it => it.name == "Metabolism")
        .disease-groups
        .find(it => it.name == "Metabolic Disease")
        .risk,
    )),
  )

  人體的新陳代謝是指細胞內一系列化學反應，這些反應幫助分解食物，產生能量，並合成或修復細胞所需的物質。新陳代謝分為兩大類：分解代謝與合成代謝。分解代謝是將食物中的營養分解成小分子以釋放能量；合成代謝則是利用這些能量建造和維護身體結構。
  
  當新陳代謝失衡時，可能會引發各種疾病。例如過快的新陳代謝會導致甲狀腺亢進症；而過慢的新陳代謝則可能導致甲狀腺功能低下症。此外，新陳代謝紊亂還與糖尿病、肥胖症、高血壓等慢性疾病有關。這些疾病往往與身體對食物的處理方式和能量利用不當有關。
  
  維持新陳代謝的平衡對健康至關重要，合理飲食、規律運動和良好作息有助於維持新陳代謝的正常運作。

  #disease-info-card(
    title: [糖尿病 Diabetes],
    description: [糖尿病是一種以血糖異常升高為特徵的慢性代謝疾病，主要分為1型和2型糖尿病。1型糖尿病由於胰島素分泌不足，通常出現於兒童或青少年；2型糖尿病與胰島素抵抗有關，通常見於成人，與肥胖、遺傳、飲食及生活方式密切相關。常見症狀包括多尿、口渴、體重下降、疲倦等。若未能有效控制，可能引發心腦血管疾病、腎病、視網膜病變等併發症。],
    img: "images/Diabetes Disease.png",
  )

  #disease-info-card(
    title: [非酒精性脂肪肝 Non-Alcoholic Fatty Liver Disease],
    description: [非酒精性脂肪肝（NAFLD）是指肝臟脂肪積聚，但與過量飲酒無關。常見於肥胖、糖尿病、高血脂等代謝綜合症患者，飲食不當、缺乏運動也是主要誘因。早期通常無明顯症狀，部分患者可能感到疲倦、食欲不振或右上腹不適。隨着病情進展，可能引發脂肪性肝炎、肝纖維化甚至肝硬化。保持健康體重、改善飲食、增加運動可有效預防和緩解此病。],
    img: "images/Non-Alcoholic Fatty Liver Disease.png",
  )

  #disease-info-card(
    title: [激素失調 Hormonal Imbalance],
    description: [荷爾蒙失調是指體內激素水平的不平衡，導致生理功能異常。其發病情況較為普遍，尤其在年輕女性中較為常見。發病原因多種多樣，包括遺傳因素、生活方式不健康、心理壓力、藥物影響以及某些基礎疾病。症狀表現為月經不規律、體重變化、情緒波動、疲勞、皮膚疾病（如痤瘡、濕疹）等，會顯著影響生活質量。],
    img: "images/Hormonal Imbalance.png",
  )

  #pagebreak()

  #par(leading: 0.5em, text(
    fill: secondary.darken(20%),
    size: 16pt,
    weight: "bold",
  )[代謝水平相關菌種\ Metabolism Related Strains])

  #box(
    fill: primary.lighten(90%),
    stroke: secondary.lighten(40%) + 1.5pt,
    inset: 1em,
  )[
    #bacteria-summary-grid(
      title: [益生菌 Probiotics],
      bacteria-effects-for: "Metabolism",
      bacteria-index-range: (0, 7),
      bacteria-effects: bacteria-effects-metabolism,
      id-prefix: "PB",
    )
    #bacteria-summary-grid(
      title: [有害菌 Pathogenic Bacteria],
      bacteria-effects-for: "Metabolism",
      bacteria-index-range: (7, 10),
      bacteria-effects: bacteria-effects-metabolism,
      id-prefix: "HB",
    )
    #bacteria-summary-grid(
      title: [共生菌 Commensal Bacteria],
      bacteria-effects-for: "Metabolism",
      bacteria-index-range: (10, 14),
      bacteria-effects: bacteria-effects-metabolism,
      id-prefix: "CB",
    )
  ]

  #pagebreak()
  #par(leading: 0.5em, text(
    fill: secondary.darken(20%),
    size: 16pt,
    weight: "bold",
  )[代謝水平相關菌種\ Metabolism Related Strains])
  #box(
    fill: primary.lighten(90%),
    stroke: secondary.lighten(40%) + 1.5pt,
    inset: 1em,
  )[
    #bacteria-summary-grid(
      title: [共生菌 Commensal Bacteria],
      bacteria-effects-for: "Metabolism",
      bacteria-index-range: (14, none),
      card-index-offset: 4,
      bacteria-effects: bacteria-effects-metabolism,
      id-prefix: "CB",
    )
  ]

  #pagebreak()

  == 精神健康 Mental Health

  #grid(
    columns: (auto, 1fr, auto),
    align: horizon,
    par(leading: 0.5em, text(
      fill: secondary.darken(20%),
      size: 16pt,
      weight: "bold",
    )[您的精神疾病測試結果\ Your Mental Disease Risk]),
    grid.cell(align: end, risk-pill(
      risk: disease-domains
        .find(it => it.name == "Mental Health")
        .disease-groups
        .find(it => it.name == "Mental Disease")
        .risk,
    )),
  )

  精神疾病是指一類影響個體思維、情感和行為的心理或生理障礙，通常會對日常生活和功能產生顯著影響。它們的成因複雜，可能涉及基因遺傳、環境因素、心理創傷或大腦化學物質的失衡。常見的精神疾病包括情感障礙（如抑鬱症、躁鬱症）、焦慮障礙（如恐懼症、強迫症）、精神分裂症以及認知障礙（如老年癡呆症）。這些疾病不僅影響情緒和認知，還可能改變個體的行為和社交功能，對生活質量造成影響。
  
  預防精神疾病的方法包括保持良好的心理健康，減少壓力、焦慮和情緒波動。積極參與運動和社交活動，保持規律的生活作息，也有助於增強心理韌性。對於已經出現的精神健康問題，及時尋求專業幫助，如心理諮詢或藥物治療，可以有效改善病情，避免病情加重。

  #disease-info-card(
    title: [睡眠障礙 Sleep Disorder],
    description: [睡眠障礙是一種影響睡眠質量和持續時間的疾病，包括失眠、過度嗜睡等。常見致病原因包括壓力過大、焦慮、抑鬱、作息不規律、疾病或藥物副作用。患者常表現為入睡困難、夜間醒來多次、早醒或白天嗜睡等。長期睡眠障礙可導致精神不集中、情緒不穩、免疫力下降等問題。治療方法包括改善睡眠環境、調整生活習慣、心理治療及必要的藥物干預。],
    img: "images/Sleep Disorder.png",
  )

  #disease-info-card(
    title: [焦慮症 Anxiety],
    description: [焦慮症是一種常見的精神健康障礙，表現為過度的擔憂、緊張和恐懼。致病原因通常涉及遺傳、環境壓力、生活事件或神經化學物質不平衡。患者可能會經歷心跳加速、呼吸急促、出汗、失眠等症狀。焦慮症不僅影響日常生活，還可能引發其他心理健康問題，如抑鬱症。治療方法包括認知行為療法、放鬆技巧、抗焦慮藥物等。],
    img: "images/Anxiety Disease.png",
  )

  #disease-info-card(
    title: [抑鬱症 Depression],
    description: [抑鬱症是一種情緒障礙，通常伴隨情緒低落、興趣喪失和無望感。其致病原因包括遺傳、神經化學失衡、生活壓力或重大生活變故。典型症狀包括持續的悲傷、無力感、注意力不集中、食慾或睡眠改變，甚至自殺念頭。抑鬱症可嚴重影響個人的工作、家庭和社交功能。治療方法包括心理治療、抗抑鬱藥物及生活方式調整。],
    img: "images/Depression Disease.png",
  )

  #pagebreak()

  #par(leading: 0.5em, text(
    fill: secondary.darken(20%),
    size: 16pt,
    weight: "bold",
  )[精神健康相關菌種\ Mental Health Related Strains])

  #box(
    fill: primary.lighten(90%),
    stroke: secondary.lighten(40%) + 1.5pt,
    inset: 1em,
  )[
    #bacteria-summary-grid(
      title: [益生菌 Probiotics],
      bacteria-effects-for: "Mental Health",
      bacteria-index-range: (0, 5),
      bacteria-id: (1, 3, 4, 6, 7),
      bacteria-effects: bacteria-effects-mental-health,
      id-prefix: "PB",
    )
    #bacteria-summary-grid(
      title: [共生菌 Commensal Bacteria],
      bacteria-effects-for: "Mental Health",
      bacteria-index-range: (5, none),
      bacteria-id: (9, 14, 16, 17, 19),
      bacteria-effects: bacteria-effects-mental-health,
      id-prefix: "CB",
    )
  ]

  #pagebreak()

  == 認知功能 Cognition

  #grid(
    columns: (auto, 1fr, auto),
    align: horizon,
    par(leading: 0.5em, text(
      fill: secondary.darken(20%),
      size: 16pt,
      weight: "bold",
    )[您的認知疾病測試結果\ Your Cognitive Disease Risk]),
    grid.cell(align: end, risk-pill(
      risk: disease-domains
        .find(it => it.name == "Cognition")
        .disease-groups
        .find(it => it.name == "Cognitive Disease")
        .risk,
    )),
  )

  認知障礙是指個體在記憶、思維、判斷、語言及學習能力等方面出現顯著衰退的一組症狀，常見於神經系統疾病。認知障礙的主要類型包括輕度認知障礙和癡呆。其發病原因多樣，包括年齡增長、遺傳因素、中樞神經系統退化性疾病、腦血管病、頭部外傷、感染、毒素暴露及代謝或營養異常。常見的症狀有記憶力減退、難以集中注意力、判斷力下降、語言表達或理解困難，以及無法完成日常活動。
  
  病情加重時可能伴隨情緒波動、人格改變及行為異常。預防認知障礙需關注健康生活方式，如均衡飲食、規律運動、積極參與社交及認知活動、控制慢性疾病和戒除不良習慣。早期診斷和干預能延緩病程並提高患者的生活質量。

  #disease-info-card(
    title: [認知障礙 Cognitive Impairment],
    description: [認知能力下降是指人們在記憶、學習、思維及解決問題等方面的能力逐漸減退。常見於老年人，並可能與阿茲海默病或其他神經退行性疾病有關。致病原因包括年齡、基因、環境因素及生活習慣等。症狀通常表現為記憶力減退、言語困難、判斷力差等。認知能力下降若未及時干預，可能進一步影響日常生活。治療包括藥物治療、認知訓練及生活方式調整。],
    img: "images/Cognitive Impairment.png",
  )

  #disease-info-card(
    title: [阿茲海默症 Alzheimer's Disease],
    description: [阿茲海默症是一種大腦神經退化疾病，與家族病史、心血管疾病、頭部外傷有關。症狀初期為短期記憶喪失、言語困難及定向力障礙，隨病程發展會出現性格改變及失禁。這不僅嚴重影響患者的獨立生活能力，也對照護者造成巨大的心理與經濟壓力。目前治療以膽鹼酶抑制劑等藥物延緩認知退化，並輔以非藥物活動改善情緒。],
    img: "images/Alzheimer's Disease.png",
  )

  #pagebreak()

  #par(leading: 0.5em, text(
    fill: secondary.darken(20%),
    size: 16pt,
    weight: "bold",
  )[認知功能相關菌種\ Cognition Related Strains])

  #box(
    fill: primary.lighten(90%),
    stroke: secondary.lighten(40%) + 1.5pt,
    inset: 1em,
  )[
    #bacteria-summary-grid(
      title: [益生菌 Probiotics],
      bacteria-effects-for: "Cognition",
      bacteria-index-range: (0, 7),
      bacteria-effects: bacteria-effects-cognition,
      id-prefix: "PB",
    )
    #bacteria-summary-grid(
      title: [共生菌 Commensal Bacteria],
      bacteria-effects-for: "Cognition",
      bacteria-index-range: (7, none),
      bacteria-id: (10, 16, 17),
      bacteria-effects: bacteria-effects-cognition,
      id-prefix: "CB",
    )
  ]

  #pagebreak()

  == 自體免疫 Autoimmunity

  #grid(
    columns: (auto, 1fr, auto),
    align: horizon,
    par(leading: 0.5em, text(
      fill: secondary.darken(20%),
      size: 16pt,
      weight: "bold",
    )[您的自體免疫疾病測試結果\ Your Autoimmune Disease Risk]),
    grid.cell(align: end, risk-pill(
      risk: disease-domains
        .find(it => it.name == "Autoimmunity")
        .disease-groups
        .find(it => it.name == "Autoimmunity Disease")
        .risk,
    )),
  )

  在香港，自體免疫疾病逐漸成為常見的健康問題之一，影響着許多人的生活。自體免疫疾病並非傳染性疾病，但會給患者帶來諸多困擾。近年的研究表明，遺傳、環境因素以及免疫系統失調可能是自體免疫疾病發病的重要原因之一。由於免疫系統的異常攻擊自身組織和細胞，自體免疫疾病可能表現為不同的症狀，如疲勞、關節疼痛、皮疹等。早期診斷和治療對於管理自體免疫疾病至關重要。
  
  除了藥物治療和免疫調節療法外，生活方式管理也是重要的一環。在處理自體免疫疾病時，了解疾病的性質和治療方法，積極與醫療團隊合作，尋求心理支持和進行自我管理都對患者的康復和生活質量至關重要。

  #disease-info-card(
    title: [過敏性疾病 Allergy],
    description: [過敏性疾病是免疫系統對通常無害的外界物質（如花粉、塵蟎、某些食物等）產生過度反應的結果。其發病機制主要涉及IgE抗體和肥大細胞的異常激活，導致大量炎症介質（如組胺）的釋放。這些介質引起血管擴張、細胞滲透性增加，從而導致典型症狀，如鼻塞、流涕、眼睛發癢、皮膚瘙癢及蕁麻疹。在嚴重情況下，過敏反應可能導致過敏性休克，表現為呼吸困難、心跳加速和低血壓。],
    img: "images/Allergy Disease.png",
  )

  #disease-info-card(
    title: [濕疹 Eczema],
    description: [濕疹是由免疫系統異常反應引起的皮膚疾病。發病機制包括免疫細胞的過度激活以及皮膚屏障功能的受損，導致炎症反應加劇。患者的皮膚通常表現為皮膚乾燥、劇烈搔癢、紅腫、脫屑，嚴重時可能伴隨裂口和出血。這種炎症不僅影響外觀，長期搔癢還會導致失眠，並因皮膚外觀影響心理自信與社交。治療方法以保濕（潤膚劑）為基礎，並視病情使用類固醇藥膏、免疫調節劑或營養補充品。],
    img: "images/Eczema Disease.png",
  )

  #pagebreak()

  #par(leading: 0.5em, text(
    fill: secondary.darken(20%),
    size: 16pt,
    weight: "bold",
  )[自體免疫相關菌種\ Autoimmunity Related Strains])

  #box(
    fill: primary.lighten(90%),
    stroke: secondary.lighten(40%) + 1.5pt,
    inset: 1em,
  )[
    #bacteria-summary-grid(
      title: [益生菌 Probiotics],
      bacteria-effects-for: "Autoimmunity",
      bacteria-index-range: (0, 4),
      bacteria-id: (1, 4, 6, 7),
      bacteria-effects: bacteria-effects-autoimmunity,
      id-prefix: "PB",
    )
    #bacteria-summary-grid(
      title: [有害菌 Pathogenic Bacteria],
      bacteria-effects-for: "Autoimmunity",
      bacteria-index-range: (4, 8),
      bacteria-effects: bacteria-effects-autoimmunity,
      id-prefix: "HB",
    )
    #bacteria-summary-grid(
      title: [共生菌 Commensal Bacteria],
      bacteria-effects-for: "Autoimmunity",
      bacteria-index-range: (8, 14),
      bacteria-id: (1, 4, 6, 10, 11, 12),
      bacteria-effects: bacteria-effects-autoimmunity,
      id-prefix: "CB",
    )
  ]

  #pagebreak()
  #par(leading: 0.5em, text(
    fill: secondary.darken(20%),
    size: 16pt,
    weight: "bold",
  )[自體免疫相關菌種\ Autoimmunity Related Strains])
  #box(
    fill: primary.lighten(90%),
    stroke: secondary.lighten(40%) + 1.5pt,
    inset: 1em,
  )[
    #bacteria-summary-grid(
      title: [共生菌 Commensal Bacteria],
      bacteria-effects-for: "Autoimmunity",
      bacteria-index-range: (14, none),
      bacteria-id: range(13, 21),
      bacteria-effects: bacteria-effects-autoimmunity,
      id-prefix: "CB",
    )
  ]
]
