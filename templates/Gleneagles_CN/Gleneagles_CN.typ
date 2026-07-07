#import "lib.typ": *
#import "sections/cover-page/cover-page.typ": cover-page
#import "sections/report-information/report-information.typ": report-information
#import "sections/table-of-contents/table-of-contents.typ": table-of-contents
#import "sections/report-introduction/report-introduction.typ": report-introduction
#import "sections/health-conditions-overview/health-conditions-overview.typ": health-conditions-overview
#import "sections/analysis-results-of-microbiome/analysis-results-of-microbiome.typ": analysis-results-of-microbiome
#import "sections/disease-risks-assessment/disease-risks-assessment.typ": disease-risks-assessment
#import "sections/personalised-nutrition-guidelines/personalised-nutrition-guidelines.typ": (
  personalised-nutrition-guidelines,
)
#import "sections/appendix/appendix.typ": appendix

#set document(
  title: [NGS 腸道微生態\ 健康監測報告],
  author: "GUTolution Ltd.",
)

#let production = sys.inputs.at("production", default: false)
#let input-json = if production { sys.inputs.at("input_json") } else { "reference/reference.json" }
#let report = (
  json(input-json)
    + (
      product: "NGS Gut Microbiome Health Screening Test",
      sections: (
        "Report Introduction",
        "Health Conditions Overview",
        "Analysis Results of Microbiome",
        "Disease Risks Assessment",
        "Personalised Nutrition Guidelines",
        "Appendix"
      )
    )
)
#{
  report.report_information.date_of_report = to-date(report.report_information.date_of_report)
  report.report_information.date_collected = to-date(report.report_information.date_collected)
  report.report_information.date_of_birth = to-date(report.report_information.date_of_birth)
}

#show: style

#cover-page(report)

#counter(page).update(1)

#show: page-style(report)

#report-information(report)

#table-of-contents(report)

#show: body-style

#let sections = (
  report-introduction,
  health-conditions-overview,
  analysis-results-of-microbiome,
  disease-risks-assessment,
  personalised-nutrition-guidelines,
  appendix,
)

#counter(heading).update(1)
#for (i, section) in report.sections.enumerate() {
  let default-page(_, _) = warn[TODO. Do not release.]

  sections.at(i, default: default-page)(section, report)
  if i != report.sections.len() - 1 { pagebreak() }
}
