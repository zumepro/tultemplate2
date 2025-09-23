#import "template_classic.typ": template_classic
#import "utils.typ": assert_in_dict

#let templates = (
  classic: template_classic,
);

#let tultemplate(
  template_id,
  faculty_abbreviation,
  language,
  document_type: none,
  title: none, author: none, supervisor: none, study_programme: none,
) = {
  assert_in_dict(template_id, templates, "template name");
  templates.at(template_id)(
    faculty_abbreviation, language, document_type,
    title, author, supervisor, study_programme
  );
}
