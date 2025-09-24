#import "theme.typ": faculty_logotype, tul_logomark, faculty_color
#import "lang.typ": lang_id
#import "utils.typ": assert_in_dict

#let base_font = "Cabin";

#let classic_header(faculty_id, language) = {
  let logotype = faculty_logotype(faculty_id, language);
  grid(
    logotype,
    block(align(right, block(tul_logomark(faculty_id), height: 5em)), width: 100%),
    columns: 2
  );
}

#let classic_info(
  faculty_id,
  language,
  document_type,
  title, author, supervisor, study_programme,
) = {
  let lang_id = lang_id(language);

  // document type
  if type(document_type) != type(none) {
    let document_types = (
      bp: ("Bakalářská práce", "Bachelor thesis"),
      dp: ("Diplomová práce", "Diploma thesis"),
      ds: ("Disertační práce", "Dissertation thesis"),
    );
    assert_in_dict(document_type, document_types, "document type abbreviation");
    text(document_types.at(document_type).at(lang_id), weight: "bold", font: base_font);
    v(0em);
  }

  // title
  text(
    title, weight: "bold", size: 2em,
    faculty_color(faculty_id), font: base_font,
  );
  v(0em);

  // other info
  // [field_name, field_value, bold]
  let info_fields = (
    (("Studijní program", "Study programme"), study_programme, false),
    (("Autor", "Author"), author, true),
    (("Vedoucí práce", "Supervisor"), supervisor, false),
  );
  context {
    let max_field_name_width = calc.max(..info_fields.map((v) => {
      if type(v.at(1)) == type(none) {
        0pt
      } else {
        measure(v.at(0).at(lang_id) + ":").width
      }
    }));
    grid(
      columns: 2,
      rows: (auto, 1.2em),
      ..info_fields.filter((v) => { type(v.at(1)) != type(none) }).map((v) => {
        (
          block(
            text(v.at(0).at(lang_id) + ":", style: "italic", font: base_font),
            width: max_field_name_width + 5em,
          ),
          text(v.at(1), font: base_font, weight: if v.at(2) { "bold" } else { "regular" })
        )
      }).flatten()
    );
  }
}

#let abbrlist(language) = {
  import "abbreviations.typ": abbrlist
  context {
    let abbrs = abbrlist();
    let max_abbr_width = if abbrs.len() > 0 {
      calc.max(abbrs.keys().map((v) => measure(v).width)).at(0)
    } else { return };
    pagebreak(weak: true);
    heading(("Seznam zkratek", "List of abbreviations").at(language), numbering: none);
    align(center, grid(
      columns: 2,
      ..abbrs.pairs().map((v) => {
        (block(text(v.at(0), weight: "bold"), width: max_abbr_width + 1em), text(v.at(1)))
      }).flatten()
    ));
  }
}

#let template_classic(
  faculty_id,
  language,
  document_type,
  title, author, supervisor, study_programme,
  content,
) = {
  // intro page
  page({
    classic_header(faculty_id, language);
    align({
      classic_info(faculty_id, language, document_type, title, author, supervisor, study_programme);
      v(5em);
    }, bottom);
  }, margin: 2cm);

  // styling
  let faculty_color = faculty_color(faculty_id);
  set par(justify: true);
  set heading(numbering: "1.1.1 ");
  set page(margin: (outside: 4cm, top: 3cm, bottom: 3cm), numbering: "1", footer: {
    context {
      let page = counter(page).get().at(0);
      align(str(page), if calc.rem(page, 2) == 0 { right } else { left })
    }
  });
  show heading: it => {
    set par(justify: false);
    block(
      above: 2em,
      below: 2em,
      text(it, faculty_color, font: "TUL Mono", size: 1.2em)
    );
  };
  show heading.where(level: 1): it => {
    pagebreak();
    v(2cm);
    it
  };
  show raw.where(block: true): it => {
    block(it, fill: rgb("#eee"), inset: 1em)
  }
  set image(width: 80%);

  let language = lang_id(language);

  // toc
  show outline.entry.where(level: 1): it => {
    show repeat: none;
    block(text(it, weight: "bold", size: 1.2em), above: 1.5em);
  };
  outline(title: ("Obsah", "Contents").at(language));

  // abbreviation list
  abbrlist(language);

  // content
  pagebreak(to: "even", weak: true);
  content

  // bibliography
  bibliography("../citations.bib", style: "./tul_citace.csl")
}
