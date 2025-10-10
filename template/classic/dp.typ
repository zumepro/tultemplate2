#import "../lang.typ": get_lang_item
#import "common.typ": (
  mainpage,
  default_styling,
  assignment,
  disclaimer,
  abstract,
  acknowledgement,
  toc,
  abbrlist,
  imagelist,
  tablelist,
  bibliogr
)
#import "../attachments.typ": attachment_list
#import "../utils.typ": is_none, assert_dict_has, assert_not_none, assert_type_signature, map_none
#import "../arguments.typ": req_arg, get_arg, map_arg
#import "../theme.typ": faculty_color

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
    let _ = map_arg(
      args, "author.specialization", (v) => assert_dict_has((language,), v, "study specialization")
    );
    if language == "cs" {
      let _ = req_arg(args, "author.pronouns");
    }
  }

  if is_none(title_pages) {
    mainpage(args);
    assignment(args);
  }
  default_styling(false, faculty_color(req_arg(args, "document.faculty")), {
    if is_none(title_pages) {
      disclaimer(args);
    }
    abstract("cs", args);
    abstract("en", args);
    acknowledgement(args);
    toc(language);
    tablelist(language);
    imagelist(language);
    abbrlist(language);
    pagebreak(weak: true);
    content;
    bibliogr(args);
    attachment_list(language);
  }, language);
}
