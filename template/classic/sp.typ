#import "../arguments.typ": get_arg, map_arg, req_arg
#import "../utils.typ": assert_dict_has
#import "common.typ": assignment, mainpage

#let sp(args) = {
  let language = req_arg(args, "document.language")
  let title = req_arg(args, "title")
  assert_dict_has((language,), title, "title")
  let author = req_arg(args, "author.name")
  map_arg(args, "author.programme", v => {
    assert_dict_has((language,), v, "study programme")
  })
  map_arg(args, "author.specialization", v => {
    assert_dict_has((language,), v, "study specialization")
  })

  mainpage(args)
  assignment(args, show_fallback: false)
}
