#import "../arguments.typ": get_arg, req_arg
#import "../utils.typ": assert_dict_has, is_none
#import "common.typ": assignment, external_title_pages, mainpage

#let bp(args) = {
  let language = req_arg(args, "document.language")
  let title = req_arg(args, "title")
  assert_dict_has((language,), title, "title")
  let author = req_arg(args, "author.name")
  let programme = req_arg(args, "author.programme")
  assert_dict_has((language,), programme, "study programme")
  let specialization = req_arg(args, "author.specialization")
  assert_dict_has((language,), specialization, "study specialization")

  mainpage(args)
  assignment(args)
}
