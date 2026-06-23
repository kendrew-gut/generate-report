#import "../../lib.typ": *

#let cover-page(report) = page(background: align(bottom, image("images/cover-page-background.png")), margin: (
  x: 0.6in,
))[
  #v(5em)
  #image(if show-gleneagles-logo {"images/gleneagles-logo-full.jpg"} else {"images/gutolution-logo-banner.png"}, width: 400pt)
  #v(6em)
  #title()
  #v(4em)
  #block(width: 55%)[
    #subtitle[
      #columns(2, gutter: 0pt)[
        #set par(spacing: 1.5em)
        用戶姓名:

        報告編號:

        報告日期:
        #colbreak()
        #report.report_information.user_full_name

        #report.report_information.report_id

        #report.report_information.date_of_report.display(date-format)
      ]
    ]
  ]
]
