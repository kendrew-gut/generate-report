#import "@preview/hydra:0.6.3": anchor, hydra
#import "@preview/oxifmt:1.0.0": strfmt
#import "@preview/cuti:0.4.0": cn-fakeitalic

#let numfmt(num, e-notation: true) = {
  if e-notation {
    let s = strfmt("{:.2E}", num)
    if s.contains("E-") {
      let (s1, exponent) = s.split("E-")
      s = s1 + "E-" + strfmt("{:0>2}", int(s.split("E-").at(1)))
    } else if s.contains("E") {
      let (s1, exponent) = s.split("E")
      s = s1 + "E+" + strfmt("{:0>2}", int(s.split("E").at(1)))
    }
    s
  } else {
    strfmt("{:.2}", num)
  }
}

#let rangefmt(range, e-notation: true) = {
  if range.lower == none {
    [<#numfmt(range.upper, e-notation: e-notation)]
  } else if range.upper == none {
    [>#numfmt(range.lower, e-notation: e-notation)]
  } else {
    [#numfmt(range.lower, e-notation: e-notation) -- #numfmt(range.upper, e-notation: e-notation)]
  }
}

#let date-format = "[day]/[month]/[year]"
#let to-date(s) = toml(bytes("date = " + s)).date

#let primary = rgb("5E8485")
#let cyan = rgb("329BA9")
#let bluegray = rgb("516978")

#let pill(radius: 50%, inset: (y: 1em, x: 0.5em), fill: primary, text-fill: white, width: auto, height: auto, body) = box(
  radius: radius,
  fill: fill,
  inset: inset,
  width: width,
  height: height,
  text(fill: text-fill, body),
)

#let style(body) = {
  show heading.where(level: 1): it => box(
    fill: primary,
    inset: (y: 0.8em, x: 0.8em),
    width: 100%,
    text(fill: white, size: 13pt, weight: "semibold", it),
  )
  show heading.where(level: 2): set text(size: 15pt, fill: primary, weight: "semibold")
  set text(size: 11pt, font: ("Inter", "Noto Serif HK"), weight: 400, features: ("cv05",), lang: "zh", region: "hk")
  set underline(offset: 0.17em)
  set par(justify: true)
  show math.equation: set text(font: "Inter")
  show ">=": math.gt.eq
  show "<=": math.lt.eq
  show emph: it => {
    show regex("\p{Han}"): cn-fakeitalic
    it
  }
  body
}

#let center-aligned-columns(..rows) = table(
  columns: 2,
  stroke: none,
  inset: 0em,
  gutter: 0.5em,
  ..for (i, content) in rows.pos().enumerate() {
    (align(if calc.rem(i, 2) == 0 { right } else { left } + bottom, content),)
  },
)

#let page-header(report) = {
  box(align(horizon, stack(
    dir: ltr,
    image("images/gutolution-logo-header.svg"),
    h(1cm),
    [*Gut Microbiome -- mNGS (metagenomic next generation sequencing)*\
      微生態全面測試---濕疹及過敏項目],
  )))
  line(length: 100%, stroke: primary + 0.13cm)
  align(top, text(size: 10pt, table(
    columns: (28%, 32%, 40%),
    stroke: none,
    text(size: 12pt)[*#report.client.name*],
    center-aligned-columns(
      [出生日期 DOB:],
      [*#report.client.date_of_birth.display(date-format)*],
      [性別 Gender:],
      [*#report.client.gender*],
    ),
    center-aligned-columns(
      [收集日期 Date of Collection:],
      [*#report.sample.collected_date.display(date-format)*],
      [報告日期 Report date:],
      [*#report.report_date.display(date-format)*],
    ),
  )))
}

#let page-footer = context {
  set par(spacing: 1em)
  line(length: 100%, stroke: 0.02cm)
  align(center, text(size: 10pt, weight: "semibold", counter(page).display()))
}

#let page-style(report) = {
  let f(it) = {
    set page(
      paper: "a4",
      header: page-header(report),
      header-ascent: 10%,
      footer: page-footer,
      footer-descent: 0.5em,
      margin: (top: 5.2cm, x: 1.2cm, bottom: 1.2cm),
      number-align: end,
    )
    it
  }

  f
}

#let arrow-down(width: 10pt) = {
  let height = width * calc.sqrt(3) / 2.2
  box(width: width, height: height, polygon(
    fill: gradient.linear(
      dir: ttb,
      bluegray.transparentize(100%),
      bluegray,
    ),
    (0pt, 0pt),
    (width, 0pt),
    (width / 2, height),
  ))
}
