#import "../template/template.typ": *

#show: tultemplate2.with(
  style: "classic",
  faculty: "fm",
  lang: "cs",
  document: "presentation",
  author: [Ondřej Mekina],
  title: (
    cs: [Ukázka prezentace v šabloně tultemplate2],
  ),
  presentation: (
    append_thanks: true,
  ),
  citations: "citations.bib",
)

= První slide

== Úvod

Tohle je úvod

== Text

Text text

= Další slide

Tohle je další slide

Tady jsou citace: @typst @bibtex
