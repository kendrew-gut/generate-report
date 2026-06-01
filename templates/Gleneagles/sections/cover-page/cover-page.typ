#import "../../lib.typ": *

#let cover-page(report) = page(background: align(bottom, image("images/cover-page-background.png")), margin: (
  x: 0.6in,
))[
  #image("images/gleneagles-logo-full.jpg", width: 400pt)
  #v(7em)
  #title()
  #v(5em)
  #block(width: 55%)[
    #subtitle[
      #columns(2, gutter: 0pt)[
        #set par(spacing: 1.5em)
        User Name:

        Report ID:

        Report Date:
        #colbreak()
        #report.user-name

        #report.sample_id

        #report.date.display(date-format)
      ]
    ]
  ]
]
