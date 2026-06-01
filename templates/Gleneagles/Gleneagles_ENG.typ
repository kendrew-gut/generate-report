#import "lib.typ": *
#import "sections/cover-page/cover-page.typ": cover-page
#import "sections/report-information/report-information.typ": report-information
#import "sections/table-of-contents/table-of-contents.typ": table-of-contents
#import "sections/report-introduction/report-introduction.typ": report-introduction
#import "sections/health-conditions-overview/health-conditions-overview.typ": health-conditions-overview
#import "sections/analysis-results-of-microbiome/analysis-results-of-microbiome.typ": analysis-results-of-microbiome
#import "sections/references.typ": references

#set document(
  title: [NGS Gut Microbiome\ Health Screening Report],
  author: "GUTolution Ltd.",
)

#let report = json("reference/NCHAV9190_Gleneagles_Report.json") + (
  ("user-name", "Ng Yuk Lin"),
  (
    "date",
    datetime(
      year: 2026,
      month: 4,
      day: 20,
    ),
  ),
  ("sex", "Female"),
  (
    "date-of-birth",
    datetime(
      year: 1865,
      month: 4,
      day: 14,
    ),
  ),
  ("sample-mass", 3.14159265),
  ("sample-quality", "A"),
  (
    "testing-date",
    datetime(
      year: 2026,
      month: 4,
      day: 13,
    ),
  ),
  ("testing-item", "NGS Gut Microbiome Health Screening Test"),
  (
    "sections",
    (
      (("en", "Report Introduction"), ("zh_hk", "報告介紹")).to-dict(),
      (("en", "Health Conditions Overview"), ("zh_hk", "健康情況總覽")).to-dict(),
      (("en", "Analysis Results of Microbiome"), ("zh_hk", "微生物組分析結果")).to-dict(),
      (("en", "Disease Risks Assessment"), ("zh_hk", "疾病風險評估")).to-dict(),
      (("en", "Personalised Nutrition Guidelines"), ("zh_hk", "個人化營養膳食指南")).to-dict(),
      (("en", "Appendix"), ("zh_hk", "附錄")).to-dict(),
    ),
  ),
).to-dict()

#show: style

#cover-page(report)

#counter(page).update(1)

#show: page-style(report)

#report-information(report)

#table-of-contents(report)

#show: body-style

#let sections = (report-introduction, health-conditions-overview, analysis-results-of-microbiome)

#counter(heading).update(1)
#for (i, section) in report.sections.enumerate() {
  let default-page(_, _) = warn[TODO. Do not release.]

  sections.at(i, default: default-page)(section, report)
  pagebreak()
}

#references(report)
