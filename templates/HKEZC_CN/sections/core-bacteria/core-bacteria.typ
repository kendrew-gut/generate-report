#import "../generic-bacteria/generic-bacteria.typ": generic-bacteria-section

#let core-bacteria(report) = generic-bacteria-section(
  report,
  report.core_bacteria,
  yaml("effects.yml"),
  section-heading: {
    let core-bacteria-len = report.core_bacteria.len()
    [*Core bacteria 核心菌 -- _#core-bacteria-len species/genus in total 共#{ core-bacteria-len }個菌種/屬_*]
  },
)
