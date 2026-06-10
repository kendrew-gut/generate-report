#import "../../lib.typ": *
#import "@preview/oxifmt:1.0.0": strfmt

#let appendix(section, report) = page[
  #section-heading[#section.zh_hk\ #section.en]

  #let abundant-bacteria-list(start: 0, end: none) = [
    #show table.cell: set text(size: 14pt)
    #show table.cell: set par(justify: false)
    #table(
      columns: (1fr, 1fr),
      stroke: primary,
      table.header(
        table.cell(
          fill: primary.lighten(70%),
          text(weight: "bold")[Bacterial Species],
        ),
        table.cell(
          fill: primary.lighten(70%),
          text(weight: "bold")[Relative Abudnance (%)],
        ),
      ),
      ..for species in report.top_50_species.slice(start, end) {
        (
          [#species.name],
          [#(strfmt("{:.3}", species.abundance * 100))],
        )
      },
    )
  ]
  #text(size: 18pt, fill: primary.darken(20%), weight: "extrabold")[最豐富的50種菌種 Top 50 Abundant Species]
  #abundant-bacteria-list(start: 0, end: 25)

  #pagebreak()

  #text(size: 18pt, fill: primary.darken(20%), weight: "extrabold")[最豐富的50種菌種 Top 50 Abundant Species]
  #abundant-bacteria-list(start: 25, end: none)

  #pagebreak()

  #page[
    #text(size: 18pt, fill: primary.darken(20%), weight: "extrabold")[文獻資料 References]
    #set text(size: 10pt)
    #rect(width: 100%, stroke: primary.darken(20%) + 1.5pt, inset: 1em)[
      Aslam, H., Marx, W., Rocks, T., Loughman, A., Chandrasekaran, V., Ruusunen, A.,... & Jacka, F. N. (2020). The effects of dairy and dairy derivatives on the gut microbiota: A systematic literature review. Gut microbes, 12(1), 1799533.

      Bubnov, R. V., Spivak, M. Y., Lazarenko, L. M., Bomba, A., & Boyko, N. V. (2015). Probiotics and immunity: provisional role for Personalised diets and disease prevention. EPMA Journal, 6, 1-11.

      Byerley, L. O., Samuelson, D., Blanchard IV, E., Luo, M., Lorenzen, B. N., Banks, S., ... & Taylor, C. M. (2017). Changes in the gut microbial communities following addition of walnuts to the diet. The Journal of nutritional biochemistry, 48, 94-102.

      Cani, P. D., & Delzenne, N. M. (2009). Interplay between obesity and associated metabolic disorders: new insights into the gut microbiota. Current opinion in pharmacology, 9(6), 737-743.

      Cattivelli, A., Nissen, L., Casciano, F., Tagliazucchi, D., & Gianotti, A. (2023). Impact of cooking methods of red-skinned onion on metabolic transformation of phenolic compounds and gut microbiota changes. Food & Function, 14(8), 3509-3525.

      Das, M., & Hyderabadwala, F. A. (2019). The study of prebiotic potential of peanuts and pistachios: The stimulatory effect on Lactobacillus growth. Journal of Pharmacognosy and Phytochemistry, 8(3), 2404-2407.

      Dinan, T. G., & Cryan, J. F. (2017). Brain-gut-microbiota axis and mental health. Psychosomatic medicine, 79(8), 920-926.

      Ettehad-Marvasti, F., Ejtahed, H. S., Siadat, S. D., Soroush, A. R., Hoseini-Tavassol, Z., Hasani-Ranjbar, S., & Larijani, B. (2022). Effect of garlic extract on weight loss and gut microbiota composition in obese women: A double-blind randomized controlled trial. Frontiers in Nutrition, 9, 1007506.

      Fabiano, G. A., Shinn, L. M., & Antunes, A. E. C. (2023). Relationship between Oat Consumption, Gut Microbiota Modulation, and Short-Chain Fatty Acid Synthesis: An Integrative Review. Nutrients, 15(16), 3534. https://doi.org/10.3390/nu15163534

      Haugland, R. A., Varma, M., Sivaganesan, M., Kelty, C., Peed, L., & Shanks, O. C. (2010). Evaluation of genetic markers from the 16S rRNA gene V2 region for use in quantitative detection of selected Bacteroidales species and human fecal waste by qPCR. Systematic and applied microbiology, 33(6), 348-357.

      Holscher, H. D., Guetterman, H. M., Swanson, K. S., An, R., Matthan, N. R., Lichtenstein, A. H., ... & Baer, D. J. (2018). Walnut consumption alters the gastrointestinal microbiota, microbially derived secondary bile acids, and health markers in healthy adults: a randomized controlled trial. The Journal of nutrition, 148(6), 861-867.

      Huang, H., Krishnan, H. B., Pham, Q., Yu, L. L., & Wang, T. T. Y. (2016). Soy and Gut Microbiota: Interaction and Implication for Human Health. Journal of Agricultural and Food Chemistry, 64(46), 8695--8709. https://doi.org/10.1021/acs.jafc.6b03725
      )
    ]
  ]

  #page[
    #text(size: 18pt, fill: primary.darken(20%), weight: "extrabold")[文獻資料 References]
    #set text(size: 10pt)
    #rect(width: 100%, stroke: primary.darken(20%) + 1.5pt, inset: 1em)[
      Järbrink-Sehgal, E., & Andreasson, A. (2020). The gut microbiota and mental health in adults. Current opinion in neurobiology, 62, 102-114.

      Jefferson, A., & Adolphus, K. (2019). The effects of intact cereal grain fibres, including wheat bran on the gut microbiota composition of healthy adults: a systematic review. Frontiers in nutrition, 6, 33.

      Lacombe, A., Li, R. W., Klimis-Zacas, D., Kristo, A. S., Tadepalli, S., Krauss, E., Young, R., & Wu, V. C. (2013). Lowbush wild blueberries have the potential to modify gut microbiota and xenobiotic metabolism in the rat colon. PloS one, 8(6), e67497. https://doi.org/10.1371/journal.pone.0067497

      Lazar, V., Ditu, L. M., Pircalabioru, G. G., Gheorghe, I., Curutiu, C., Holban, A. M., ... & Chifiriuc, M. C. (2018). Aspects of gut microbiota and immune system interactions in infectious diseases, immunopathology, and cancer. Frontiers in immunology, 9, 1830.

      Levy, M., Kolodziejczyk, A. A., Thaiss, C. A., & Elinav, E. (2017). Dysbiosis and the immune system. Nature Reviews Immunology, 17(4), 219-232.

      Liu, M., Li, X., Zhou, S., Wang, T. T., Zhou, S., Yang, K., ... & Wang, J. (2020). Dietary fibre isolated from sweet potato residues promotes a healthy gut microbiome profile. Food & function, 11(1), 689-699.

      Liu, Z., Lin, X., Huang, G., Zhang, W., Rao, P., & Ni, L. (2014). Prebiotic effects of almonds and almond skins on intestinal microbiota in healthy adult humans. Anaerobe, 26, 1-6.

      Nash, V., Ranadheera, C. S., Georgousopoulou, E. N., Mellor, D. D., Panagiotakos, D. B., McKune, A. J., Kellett, J., & Naumovski, N. (2018). The effects of grape and red wine polyphenols on gut microbiota --- A systematic review. Food Research International, 113, 277--287. https://doi.org/10.1016/j.foodres.2018.07.019

      Nguyen, S. M., Tran, T. D. C., Tran, T. M., Wang, C., Wu, J., Cai, Q., Ye, F., & Shu, X. -O. (2024). Influence of Peanut Consumption on the Gut Microbiome: A Randomized Clinical Trial. Nutrients, 16(19), 3313. https://doi.org/10.3390/nu16193313

      Malard, F., Dore, J., Gaugler, B., & Mohty, M. (2021). Introduction to host microbiome symbiosis in health and disease. Mucosal Immunology, 14(3), 547-554.

      Methiwala, H. N., Vaidya, B., Addanki, V. K., Bishnoi, M., Sharma, S. S., & Kondepudi, K. K. (2021). Gut microbiota in mental health and depression: Role of pre/pro/synbiotics in their modulation. Food & Function, 12(10), 4284-4314.

      Pang, W., Wang, D., Zuo, Z., Wang, Y., Sun, W., Zhang, N., & Zhang, D. (2022). Kidney Bean Fermented Broth Alleviates Hyperlipidemic by Regulating Serum Metabolites and Gut Microbiota Composition. Nutrients, 14(15), 3202. https://doi.org/10.3390/nu14153202

      Pérez-Burillo, S., Navajas-Porras, B., López-Maldonado, A., Hinojosa-Nogueira, D., Pastoriza, S., & Rufián-Henares, J. Á. (2021). Green Tea and Its Relation to Human Gut Microbiome. Molecules, 26(13), 3907. https://doi.org/10.3390/molecules26133907
    ]
  ]

  #page[
    #text(size: 18pt, fill: primary.darken(20%), weight: "extrabold")[文獻資料 References]
    #set text(size: 10pt)
    #rect(width: 100%, stroke: primary.darken(20%) + 1.5pt, inset: 1em)[
      Pradhan, S., Blanton, C., Ochoa-Reparaz, J., Bhattarai, N., & Sharma, K. (2024). Herbs and Spices: Modulation of Gut Microbiota for Healthy Aging. Gastroenterology Insights, 15(2), 447-458. https://doi.org/10.3390/gastroent15020032

      Ried, K., Travica, N., & Sali, A. (2018). The effect of kyolic aged garlic extract on gut microbiota, inflammation, and cardiovascular markers in hypertensives: The GarGIC Trial. Frontiers in nutrition, 5, 122.

      Rogers, G. B., Keating, D. J., Young, R. L., Wong, M. L., Licinio, J., & Wesselingh, S. (2016). From gut dysbiosis to altered brain function and mental illness: mechanisms and pathways. Molecular psychiatry, 21(6), 738-748.

      Rose, D. J. (2014). Impact of whole grains on the gut microbiota: the next frontier for oats?. British Journal of Nutrition, 112(S2), S44-S49.

      Singar, S., Kadyan, S., Patoine, C., Park, G., Arjmandi, B., & Nagpal, R. (2024). The Effects of Almond Consumption on Cardiovascular Health and Gut Microbiome: A Comprehensive Review. Nutrients, 16(12), 1964. https://doi.org/10.3390/nu16121964

      Singh, R. K., Chang, H. W., Yan, D. I., Lee, K. M., Ucmak, D., Wong, K., ... & Liao, W. (2017). Influence of diet on the gut microbiome and implications for human health. Journal of translational medicine, 15, 1-17.

      Singh, T. P., & Natraj, B. H. (2021). Next-generation probiotics: a promising approach towards designing Personalised medicine. Critical Reviews in Microbiology, 47(4), 479-498.

      Song, M. Y., Wang, J. H., Eom, T., & Kim, H. (2015). Schisandra chinensis fruit modulates the gut microbiota composition in association with metabolic markers in obese women: a randomized, double-blind placebo-controlled study. Nutrition research (New York, N.Y.), 35(8), 655--663. https://doi.org/10.1016/j.nutres.2015.05.001

      Stull, A. J., Cassidy, A., Djousse, L., Johnson, S. A., Krikorian, R., Lampe, J. W., ... & Tangney, C. (2024). The state of the science on the health benefits of blueberries: a perspective. Frontiers in Nutrition, 11, 1415737.

      Suta, S., Surawit, A., Mongkolsucharitkul, P., Pinsawas, B., Manosan, T., Ophakas, S., Pongkunakorn, T., Pumeiam, S., Sranacharoenpong, K., Sutheeworapong, S., Poungsombat, P., Khoomrung, S., Akarasereenont, P., Thaipisuttikul, I., Suktitipat, B., & Mayurasakorn, K. (2023). Prolonged Egg Supplement Advances Growing Child's Growth and Gut Microbiota. Nutrients, 15(5), 1143. https://doi.org/10.3390/nu15051143

      Vendrame, S., Guglielmetti, S., Riso, P., Arioli, S., Klimis-Zacas, D., & Porrini, M. (2011). Six-Week Consumption of a Wild Blueberry Powder Drink Increases Bifidobacteria in the Human Gut. Journal of Agricultural and Food Chemistry, 59(24), 12815--12820. https://doi.org/10.1021/jf2028686

      Yang, Q., Lyu, S., Xu, M., Li, S., Du, Z., Liu, X., Shang, X., Yu, Z., Liu, J., & Zhang, T. (2023). Potential Benefits of Egg White Proteins and Their Derived Peptides in the Regulation of the Intestinal Barrier and Gut Microbiota: A Comprehensive Review. Journal of Agricultural and Food Chemistry, 71(36), 13168--13180. https://doi.org/10.1021/acs.jafc.3c03230
    ]
  ]

  #page[
    #text(size: 18pt, fill: primary.darken(20%), weight: "extrabold")[指南和免責聲明 Guidelines & Disclaimer]
    #rect(width: 100%, stroke: primary.darken(20%) + 1.5pt, inset: 1em)[
      + 該報告不適用於診斷、治療、治癒任何 疾病。該報告僅供參考，不應用作診斷或治療的替代品。任何建議行動的有效性可能因個人身體狀況而異。
      + 該報告僅說明所提供的樣本，可能無法反映您的腸道微生物群的實際狀 態。它提供了您在樣本採集期間健康情況的快照，為過去的狀況提供了寶貴的見解，並對近期健康情況進行了潛在預測。
      + 腸道測試樣本的完整性可能受到一系列因素的影響，包括環境變數、收集或處理過程中的潛在污染以及儲存條件。這些變數可能會影響測試結果 的準確性和一致性。因此，建議謹慎解讀結果並尋求醫療保健專業人員的指導。
      + 請注意，腸道微生物組的研究是一項前沿活動，知識可能會不斷更新。 用於生成報告的機器學習演算法和基線也可能不斷更新。
      + 為報告收集的數據僅用於內部目的。對於因使用或依賴本報告或其內容 而造成的損害或傷害，我們不承擔任何責任。

      #set enum(start: 1)
      + This report is not intended for the diagnosis, treatment, or cure of any disease. It is for informational purposes only and should not be used as a substitute for professional diagnosis or treatment. The effectiveness of any suggested actions may vary depending on individual health conditions.
      + This report is based solely on the provided sample and may not reflect the actual state of your gut microbiota. It offers a snapshot of your health at the time of sample collection, providing valuable insights into past conditions and offering potential predictions for recent health status.
      + The integrity of gut test samples may be affected by a range of factors, including environmental variables, potential contamination during collection or processing, and storage conditions. These variables may impact the accuracy and consistency of test results. Therefore, results should be interpreted with caution, and guidance from a healthcare professional is recommended.
      + Please be aware that research on the gut microbiome is a rapidly advancing field, and knowledge is subject to continuous updates. The machine learning algorithms and baselines used to generate this report may also be regularly updated.
      + Data collected for this report is used for internal purposes only. We assume no liability for any damages or injuries resulting from the use of or reliance on this report or its contents.
    ]
  ]
]
