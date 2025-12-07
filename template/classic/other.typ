#import "../lang.typ": get_lang_item
#import "common.typ": (
  mainpage,
  default_styling,
  assignment,
  disclaimer,
  abstract,
  toc,
  abbrlist,
  imagelist,
  tablelist,
  bibliogr,
)
#import "../attachments.typ": attachment_list
#import "../utils.typ": is_none, assert_not_none, assert_dict_has, assert_in_arr
#import "../arguments.typ": req_arg, get_arg, map_arg
#import "../theme.typ": faculty_color

#let other_title_page(args) = {
  let language = req_arg(args, "document.language");
  let title = get_arg(args, "title");
  map_arg(args, "title", (v) => { assert_dict_has((language,), v, "title") })
  mainpage(args);
}

#let other_base(args, content) = {
  let language = req_arg(args, "document.language");

  default_styling(true, faculty_color(req_arg(args, "document.faculty")), {
    toc(language);
    tablelist(language);
    imagelist(language);
    abbrlist(language);
    pagebreak(to: "even", weak: true);
    content;
    bibliogr(args);
    attachment_list(language);
  }, language);
}
