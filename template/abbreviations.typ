#let abbreviations = state("abbrs", "()");

#let abbr(abbreviation, text) = {
  abbreviations.update(abbrs => {
    let abbrs = if abbrs.len() == 2 { eval(abbrs).to-dict() } else { eval(abbrs) };
    if abbreviation not in abbrs {
      if type(text) == type(none) {
        panic(
          "abbreviation '" + abbreviation +
          "' has no definition yet, please specify it on the first call"
        );
      }
      abbrs.insert(abbreviation, text);
    }
    "(" + abbrs.pairs().map((v) => { v.at(0) + ":\"" + v.at(1) + "\"" }).join(",") + ")"
  });
  abbreviation;
}

#let abbrlist() = {
  let abbreviations = abbreviations.final();
  return if abbreviations.len() == 2 { ().to-dict() } else { eval(abbreviations) }
}
