#import "../generic-bacteria/generic-bacteria.typ": generic-bacteria-section

#let harmful-bacteria(report) = generic-bacteria-section(
  report,
  report.harmful_bacteria,
  yaml("effects.yml"),
  bacteria-group-name: (
    en-HK: "Harmful bacteria",
    zh-HK: "有害菌",
  ),
  section-heading: {
    let harmful-bacteria-len = report.harmful_bacteria.len()
    [*Harmful bacteria that are scientifically relevant to immunity and eczema -- #harmful-bacteria-len species in total*\ 科研上與免疫系統及濕疹有關連的有害菌 -- 共分析#{ harmful-bacteria-len }個菌種]
  },
  id-label: "HB"
)
