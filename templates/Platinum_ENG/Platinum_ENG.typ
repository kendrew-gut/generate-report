#import "lib.typ": *
#import "front-cover/front-cover.typ": front-cover
#import "at-a-glance/at-a-glance.typ": at-a-glance
#import "pathogen-opportunistic-bacteria/pathogen-opportunistic-bacteria.typ": pathogen-opportunistic-bacteria
#import "intestinal-health-markers/intestinal-health-markers.typ": intestinal-health-markers
#import "microbial-ecosystem-overview/microbial-ecosystem-overview.typ": microbial-ecosystem-overview
#import "non-bacterial-members/non-bacterial-members.typ": non-bacterial-members
#import "commensal-keystone-bacteria/commensal-keystone-bacteria.typ": commensal-keystone-bacteria
#import "probiotic-bacterial-members/probiotic-bacterial-members.typ": probiotic-bacterial-members
#import "scfa-producers/scfa-producers.typ": scfa-producers
#import "inflammatory-microbiome/inflammatory-microbiome.typ": inflammatory-microbiome
#import "fifty-abundant-species/fifty-abundant-species.typ": fifty-abundant-species
#import "appendix/appendix.typ": appendix
#import "back-cover/back-cover.typ": back-cover

#set document(
  title: [GUTolution™ Microbiome Test Platinum],
)

#let production = sys.inputs.at("production", default: false)
#let report = if production { json(sys.inputs.at("input_json")) } else {
  json("reference/MEJAV9497_platinum_report.json")
}
#{
  report.sample_collected_date = to-date(report.sample_collected_date)
  report.client.date_of_birth = to-date(report.client.date_of_birth)
  let phylum_composition_sum = report.microbial_ecosystem.phylum_composition.map(phylum => phylum.abundance).sum()
  if phylum_composition_sum < 100 {
    report.microbial_ecosystem.phylum_composition.push((
      name: "Others",
      abundance: 100 - phylum_composition_sum,
    ))
  }
}

#show: style

#front-cover(report)

#counter(page).update(2)

#show: page-style

#let sections = (
  at-a-glance,
  pathogen-opportunistic-bacteria,
  intestinal-health-markers,
  non-bacterial-members,
  microbial-ecosystem-overview,
  commensal-keystone-bacteria,
  probiotic-bacterial-members,
  scfa-producers,
  inflammatory-microbiome,
  fifty-abundant-species,
  appendix,
  back-cover,
)

#for (i, section) in sections.enumerate() {
  section(report)
  if i != sections.len() - 1 { pagebreak() }
}
