#import "../theme.typ": faculty_logotype, tul_logomark, faculty_color
#import "../lang.typ": get_lang_item
#import "../utils.typ": is_none

#let base_font = "Inter";
#let mono_font = "Noto Sans Mono";
#let serif_font = "Merriweather";
#let tul_logomark_size = 6.5em;

// TYPST ELEMENT STYLING

#let default_styling(flip_bonding, faculty_color, content) = {
  // page
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

  // text
  set text(font: serif_font);
  set par(justify: true);

  // figures
  let figure_numbering(c) = {
    context numbering("1. 1", counter(heading).get().at(0), c)
  };
  show figure.where(kind: image): set figure(numbering: figure_numbering);
  show figure.where(kind: table): set figure(numbering: figure_numbering);
  show figure.where(kind: table): set figure.caption(position: top);
  show figure: it => {
    block(it, above: 2em, below: 2em);
  }
  set image(width: 80%);

  // heading
  set heading(numbering: "1.1.1 ");
  show heading: it => {
    set par(justify: false);
    block(
      above: 2em,
      below: 2em,
      text(it, faculty_color, font: "TUL Mono", size: 1.2em)
    );
  };
  show heading.where(level: 1): it => {
    // reset figure counters
    context counter(figure.where(kind: image)).update(0);
    context counter(figure.where(kind: table)).update(0);

    pagebreak(weak: true);
    v(2cm);
    it
  };

  // other
  show raw: set text(font: mono_font);
  show raw.where(block: true): it => {
    block(it, fill: rgb("#eee"), inset: 1em)
  };
  set highlight(fill: faculty_color.lighten(90%));

  content
}


#let header(faculty_id, language) = {
  let logotype = faculty_logotype(faculty_id, language);
  grid(
    block(logotype, width: 100%),
    block(align(right, block(tul_logomark(faculty_id), height: tul_logomark_size))),
    columns: 2
  );
}

//  DOCUMENT INFO

#let info(
  faculty_id,
  language,
  document_type,
  title, author, supervisor, study_programme, study_branch,
) = {
  let info_name_value_padding = 5em;
  let info_name_min_width = 10em;

  // document type
  if type(document_type) != type(none) {
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
    ("study_branch", study_branch, false),
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
      gutter: .5em,
      ..info_fields.filter((v) => { type(v.at(1)) != type(none) }).map((v) => {
        (
          align(top, block(
            text(get_lang_item(language, v.at(0)) + ":", style: "italic", font: base_font),
            width: max_field_name_width + info_name_value_padding
          )),
          text(v.at(1), font: base_font, weight: if v.at(2) { "bold" } else { "regular" })
        )
      }).flatten(),
    );
    v(1em);
    h(max_field_name_width + info_name_value_padding);
    text(get_lang_item(language, "city") + " " + str(datetime.today().year()), font: base_font);
  }
}

// MAINPAGE

#let mainpage(
  faculty_id,
  language,
  document_type,
  title, author, supervisor, study_programme, study_branch
) = {
  import "../utils.typ": has_all_none, map_none
  let nonetype = type(none);
  page({
    if has_all_none((
      document_type, title, author, supervisor, study_programme,
    )) {
      place(center + horizon, align(left, faculty_logotype(faculty_id, language)));
    } else {
      header(faculty_id, language);
      align({
        info(
          faculty_id, language, document_type, map_none(title, (v) => v.at(language)),
          author, supervisor, map_none(study_programme, (v) => v.at(language)),
          map_none(study_branch, (v) => v.at(language)),
        );
        v(5em);
      }, bottom);
    }
  }, margin: 2cm);
}

// ASSIGNMENT PAGE

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
      margin: 0em,
      footer: none,
    );
    return;
  }
  import "@preview/muchpdf:0.1.1": muchpdf
  set page(margin: 0em);
  muchpdf(read(document, encoding: none));
}

// DISCLAIMER PAGE

#let disclaimer(language, faculty_id, disclaimer_type, author, author_gender) = {
  import "../lang.typ": disclaimer
  heading(get_lang_item(language, "disclaimer"), numbering: none, outlined: false);
  par(
    text(disclaimer(language, disclaimer_type, author_gender))
  );
  v(5em);
  grid(
    columns: 2,
    gutter: 1em,
    block(
      text(datetime.today().display(get_lang_item(language, "date")), lang: "cs"), width: 100%
    ),
    text(author),
  );
}

// ABSTRACT

#let abstract(language, title, content, keywords) = {
  heading(text(title.at(language), font: base_font), numbering: none, outlined: false);
  v(2em);
  heading(
    level: 2,
    get_lang_item(language, "abstract"),
    numbering: none,
    outlined: false,
  );
  text(content.at(language));
  if not is_none(keywords) and type(keywords.at(language)) != type(none) {
    linebreak();
    linebreak();
    text(get_lang_item(language, "keywords") + ": ", weight: "bold", font: base_font);
    text(keywords.at(language).join(", "));
  }
}

// _ OUTLINE
#let _outline_figure_inner(selector, title, body_mapper) = {
  show outline.entry: it => {
    link(
      it.element.location(),
      grid(
        columns: 3,
        gutter: .5em,
        stack(
          dir: ltr,
          text(numbering(
            "1. 1",
            counter(heading).at(it.element.location()).at(0),
            counter(selector).at(it.element.location()).at(0),
          )),
          h(.5em),
          text(body_mapper(it)),
        ),
        box(repeat([.], gap: 0.15em)),
        str(it.element.location().page()),
      ),
    )
  }
  if not is_none(selector) {
    outline(target: selector, title: title);
  } else {
    outline(title: title);
  }
}

// _ FIGURE OUTLINE

#let _figure_outline(target, title) = {
  context {
    if counter(figure.where(kind: target)).final() == 0 {
      return;
    }
    _outline_figure_inner(figure.where(kind: target), title, (it) => it.element.caption.body);
  }
}

// IMAGE LIST

#let imagelist(language) = {
  _figure_outline(image, get_lang_item(language, "image_list"));
}

// TABLE LIST

#let tablelist(language) = {
  _figure_outline(table, get_lang_item(language, "table_list"));
}

// ABBREVIATION LIST

#let abbrlist(language) = {
  import "../abbreviations.typ": abbrlist
  context {
    let abbrs = abbrlist();
    let max_abbr_width = if abbrs.len() > 0 {
      calc.max(abbrs.keys().map((v) => measure(v).width)).at(0)
    } else { return };
    pagebreak(weak: true);
    heading(get_lang_item(language, "abbrs"), numbering: none);
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

// TABLE OF CONTENTS

#let toc(language) = {
  show outline.entry.where(level: 1): it => {
    show repeat: none;
    block(text(it, weight: "bold", size: 1.2em), above: 1.5em);
  };
  outline(title: get_lang_item(language, "toc"));
}

// BIBLIOGRAPHY

#let bibliogr(language, citations_file) = {
  if language == "cs" {
    bibliography(citations_file, style: "../tul_citace.csl");
  } else if language == "en" {
    bibliography(citations_file, style: "iso-690-numeric");
  } else {
    panic("unknown language for bibliography '" + language + "'");
  }
}
