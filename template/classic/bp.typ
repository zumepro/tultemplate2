#import "../lang.typ": get_lang_item
#import "common.typ": mainpage, default_styling, assignment, disclaimer, abstract, toc, abbrlist
#import "../utils.typ": is_none, assert_dict_has, assert_not_none

#let bp(
  // general settings
  faculty_id, faculty_color, language, assignment_document, citation_file,

  // document info
  title, author, author_gender, supervisor, study_programme, abstract_content, keywords,

  content
) = {
  let force_langs = ("cs", "en");
  assert_dict_has(force_langs, title, "title");
  assert_not_none(abstract_content, "abstract");
  assert_dict_has(force_langs, abstract_content, "abstract");
  if not is_none(keywords) {
    assert_dict_has(force_langs, keywords, "keywords");
  }
  if language == "cs" {
    assert_not_none(author_gender, "author gender");
  }

  mainpage(faculty_id, language, none, title, author, supervisor, study_programme);
  assignment(language, assignment_document);
  default_styling(false, faculty_color, {
    disclaimer(language, faculty_id, "bp", author, author_gender);
    abstract("cs", title, abstract_content, keywords);
    abstract("en", title, abstract_content, keywords);
    toc(language);
    abbrlist(language);
    content
    bibliography(citation_file, style: "../tul_citace.csl");
  });
}
