// tools & utils
#import "../theme.typ": faculty_logotype, tul_logomark, faculty_color
#import "../lang.typ": lang_id, get_lang_item
#import "../utils.typ": assert_in_dict, assert_in_arr, map_none

// thesis types
#import "bp.typ": bp
#import "other.typ": other

#let template_classic(
  // general settings
  language, faculty_id, document_type, citation_file, assignment_document,

  // document info
  title, author, author_gender, supervisor, study_programme, abstract, keywords,

  // content
  content,
) = {
  let document_types = (
    "bp": bp,
    "other": other,
  )
  assert_in_dict(document_type, document_types, "document type");

  document_types.at(document_type)(
    faculty_id,
    faculty_color(faculty_id),
    language,
    assignment_document,
    map_none(citation_file, (v) => "../../" + v),
    title,
    author,
    author_gender,
    supervisor,
    study_programme,
    abstract,
    keywords,
    content,
  );
}
