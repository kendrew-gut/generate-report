#import "@preview/hydra:0.6.2": hydra

#let date-format = "[day]/[month]/[year]"
#let neutral = rgb("#B0BDC1")
#let primary = rgb("#44b6bd")
#let secondary = rgb("#3b88c3")

#let subtitle(body) = text(body, weight: "extrabold", size: 16pt, fill: neutral.darken(45%))
#let header-text(body) = text(body, weight: "extrabold", size: 12pt, fill: primary.darken(20%).transparentize(15%))
#let footer-text(body) = text(body, size: 14pt, fill: neutral)

#let section-heading(body, is-numbered-section: true) = align(center, context {
  if is-numbered-section {
    counter(heading).step()
  }
  [= #if is-numbered-section [#counter(heading).get().first()\.] else [] #underline(body)]
})

#let leftpad(len, pad, s) = {
  if str(s).len() < len {
    leftpad(len, pad, pad + str(s))
  } else {
    s
  }
}

#let is-alpha(s) = {
  for c in s {
    if not ((c >= "A" and c <= "Z") or (c >= "a" and c <= "z")) {
      return false
    }
  }
  true
}

#let longest-alpha-sequence(s) = {
  s.split(" ").filter(substr => is-alpha(substr)).join(" ")
}

#let to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let warn(body) = page(align(center, box(
  width: 200pt,
  fill: red.lighten(50%),
  radius: 7pt,
  table(
    columns: (30%, 70%),
    stroke: none,
    align: center + horizon,
    text(size: 30pt)[⛔️], text(fill: red.darken(50%), body),
  ),
)))

#let standard-page-background(report) = context {
  align(top)[
    #image("images/header-background.png")
    #place(top + start, pad(top: 8pt, left: 8pt, image("images/gleneagles-header-logo-full.png")))
    #place(top + end, pad(top: 20pt, right: 15pt, header-text[
      NGS 腸道微生態檢測\
      NGS Gut Microbiome Health Screening Test
    ]))
    #header-text[User Name |] #h(1em)#report.user-name #h(4em) #header-text[Report Date |] #h(
      1em,
    )#report.date.display(
      date-format,
    )
    #place(bottom, box(
      height: 40pt,
      width: 100%,
      align(horizon, footer-text(table(
        columns: (1fr, auto, 70pt),
        gutter: 0pt,
        inset: 0pt,
        stroke: none,
        line(stroke: (paint: primary, dash: "dotted", thickness: 2pt), length: 100%),
        pad(x: 15pt, {
          let heading-components = hydra(1, skip-starting: false, use-last: true)
          let a = to-string(heading-components)
          if heading-components != none {
            longest-alpha-sequence(to-string(heading-components))
          }
        }),
        align(
          left,
        )[*#text(fill: primary.darken(20%))[#{ counter(page).display() }] / #{ counter(page).final().at(0) }*],
      ))),
    ))
  ]
};

#let bad-excellent = 1
#let excellent-bad = -1
#let default-colors = ("CF887C", "987AAB", "7C91A6", "EBC1A8", "A6BAAF")
#let generic-caption = (
  (("en", "Bad"), ("zh_hk", "很差")).to-dict(),
  (("en", "Fair"), ("zh_hk", "較差")).to-dict(),
  (("en", "Average"), ("zh_hk", "中等")).to-dict(),
  (("en", "Good"), ("zh_hk", "良好")).to-dict(),
  (("en", "Excellent"), ("zh_hk", "優秀")).to-dict()
)
#let slider(
  value: 0,
  semantics: bad-excellent,
  color-scheme: default-colors,
  caption-scheme: none,
  width: 100%,
) = context {
  assert(0 <= value and value < 5)
  assert(color-scheme.len() == 5)
  assert(caption-scheme == none or caption-scheme.len() == 5)

  let bar-colour(value, semantics: bad-excellent) = if semantics == bad-excellent {
    rgb(color-scheme.at(value))
  } else {
    bar-colour(4 - value)
  }
  let caption(value, semantics: bad-excellent) = if caption-scheme == none { "" } else {
    if semantics == bad-excellent {
      caption-scheme.at(value).en
    } else {
      caption(4 - value)
    }
  }
  let arrow-down = image("images/arrow-down.png")
  let slider-slice(this-value) = stack(
    align(center, if this-value == value { arrow-down } else { box(height: measure(arrow-down).height) }),
    box(
      width: 100%,
      height: 12pt,
      radius: (left: if this-value == 0 { 50% } else { 0% }, right: if this-value == 4 { 50% } else { 0% }),
      fill: bar-colour(this-value, semantics: semantics),
    ),
    v(2em),
    align(center, text(size: 16pt, fill: bar-colour(this-value, semantics: semantics), weight: "bold", caption(
      this-value,
      semantics: semantics,
    ))),
  )

  box(width: width, table(
    columns: range(5).map(_ => 1fr),
    stroke: none,
    column-gutter: 2pt,
    inset: 0pt,
    slider-slice(0),
    slider-slice(1),
    slider-slice(2),
    slider-slice(3),
    slider-slice(4)
  ))
}

#let style(body) = {
  show title: set text(fill: neutral.darken(45%), size: 36pt)
  show heading: set text(weight: "extrabold", size: 24pt, fill: primary.darken(20%))
  show heading.where(level: 2): set text(weight: "extrabold", size: 24pt, fill: primary.darken(20%))
  show heading.where(level: 2): it => align(center, underline(it))
  show heading.where(level: 3): it => align(center, text(
    weight: "bold",
    size: 18pt,
    fill: primary.darken(20%),
    it.body,
  ))
  set text(size: 12pt, font: ((name: "Mulish", covers: "latin-in-cjk"), "Noto Sans TC"), weight: "medium")

  body
}

#let page-style(report) = {
  let f(it) = {
    set page(
      background: standard-page-background(report),
      margin: (top: 4cm, x: 2.3cm, bottom: 1cm),
    )
    it
  }

  f
}

#let body-style(body) = {
  set par(justify: true)
  set page(margin: (x: 1.8cm))
  set text(size: 11pt, hyphenate: false)

  body
}
