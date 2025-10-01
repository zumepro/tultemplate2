#import "../lang.typ": get_lang_item
#import "common.typ": mainpage, default_styling, assignment, disclaimer, abstract, toc, abbrlist
#import "../utils.typ": is_none

#let other(
  // general settings
  faculty_id, faculty_color, language, assignment_document, citation_file,

  // document info
  title, author, _, supervisor, study_programme, abstract_content, keywords,

  content
) = {
  mainpage(faculty_id, language, none, title, author, supervisor, study_programme);
  default_styling(true, faculty_color, {
    toc(language);
    abbrlist(language);

    pagebreak(to: "even", weak: true);
    content

    // bibliography
    bibliography(citation_file, style: "../tul_citace.csl");
  });
}
