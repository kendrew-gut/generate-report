#import "../../lib.typ": *

#let disease-risks-assessment(section, report) = page(margin: (bottom: 0cm))[
  #section-heading[#section.zh_hk\ #section.en]

  #let baseline = 0
  #let elevated = 1
  #let risk-pill(risk: baseline) = box(
    radius: 50%,
    fill: if risk == baseline { constructive } else { destructive },
    inset: 1em,
    align(center + horizon, text(
      fill: if risk == baseline { on-constructive } else { on-destructive },
      weight: "bold",
    )[#(if risk == elevated { "較高風險" } else { "正常風險" })\ #(
        if risk == elevated { "Elevated Risk" } else { "Baseline Risk" }
      )]),
  )

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
  #let disease-group-summary(disease-group) = {
    let num-constituents = disease-group.diseases.len()
    grid(
      inset: 0pt,
      pad(x: 1em, stack(
        stack(dir: ltr, spacing: 1em, ..for constituent in disease-group.diseases {
          (
            rect(width: 6em, stroke: none, stack(
              image(disease-group-img.at(constituent)),
              v(0.5em),
              text(fill: secondary.darken(30%), weight: "bold", size: 12.5pt)[
                #set par(leading: 0.4em, justify: false)
                #constituent
              ],
            )),
          )
        }),
        pad(top: 0.5em, text(weight: "bold")[Your #disease-group.name Risk:]),
        pad(top: 0.7em, risk-pill(risk: disease-group.risk)),
      )),
    )
  }

  #let disease-domain-summary(
    disease-domain,
  ) = box(
    fill: neutral.lighten(70%),
    width: 100%,
    inset: 1em,
  )[
    #let name = (en: disease-domain.name, zh_hk: i18n.at(disease-domain.name).zh_hk)
    #text(fill: secondary.darken(30%), weight: "extrabold", size: 16pt)[#name.zh_hk #name.en]

    #align(center, stack(
      dir: ltr,

      ..for group in disease-domain.details.disease_groups {
        (
          disease-group-summary(
            group,
          ),
        )
      },
    ))
  ]

  #grid(
    columns: 2,
    gutter: 0.5em,
    ..for (i, domain) in report.disease_domains.enumerate() {
      (
        grid.cell(
          fill: neutral.lighten(70%),
          colspan: if i == 0 { 2 } else { 1 },
          box(
            disease-domain-summary(
              domain,
            ),
          ),
        ),
      )
    },
  )

  #pagebreak()

  == 腸道健康 Gut Health
  #set par(spacing: 1em)
  #set text(size: 10pt)

  #let disease-info-card(title: [], img: "", description: []) = box(
    width: 100%,
    inset: (left: 0.5em, right: 1em, y: 1em),
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
          size: 14pt,
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
        pad(left: 0.7em, top: 0.7em, par(leading: 0.4em, text(
          size: 11pt,
        )[*#id - #(i18n.at(bacteria.name).zh_hk)\ #bacteria.name*])),
        align(top + end, box(fill: rgb(deficient-abundant-colors.at(bacteria.level - 1)), width: 28%, pad(
          0.45em,
          align(center, par(leading: 0.3em, justify: false, text(
            size: 9pt,
            weight: "bold",
            fill: white,
          )[#deficient-abundant-caption.at(bacteria.level - 1).en])),
        ))),
      ),
      pad(0.7em, text(size: 9pt, bacteria-effect)),
    ),
  )

  #let bacteria-summary-grid(
    title: [],
    id-prefix: "PB",
    bacteria-effects-for: "Gut Health",
    bacteria-index-range: (0, 0),
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
            pad(bottom: 0.5em, text(fill: primary.darken(30%), weight: "bold", size: 14pt, title)),
          ),
        ),
        ..for (i, bacteria) in report
          .disease_domain_details
          .at(bacteria-effects-for)
          .slice(bacteria-start-index, bacteria-end-index)
          .enumerate() {
          (
            bacteria-summary([#id-prefix #(card-index-offset + i + 1)], bacteria, bacteria-effects.at(
              bacteria-start-index + i,
            )),
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
      risk: report
        .disease_domains
        .find(it => it.name == "Gut Health")
        .details
        .disease_groups
        .find(it => it.name == "Gastrointestinal Disease")
        .risk,
    )),
  )

  Gastrointestinal diseases refer to a range of conditions that affect the digestive system, including the stomach, intestines, and related organs. Common disorders include gastritis, gastric ulcers, gastroesopha-geal reflux disease, irritable bowel syndrome, inflammatory bowel disease, and digestive tract infections. The causes of these are diverse and that invlove poor diet, bacterial or viral infections, stress, genetic predisposition, and immune system abnormalities. Typical symptoms include abdominal pain, heartburn, nausea, vomiting, bloating, diarrhea, constipation, and unintended weight loss. Conditions like gastric ulcers, may be accompanied by bleeding or carry a risk of potentially progressing to cancer. Early diagnosis and treatment are crucial to preventing further complications. A healthy diet, regular physical activity, reducing stress, and avoiding harmful habits can help lower the risk of developing gastrointestinal diseases.

  #disease-info-card(
    title: [大腸激躁症 - 便祕型 Irritable Bowel Syndrome - Constipation / \
      大腸激躁症 - 腹瀉型 Irritable Bowel Syndrome - Diarrhea],
    description: [Irritable Bowel Syndrome (IBS) is a functional bowel disorder, with potential causes including abnormal intestinal motility, excessive stress, poor dietary habits, and imbalances in gut microbiota. Patients with IBS-Coften report bloating and a feeling of incomplete evacuation after defecation. Patients with the IBS-D mainly experience frequent acute episodes of diarrhea with urgent and sometimes uncontrollable bowel movements. Treaatment generally involves dietary modifications, increased fibre intake, and stress management strategies.

    ],
    img: "images/Irritable Bowel Syndrome.png",
  )
  #disease-info-card(
    title: [炎症性腸病 Inflammatory Bowel Disease (IBD)],
    description: [IBD is a group of chronic intestinal disorders caused by immune system abnormalities, primarily including Crohn's disease and ulcerative colitis. Common symptoms typically include abdominal pain, diarrhea, weight loss, and bloody stools. The causes of IBD are associated with genetic factors, immune system dysfunction, and environmental triggers. Patients experience persistent chronic inflammation in the intestines, which can lead to structural damage to the bowel. Treatment generally involves medications to control immune responses, anti-inflammatory drugs or surgical intervention.
    ],
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
      risk: report
        .disease_domains
        .find(it => it.name == "Gut Health")
        .details
        .disease_groups
        .find(it => it.name == "Colorectal Cancer")
        .risk,
    )),
  )
  #disease-info-card(
    title: [大腸癌 Colorectal cancer],
    description: [Colorectal cancer is one of the most common cancers that originates in the colon or rectum. Early detection and lifestyle modifications can significantly reduce the risk of developing it. Common symptoms include changes in bowel habits, blood in the stool, abdominal pain, unexplained weight loss, and fatigue. Our data model compares your microbiome profile with samples from healthy individuals and those with cancer.

      If your score indicates a higher risk, it suggests that your profile shares similarities with those found in cancer cases. It is advisable to consult a doctor for further detailed examinations. Also, increasing dietary fibre intake, limiting red and processed meats, and maintaining a healthy weight are crucial to lower the risk. A normal risk score indicates that your microbiome profile aligns more closely with healthy individuals. It is recommended to continue following a balanced diet to maintain a low risk level.
    ],
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
      risk: report
        .disease_domains
        .find(it => it.name == "Metabolism")
        .details
        .disease_groups
        .find(it => it.name == "Metabolic Disease")
        .risk,
    )),
  )

  Human Metabolism refers to the series of chemical reactions within cells that break down food to produce energy and synthesize or repair substances needed by the body. Metabolism is divided into two main categories: catabolism and anabolism. Catabolism involves breaking down nutrients from food into smaller molecules to release energy, while anabolism uses this energy to build and maintain bodily structures.

  When metabolism becomes imbalanced, it can lead to various diseases. For example, excessively fast metabolism may result in hyperthyroidism, while overly slow metabolism can cause hypothyroidism. Additionally, metabolic disorders are associated with chronic conditions such as diabetes, obesity, and hypertension. These diseases often stem from the body's improper processing of food and inefficient energy utilization.

  Maintaining metabolic balance is crucial for health. A balanced diet, regular exercise, and healthy lifestyle habits are essential for supporting normal metabolic function.

  #disease-info-card(
    title: [糖尿病 Diabetes],
    description: [Diabetes is a chronic metabolic disease characterized by abnormally elevated blood sugar levels, primarily classified into Type 1 and Type 2 diabetes.

      Type 1 diabetes results from insufficient insulin secretion and typically occurs in children or adolescents. Type 2 diabetes is associated with insulin resistance, commonly seen in adults, and is closely linked to obesity, genetics, diet, and lifestyle factors. Common symptoms include frequent urination, excessive thirst, weight loss, and fatigue. If not effectively managed, it may lead to complications such as cardiovascular and cerebrovascular diseases, kidney disease, and retinopathy.
    ],
    img: "images/Diabetes Disease.png",
  )

  #disease-info-card(
    title: [非酒精性脂肪肝 Non-Alcoholic Fatty Liver Disease],
    description: [Non-alcoholic fatty liver disease (NAFLD) refers to the accumulation of fat in the liver unrelated to excessive alcohol consumption. It is commonly seen in patients with metabolic syndrome, such as obesity, diabetes, and hyperlipidemia, while poor diet and lack of exercise are also major contributing factors. In its early stages, there are usually no obvious symptoms, though some patients may experience fatigue, loss of appetite, or discomfort in the upper right abdomen. As the condition progresses, it may lead to steatohepatitis, liver fibrosis, or even cirrhosis. Maintaining a healthy weight, improving dietary habits, and increasing physical activity can effectively prevent and alleviate this disease.
    ],
    img: "images/Non-Alcoholic Fatty Liver Disease.png",
  )

  #disease-info-card(
    title: [激素失調 Hormonal Imbalance],
    description: [Hormonal imbalance refers to an imbalance in the levels of hormones within the body, leading to abnormal physiological functions. It is relatively common, especially among young women. The causes are diverse, including genetic factors, unhealthy lifestyle habits, psychological stress, medication effects, and certain underlying medical conditions. Symptoms manifest as irregular menstruation, weight fluctuations, mood swings, fatigue, skin disorders (such as acne and eczema), among others, which can significantly impact the quality of life.
    ],
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
      bacteria-index-range: (7, 9),
      bacteria-effects: bacteria-effects-metabolism,
      id-prefix: "HB",
    )
    #bacteria-summary-grid(
      title: [共生菌 Commensal Bacteria],
      bacteria-effects-for: "Metabolism",
      bacteria-index-range: (9, 13),
      bacteria-effects: bacteria-effects-metabolism,
      id-prefix: "CB",
    )
  ]
  #box(
    fill: primary.lighten(90%),
    stroke: secondary.lighten(40%) + 1.5pt,
    inset: 1em,
  )[
    #bacteria-summary-grid(
      title: [共生菌 Commensal Bacteria],
      bacteria-effects-for: "Metabolism",
      bacteria-index-range: (13, none),
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
      risk: report
        .disease_domains
        .find(it => it.name == "Mental Health")
        .details
        .disease_groups
        .find(it => it.name == "Mental Disease")
        .risk,
    )),
  )

  Mental illnesses refer to a category of psychological or physiological disorders that affect an individual's thinking, emotions, and behaviour, often significantly impacting daily life and functioning. Their causes are complex and may involve genetic inheritance, environmental factors, psychological trauma, or imbalances in brain chemistry. Common mental illnesses include mood disorders, anxiety disorders, schizophrenia, and cognitive disorders. These conditions not only affect emotions and cognition but may also alter behaviour and social functioning, impacting quality of life.

  Methods for preventing mental illnesses include maintaining good mental health, reducing stress, anxiety, and emotional fluctuations. Actively participating in exercise and social activities, as well as maintaining regular daily routines, can also help enhance psychological resilience. For existing mental health issues, seeking timely professional assistance, such as psychological counseling or medication, can effectively improve the condition and prevent it from worsening.

  #disease-info-card(
    title: [睡眠障礙 Sleep Disorder],
    description: [Sleep disorders are conditions that affect the quality and duration of sleep, including insomnia and excessive daytime sleepiness. Common causes include excessive stress, anxiety, depression, irregular sleep patterns, underlying medical conditions, or medication side effects. Patients often experience difficulty falling asleep, frequent nighttime or early morning awakenings, or excessive daytime sleepiness. Long-term sleep disorders can lead to issues such as difficulty concentrating, emotional instability, and weakened immunity. Treatment methods include improving the sleep environment, adjusting lifestyle habits, psychological therapy, and medication intervention.
    ],
    img: "images/Sleep Disorder.png",
  )

  #disease-info-card(
    title: [焦慮症 Anxiety],
    description: [Anxiety is a common mental health condition characterized by excessive worry, tension, and fear. Its causes typically involve genetics, environmental stressors, life events, or imbalances in neurochemicals. Patients may experience symptoms such as rapid heartbeat, shortness of breath, sweating, and insomnia. Anxiety disorder not only affects daily life but may also trigger other mental health issues like depression. Treatment methods include cognitive-behavioural therapy, relaxation techniques, and anti-anxiety medications.
    ],
    img: "images/Anxiety Disease.png",
  )

  #disease-info-card(
    title: [抑鬱症 Depression],
    description: [Depression is a mood disorder typically characterized by persistent low mood, loss of interest, and feelings of hopelessness. Its causes include genetic factors, neurochemical imbalances, life stress, or significant life changes. Common symptoms include prolonged sadness, feelings of helplessness, difficulty concentrating, changes in appetite or sleep patterns, and even suicidal thoughts. Depression can severely impact an individual's work, family, and social functioning. Treatment methods include psychotherapy, antidepressant medications, and lifestyle adjustments.
    ],
    img: "images/Hormonal Imbalance.png",
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
      bacteria-effects: bacteria-effects-mental-health,
      id-prefix: "PB",
    )
    #bacteria-summary-grid(
      title: [共生菌 Commensal Bacteria],
      bacteria-effects-for: "Mental Health",
      bacteria-index-range: (5, none),
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
      risk: report
        .disease_domains
        .find(it => it.name == "Cognition")
        .details
        .disease_groups
        .find(it => it.name == "Cognitive Disease")
        .risk,
    )),
  )

  Cognitive disease refers to a set of symptoms characterized by significant decline in memory, thinking, judgment, language, and learning abilities, commonly associated with neurological disorders. The main types of cognitive  disease include mild cognitive impairment (MCI) and dementia. Its causes are diverse, encompassing aging, genetic factors, degenerative central nervous system diseases, cerebrovascular diseases, head trauma, infections, toxin exposure, as well as metabolic or nutritional abnormalities. Common symptoms include memory loss, difficulty concentrating, reduced judgment, challenges in language expression or comprehension, and inability to perform daily activities.

  As the condition worsens, it may be accompanied by mood swings, personality changes, and behavioural abnormalities. Preventing cognitive impairment requires attention to a healthy lifestyle, such as maintaining a balanced diet, engaging in regular physical exercise, actively participating in social and cognitive activities, managing chronic diseases, and avoiding harmful habits. Early diagnosis and intervention can slow disease progression and improve the patient's quality of life.

  #disease-info-card(
    title: [認知障礙 Cognitive Impairment],
    description: [Cognitive impairment refers to the gradual deterioration of abilities such as memory, learning, thinking, and problem-solving. It is commonly observed in older adults and may be associated with Alzheimer's disease or other neurodegenerative disorders. Contributing factors include aging, genetics, environmental influences, and lifestyle habits. Symptoms typically manifest as memory loss, language difficulties, and impaired judgment. Without timely intervention, cognitive decline can further impact daily life. Treatment options include medication, cognitive training, and lifestyle adjustments.
    ],
    img: "images/Cognitive Impairment.png",
  )

  #disease-info-card(
    title: [阿茲海默症 Alzheimer's Disease],
    description: [Alzheimer's disease is a neurodegenerative brain disorder associated with family history, cardiovascular diseases, and head trauma. Early symptoms include short-term memory loss, language difficulties, and disorientation. As the disease progresses, personality changes and incontinence may occur. This not only severely impacts the patient's ability to live independently but also places significant psychological and economic pressure on caregivers. Current treatments primarily involve medications such as cholinesterase inhibitors to slow cognitive decline, supplemented with non-pharmacological activities to improve mood.
    ],
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
      risk: report
        .disease_domains
        .find(it => it.name == "Autoimmunity")
        .details
        .disease_groups
        .find(it => it.name == "Autoimmunity Disease")
        .risk,
    )),
  )

  In Hong Kong, autoimmune diseases are gradually becoming one of the common health issues, affecting the lives of many people. Autoimmune diseases are not infectious but can cause various challenges for patients. Recent studies suggest that genetics, environmental factors, and immune system dysregulation may be significant contributors to the onset of autoimmune diseases. Due to the immune system's abnormal attacks on the body's own tissues and cells, autoimmune diseases can manifest in various symptoms such as fatigue, joint pain, and skin rashes. Early diagnosis and treatment are crucial for managing autoimmune diseases effectively.

  In addition to medication and immune-modulating therapies, lifestyle management also plays a vital role. When dealing with autoimmune diseases, understanding the nature of the condition and its treatment methods, actively collaborating with healthcare teams, seeking psychological support, and practicing self-management are all essential for the patient's recovery and quality of life.

  #disease-info-card(
    title: [過敏性疾病 Allergy],
    description: [Allergy result from the immune system overreacting to typically harmless external substances such as pollen, dust mites, or certain foods. The underlying mechanism primarily involves the abnormal activation of IgE antibodies and mast cells, leading to the release of large amounts of inflammatory mediators like histamine. These mediators cause vasodilation and increased cell permeability, resulting in classic symptoms such as nasal congestion, runny nose, itchy eyes, skin itching, and urticaria (hives). In severe cases, allergic reactions can progress to anaphylactic shock, characterized by difficulty breathing, rapid heartbeat, and low blood pressure.
    ],
    img: "images/Allergy Disease.png",
  )

  #disease-info-card(
    title: [濕疹 Eczema],
    description: [Eczema is a skin condition caused by an abnormal immune response. The pathogenesis involves the overactivation of immune cells and impairment of the skin barrier function, leading to exacerbated inflammatory reactions. Affected skin typically presents with dryness, intense itching, redness, swelling, and scaling. In severe cases, it may be accompanied by fissures and bleeding. This inflammation not only impacts appearance but also causes chronic itching that can lead to insomnia, while changes in skin appearance may affect self-confidence and social interactions. Treatment primarily focuses on moisturizing (using emollients) and may include topical corticosteroids, immunomodulators, or nutritional supplements as needed based on the severity of the condition.
    ],
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
      bacteria-effects: bacteria-effects-autoimmunity,
      id-prefix: "CB",
    )
  ]
  #box(
    fill: primary.lighten(90%),
    stroke: secondary.lighten(40%) + 1.5pt,
    inset: 1em,
  )[
    #bacteria-summary-grid(
      title: [共生菌 Commensal Bacteria],
      bacteria-effects-for: "Autoimmunity",
      bacteria-index-range: (14, none),
      bacteria-effects: bacteria-effects-autoimmunity,
      id-prefix: "CB",
    )
  ]
]
