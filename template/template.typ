// +---------------+
// | TULTemplate 2 |
// +---------------+
//
// Unofficial TUL template for all kinds of documents.
//
// Git: https://git.zumepro.cz/tul/tultemplate2

#import "prototyping.typ": todo, profile

// TUL Template 2
//
// Use this at the beginning of a Typst file:
// ```typst
// #import "template/template.typ": *
//
// #show: tultemplate2.with(
//   "classic", "fm", "cs", ...
// )
// ```
//
// - style (str): Visual style to use. This can be "latex".
// - faculty (str): Factulty abbreviation. One of "fs", "ft", "fp", "ef", "fua", "fm", "fzs", "cxi".
// - lang (str): Language code. This can be "cs" or "en".
// - document (str): Type of document. This can be "bp", "dp", "ds".
// - title (str): The title of the document.
// - author (str): The name of the document's author.
// - supervisor (str): The name of the document's supervisor.
// - programme (str): Study programme.
// - citations (str): The location of the citation file.
// - content (content): The content of the document
//
//-> none
#let tultemplate2(
  style: "latex",
  faculty: "tul",
  lang: "cs",
  document: none,
  title: none, author: none, supervisor: none, programme: none,
  citations: "citations.bib",
  content,
) = {
  import "template_latex.typ": template_latex
  import "utils.typ": assert_in_dict
  let templates = (
    latex: template_latex,
  );
  assert_in_dict(style, templates, "template name");

  // global set-up
  import "lang.typ": lang_ids
  assert_in_dict(lang, lang_ids, "language abbreviation");
  set text(lang: lang);
  templates.at(style)(
    faculty, lang, document,
    title, author, supervisor, programme,
    "../" + citations,
    content
  );

  import "prototyping.typ": assert_release_ready
  assert_release_ready();
}

// Make a new abbreviation
//
// - abbreviation (str): The abbreviation
// - text (str): Optionally, the text - the meaning of the abbreviation.
#let abbr(abbreviation, ..text) = {
  import "abbreviations.typ": abbr
  return abbr(abbreviation, if text.pos().len() == 0 { none } else { text.pos().at(0) });
}
