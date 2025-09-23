#import "prototyping.typ": todo, profile

#let tultemplate(
  template_id,
  faculty_abbreviation,
  language,
  document_type: none,
  title: none, author: none, supervisor: none, study_programme: none,
  content,
) = {
  import "template_classic.typ": template_classic
  import "utils.typ": assert_in_dict
  let templates = (
    classic: template_classic,
  );
  assert_in_dict(template_id, templates, "template name");

  // global set-up
  import "lang.typ": lang_ids
  assert_in_dict(language, lang_ids, "language abbreviation");
  set text(lang: language);
  templates.at(template_id)(
    faculty_abbreviation, language, document_type,
    title, author, supervisor, study_programme,
    content
  );

  import "prototyping.typ": assert_release_ready
  assert_release_ready();
}

#let abbr(abbreviation, ..text) = {
  import "abbreviations.typ": abbr
  return abbr(abbreviation, if text.pos().len() == 0 { none } else { text.pos().at(0) });
}
