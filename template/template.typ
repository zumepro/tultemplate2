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

  templates.at(template_id)(
    faculty_abbreviation, language, document_type,
    title, author, supervisor, study_programme,
    content
  );
}

#let abbr(abbreviation, ..text) = {
  import "abbreviations.typ": abbr
  return abbr(abbreviation, if text.pos().len() == 0 { none } else { text.pos().at(0) });
}
