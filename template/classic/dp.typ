#import "../arguments.typ": get_arg, map_arg, req_arg
#import "../utils.typ": assert_dict_has, is_none
#import "common.typ": assignment, external_title_pages, mainpage

#let dp(args) = {
  let language = req_arg(args, "document.language")
  let programme = req_arg(args, "author.programme")
  assert_dict_has((language,), programme, "study programme")
  map_arg(args, "author.specialization", v => {
    assert_dict_has((language,), v, "study specialization")
  })

  mainpage(args)
  assignment(args)
}
