#import "lib.typ": *
#import "sections/front-cover/front-cover.typ": front-cover
#import "sections/introduction/introduction.typ": introduction
#import "sections/integrated-analysis/integrated-analysis.typ": integrated-analysis
#import "sections/core-bacteria/core-bacteria.typ": core-bacteria
#import "sections/harmful-bacteria/harmful-bacteria.typ": harmful-bacteria
#import "sections/probiotics/probiotics.typ": probiotics

#set document(
  title: [微生態全面測試--濕疹及過敏項目],
)

#let production = sys.inputs.at("production", default: false)
#let report = if production { json(sys.inputs.at("input_json")) } else {
  json("reference/reference.json")
}
#{
  report.client.date_of_birth = to-date(report.client.date_of_birth)
  report.sample.collected_date = to-date(report.sample.collected_date)
  report.report_date = to-date(report.report_date)
}

#show: style
#show: page-style(report)

#front-cover(report)

#counter(page).update(2)

#let sections = (
  introduction,
  integrated-analysis,
  core-bacteria,
  harmful-bacteria,
  probiotics
)

#for (i, section) in sections.enumerate() {
  section(report)
  if i != sections.len() - 1 { pagebreak() }
}
