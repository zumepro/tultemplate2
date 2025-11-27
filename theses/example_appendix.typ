#let color = red.lighten(50%)
#set align(center + horizon)
#set text(font: "Inter", 2em, color)
#set page(foreground: rect(
  width: 90%,
  height: 90%,
  stroke: (paint: color, thickness: .03em, dash: (.5em, .5em)),
  place(center + bottom, context {
    text(str(counter(page).get().at(0)) + "/" + str(counter(page).final().at(0)), 15pt)
    v(1em)
  }),
))

Toto je ukázkový PDF dokument přiložený k práci jako příloha.

#pagebreak()

This is a sample PDF document attached to the thesis as an appendix.
