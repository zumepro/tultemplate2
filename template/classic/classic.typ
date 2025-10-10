// tools & utils
#import "../theme.typ": faculty_logotype, tul_logomark, faculty_color
#import "../lang.typ": lang_id, get_lang_item
#import "../utils.typ": assert_in_dict, assert_in_arr, map_none, assert_dict_has, is_none
#import "../arguments.typ": req_arg, map_arg, get_arg
#import "common.typ": default_styling, external_title_pages

// thesis types
#import "bp.typ": bp
#import "dp.typ": dp
#import "other.typ": other
#import "thesis_base.typ": thesis_base

#let template_classic(args, content) = {
  let language = req_arg(args, "document.language");

  // argument pre-checking
  let document_types = (
    "bp": bp,
    "dp": dp,
    "other": other,
  )
  assert_in_dict(req_arg(args, "document.type"), document_types, "document type");
  map_arg(args, "title", (v) => assert_dict_has((language,), v, "title"));
  map_arg(args, "author.programme", (v) => assert_dict_has((language,), v, "study programme"));
  map_arg(
    args, "author.specialization", (v) => assert_dict_has((language,), v, "study specialization")
  );
  map_arg(
    args, "acknowledgement", (v) => assert_dict_has((language,), v, "acknowledgement content")
  );

  args.assignment = map_arg(args, "assignment", (v) => "../../" + v);
  args.citations = map_arg(args, "citations", (v) => "../../" + v);
  args.title_pages = map_arg(args, "title_pages", (v) => "../../" + v);

  if not is_none(get_arg(args, "title_pages")) and not req_arg(args, "document.type") == "other" {
    external_title_pages(req_arg(args, "title_pages"));
    thesis_base(args, content);
  } else {
    document_types.at(req_arg(args, "document.type"))(args, content);
  }
}
