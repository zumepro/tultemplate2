#import "../lang.typ": get_lang_item
#import "common.typ": mainpage, default_styling, assignment, disclaimer, abstract, toc, abbrlist
#import "../utils.typ": is_none, assert_not_none, assert_dict_has, assert_in_arr

#let other(
  // general settings
  faculty_id, faculty_color, language, assignment_document, citation_file,

  // document info
  title, author, _, supervisor, study_programme, study_branch, abstract_content, keywords,

  content
) = {
  assert_not_none(title, "title");
  assert_dict_has((language,), title, "title");

  mainpage(faculty_id, language, none, title, author, supervisor, study_programme, study_branch);
  default_styling(true, faculty_color, {
    toc(language);
    abbrlist(language);

    pagebreak(to: "even", weak: true);
    content

    // bibliography
    bibliography(citation_file, style: "../tul_citace.csl");
  });
}
