// tools & utils
#import "../theme.typ": faculty_logotype, tul_logomark, faculty_color
#import "../lang.typ": lang_id, get_lang_item
#import "../utils.typ": assert_in_dict, assert_in_arr, map_none, assert_dict_has
#import "../arguments.typ": req_arg, map_arg
#import "common.typ": default_styling

// thesis types
#import "bp.typ": bp
#import "dp.typ": dp
#import "other.typ": other

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

  document_types.at(req_arg(args, "document.type"))(args, content);
}
