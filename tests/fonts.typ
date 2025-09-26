#let display_font(family, weight) = {
  if type(family) == type(none) {
    block(
      spacing: 2em,
      text("Příšerně žluťoučký kůn úpěl ďábelské ódy. " + lorem(25), weight: weight)
    )
  } else {
    block(
      spacing: 2em,
      text("Příšerně žluťoučký kůn úpěl ďábelské ódy. " + lorem(25), font: family, weight: weight)
    )
  }
}
#show heading.where(level: 1): it => {
  v(3em);
  it;
}

= #highlight[TUL Mono]

== Regular

#display_font("tul mono", "regular")

= #highlight[Inter]

== Regular

#display_font("inter", "regular")

== Light

#display_font("inter", "light")

== Bold

#display_font("inter", "bold")

#pagebreak()

= #highlight[Default]

== Regular

#display_font(none, "regular")

= #highlight[Merriweather]

== Regular

#display_font("merriweather", "regular")

== Light

#display_font("merriweather", "light")

== Bold

#display_font("merriweather", "bold")
