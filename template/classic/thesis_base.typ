#import "../theme.typ": faculty_color, faculty_subtle_color
#import "../arguments.typ": get_arg, req_arg
#import "../utils.typ": is_none, assert_dict_has, ok_or
#import "common.typ": (
  default_styling,
  disclaimer,
  try_abstracts,
  acknowledgement,
  toc,
  tablelist,
  imagelist,
  abbrlist,
  bibliogr,
)
#import "../attachments.typ": attachment_list
#import "../lang.typ": lang_ids

#let document(
  args,
  show_disclaimer,
  require_abstract,
  default_bonding_style,
  content,
) = {
  let language = req_arg(args, "document.language");
  let faculty = req_arg(args, "document.faculty")
  let bonding_style = ok_or(get_arg(args, "document.bonding_style"), default_bonding_style)
  default_styling(bonding_style, faculty_color(faculty), faculty_subtle_color(faculty), {
    if show_disclaimer and is_none(get_arg(args, "title_pages")) {
      disclaimer(args);
    }
    try_abstracts(args, require_langs: ok_or(require_abstract, array(())))
    acknowledgement(args);
    toc(language);
    tablelist(language);
    imagelist(language);
    abbrlist(language);
    if bonding_style == "switch" {
      pagebreak(to: "even", weak: true)
    } else if bonding_style != "none" {
      pagebreak(weak: true)
    }
    content;
    bibliogr(args);
    attachment_list(language);
  }, language);
}

#let thesis_base(
  args, content,
  show_disclaimer: true,
  require_abstract: lang_ids.keys(),
  default_bonding_style: "left",
) = {
  document(args, show_disclaimer, require_abstract, default_bonding_style, content)
}

#let thesis_base_title_pages(args, default_bonding_style: "switch") = {
  let language = req_arg(args, "document.language");
  let bonding_style = ok_or(get_arg(args, "document.bonding_style"), default_bonding_style)
  default_styling(bonding_style, faculty_color(req_arg(args, "document.faculty")), {
    if is_none(get_arg(args, "title_pages")) {
      disclaimer(args);
    }
  }, language);
}
