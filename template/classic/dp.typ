#import "../arguments.typ": req_arg, get_arg, map_arg
#import "../utils.typ": assert_dict_has, is_none
#import "common.typ": mainpage, assignment, external_title_pages
#import "thesis_base.typ": thesis_base

#let dp(args, content) = {
  let force_langs = ("cs", "en");

  let title = req_arg(args, "title");
  let abstract_content = req_arg(args, "abstract.content");
  let keywords = req_arg(args, "abstract.keywords");
  let title_pages = get_arg(args, "title_pages");
  let language = req_arg(args, "document.language");

  assert_dict_has(force_langs, title, "title");
  assert_dict_has(force_langs, abstract_content, "abstract");
  if not is_none(keywords) {
    assert_dict_has(force_langs, keywords, "keywords");
  }

  if is_none(title_pages) {
    let programme = req_arg(args, "author.programme");
    assert_dict_has((language,), programme, "study programme");
    map_arg(args, "author.specialization", (v) => {
      assert_dict_has((language,), v, "study specialization");
    });
    if language == "cs" {
      let _ = req_arg(args, "author.pronouns");
    }
  }

  if is_none(title_pages) {
    mainpage(args);
    assignment(args);
  } else {
    external_title_pages(title_pages);
  }

  thesis_base(args, content);
}
