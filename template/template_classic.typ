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
    // TODO: hab, teze, autoref, proj, sp
    let document_types = ("bp", "dp", "dis");
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
          faculty_id, language, document_type, title.at(language),
          author, supervisor, study_programme,
        );
        v(5em);
      }, bottom);
    }
  }, margin: 2cm);
}

#let assignment(language, document) = {
  if type(document) == type(none) {
    page(
      place(center + horizon, text(
        get_lang_item(language, "place_assignment"),
        fill: red,
        size: 3em,
        font: base_font,
        weight: "bold",
      )),
      footer: none,
    );
    return;
  }
  import "@preview/muchpdf:0.1.1": muchpdf
  set page(margin: 0em);
  muchpdf(read(document, encoding: none));
}

#let disclaimer(language, faculty_id, disclaimer_type, author) = {
  let disclaimers_for = ("bp");
  if type(disclaimer_type) == type(none) or disclaimer_type not in disclaimers_for {
    return;
  }
  heading(get_lang_item(language, "disclaimer"), numbering: none, outlined: false);
  par(
    text(get_lang_item(language, "disclaimer_" + disclaimer_type))
  );
  v(5em);
  grid(
    columns: 2,
    gutter: 1em,
    block(text(datetime.today().display(get_lang_item(language, "date")), lang: "cs"), width: 100%),
    text(author),
  );
}

#let abstract(language, title, content, keywords) = {
  if type(content.at(language)) == type(none) {
    return;
  }
  if type(title.at(language)) == type(none) {
    panic("no title found for language `" + language + "` (required for abstract)");
  }
  heading(text(title.at(language), font: base_font), numbering: none, outlined: false);
  v(2em);
  heading(
    level: 2,
    get_lang_item(language, "abstract"),
    numbering: none,
    outlined: false,
  );
  text(content.at(language));
  if type(keywords.at(language)) != type(none) {
    linebreak();
    linebreak();
    text(get_lang_item(language, "keywords") + ": ", weight: "bold", font: base_font);
    text(keywords.at(language).join(", "));
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
  title_cs, author, supervisor, study_programme, abstract_cs, keywords_cs,
  title_en, abstract_en, keywords_en,
  assignment_document,
  citation_file,
  content,
) = {
  let flip_bonding = if document_type == "bp" {
    false
  } else {
    true
  };

  let title = (
    "cs": title_cs,
    "en": title_en,
  );

  // main page
  classic_mainpage(faculty_id, language, document_type, title, author, supervisor, study_programme);

  // styling
  let faculty_color = faculty_color(faculty_id);
  set par(justify: true);
  set heading(numbering: "1.1.1 ");
  set page(
    margin: if flip_bonding {
      (inside: 4cm, top: 3cm, bottom: 3cm)
    } else {
      (left: 4cm, top: 3cm, bottom: 3cm)
    },
    numbering: "1", footer: {
    context {
      let page = counter(page).get().at(0);
      if flip_bonding {
        align(str(page), if calc.rem(page, 2) == 1 { right } else { left });
      } else {
        align(str(page), right);
      }
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

  // assignment
  if document_type in ("bp", "dp", "dis") or type(assignment_document) != type(none) {
    assignment(language, assignment_document);
  }

  // disclaimer
  disclaimer(language, faculty_id, document_type, author);

  // abstract
  let abstract_content = (
    "cs": abstract_cs,
    "en": abstract_en,
  );
  let keywords = (
    "cs": keywords_cs,
    "en": keywords_en,
  );
  if language == "cs" {
    abstract("cs", title, abstract_content, keywords);
    abstract("en", title, abstract_content, keywords);
  } else {
    abstract(language, title, abstract_content, keywords);
  }

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
  if flip_bonding {
    pagebreak(to: "even", weak: true);
  }
  content

  // bibliography
  bibliography(citation_file, style: "./tul_citace.csl")
}
