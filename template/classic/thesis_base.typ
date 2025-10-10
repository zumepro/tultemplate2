#import "../theme.typ": faculty_color
#import "../arguments.typ": get_arg, req_arg
#import "../utils.typ": is_none
#import "common.typ": (
  default_styling,
  disclaimer,
  abstract,
  acknowledgement,
  toc,
  tablelist,
  imagelist,
  abbrlist,
  bibliogr,
)
#import "../attachments.typ": attachment_list

#let thesis_base(args, content) = {
  let language = req_arg(args, "document.language");
  default_styling(false, faculty_color(req_arg(args, "document.faculty")), {
    if is_none(get_arg(args, "title_pages")) {
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
