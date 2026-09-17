#import "../generic-bacteria/generic-bacteria.typ": generic-bacteria-section

#let probiotics(report) = generic-bacteria-section(
    report,
    report.probiotics,
    yaml("effects.yml"),
    section-heading: {
        let probiotics-len = report.probiotics.len()
        [*Probiotics that are scientifically relevant to immunity and eczema*\ 科研上與免疫系統及濕疹有關連的益生菌 - 共分析#{probiotics-len}個菌種]
    },
    bacteria-group-name: (
        en-HK: "Probiotics",
        zh-HK: "益生菌"
    ),
    id-label: "PE"
)