#import "theme.typ": faculty_logotype, tul_logomark, faculty_color
#import "lang.typ": lang_id, get_lang_item
#import "utils.typ": assert_in_dict, assert_in_arr

#let base_font = "Inter";
#let mono_font = "Noto Sans Mono";
#let serif_font = "Merriweather";
#let tul_logomark_size = 6.5em;

#let classic_header(faculty_id, language) = {
  let logotype = faculty_logotype(faculty_id, language);
  grid(
    block(logotype, width: 100%),
    block(align(right, block(tul_logomark(faculty_id), height: tul_logomark_size))),
    columns: 2
  );
}

#let classic_info(
  faculty_id,
  language,
  document_type,
  title, author, supervisor, study_programme,
) = {
  let info_name_value_padding = 5em;
  let info_name_min_width = 10em;

  // document type
  if type(document_type) != type(none) {
    let document_types = ("bp", "dp", "ds");
    assert_in_arr(document_type, document_types, "document type abbreviation");
    text(get_lang_item(language, document_type), weight: "bold", font: base_font);
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
    ("study_programme", study_programme, false),
    ("author", author, true),
    ("supervisor", supervisor, false),
  )
  context {
    let max_field_name_width = calc.max(..info_fields.map((v) => {
      if type(v.at(1)) == type(none) {
        0pt
      } else {
        measure(get_lang_item(language, v.at(0)) + ":").width
      }
    }), info_name_min_width.to-absolute());
    grid(
      columns: 2,
      rows: (auto, 1.2em),
      ..info_fields.filter((v) => { type(v.at(1)) != type(none) }).map((v) => {
        (
          block(
            text(get_lang_item(language, v.at(0)) + ":", style: "italic", font: base_font),
            width: max_field_name_width + info_name_value_padding,
          ),
          text(v.at(1), font: base_font, weight: if v.at(2) { "bold" } else { "regular" })
        )
      }).flatten(),
    );
    v(1em);
    h(max_field_name_width + info_name_value_padding);
    text(get_lang_item(language, "city") + " " + str(datetime.today().year()), font: base_font);
  }
}

#let classic_mainpage(
  faculty_id,
  language,
  document_type,
  title, author, supervisor, study_programme,
) = {
  import "utils.typ": has_all_none
  let nonetype = type(none);
  page({
    if has_all_none((
      document_type, title, author, supervisor, study_programme,
    )) {
      place(center + horizon, align(left, faculty_logotype(faculty_id, language)));
    } else {
      classic_header(faculty_id, language);
      align({
        classic_info(
          faculty_id, language, document_type, title, author, supervisor, study_programme
        );
        v(5em);
      }, bottom);
    }
  }, margin: 2cm);
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
      gutter: 1em,
      ..abbrs.pairs().map((a) => {
        (
          align(left, block(text(a.at(0), weight: "bold"), width: max_abbr_width + 1em)),
          text(a.at(1))
        )
      }).flatten()
    ));
  }
}

#let template_classic(
  faculty_id,
  language,
  document_type,
  title, author, supervisor, study_programme,
  citation_file,
  content,
) = {
  // main page
  classic_mainpage(faculty_id, language, document_type, title, author, supervisor, study_programme);

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
  set text(font: serif_font);
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
  show raw: set text(font: mono_font);
  show raw.where(block: true): it => {
    block(it, fill: rgb("#eee"), inset: 1em)
  };
  set highlight(fill: faculty_color.lighten(90%));
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
  bibliography(citation_file, style: "./tul_citace.csl")
}
