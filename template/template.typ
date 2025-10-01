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
// - style (str): Visual style to use. This can be "classic".
// - faculty (str): Factulty abbreviation. One of "fs", "ft", "fp", "ef", "fua", "fm", "fzs", "cxi".
// - lang (str): Language code. This can be "cs" or "en".
// - document (str): Type of document. This can be "bp", "dp", "ds".
// - title_cs (str): The title (Czech) of the document.
// - author (str): The name of the document's author.
// - supervisor (str): The name of the document's supervisor.
// - programme (str): Study programme.
// - abstract_cs (content): The abstract (Czech).
// - keywords_cs (array): The abstract keywords (Czech).
// - title_en (str): The title (English) of the document.
// - abstract_en (content): The abstract (English).
// - keywords_en (array): The abstract keywords (English).
// - assignment (str): Filepath of the assignment document/page.
// - citations (str): The location of the citation file.
// - content (content): The content of the document
//
//-> none
#let tultemplate2(
  style: "classic",
  faculty: "tul",
  lang: "cs",
  document: none,
  title_cs: none, author: none, supervisor: none, programme: none, abstract_cs: none,
  keywords_cs: none,
  title_en: none, abstract_en: none, keywords_en: none,
  assignment: none,
  citations: "citations.bib",
  content,
) = {
  import "template_classic.typ": template_classic
  import "utils.typ": assert_in_dict
  let templates = (
    classic: template_classic,
  );
  assert_in_dict(style, templates, "template name");

  // global set-up
  import "lang.typ": lang_ids
  assert_in_dict(lang, lang_ids, "language abbreviation");
  set text(lang: lang);

  // verify
  if document == "bp" and (type(abstract_cs) == type(none) or type(abstract_en) == type(none)) {
    panic("need both czech and english abstract for document of type 'bp'");
  }

  // template call
  templates.at(style)(
    faculty, lang, document,
    title_cs, author, supervisor, programme, abstract_cs, keywords_cs,
    title_en, abstract_en, keywords_en,
    if type(assignment) == type(none) { none } else { "../" + assignment },
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
