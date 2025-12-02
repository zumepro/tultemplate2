#import "../arguments.typ": req_arg 
#import "../utils.typ": assert_dict_has, is_none
#import "../theme.typ": faculty_color, faculty_logotype, faculty_logotype_text, tul_logomark
#import "../lang.typ": get_lang_item
#import "common.typ": common_styling, bibliogr, base_font


#let set_page_style(lang, faculty, faculty_color, content, paper) = {
  context {
    let footer_margin = 20pt
    let footer_logotype = faculty_logotype(faculty, lang)
    let footer_height = measure(footer_logotype).height + footer_margin
    set page(paper: paper, margin: (bottom: footer_height, rest: 1cm), footer-descent: 0%, footer: {
      box(outset: (top: footer_margin, bottom: footer_margin), {
        footer_logotype
        h(1fr)
        context text(
          str(counter(page).get().at(0)) + " / " + str(counter(page).final().at(0)),
          font: "TUL Mono",
          faculty_color,
        )
      })
    })
    content
  }
}

#let set_heading_styles(content) = {
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    box(text(it, size: 1.25em), inset: (top: 2em, bottom: 2em))
  }
  content
}

#let apply_style(language, faculty, faculty_color, content, paper) = {
  common_styling(
    faculty_color, language,
    set_page_style(language, faculty, faculty_color, set_heading_styles(content), paper)
  )
}

#let fullpage(language, faculty, faculty_color, content, paper) = {
  page(
    background: rect(fill: faculty_color, width: 100%, height: 100%), paper: paper, margin: 1cm,
    {
      grid(
        columns: 3,
        faculty_logotype(faculty, language, color: white),
        h(1fr),
        tul_logomark(faculty, color: white),
      )
      content
    }
  )
}

#let signedpage(language, faculty, faculty_color, author, content, paper) = {
  fullpage(language, faculty, faculty_color, {
    content
    place(center + bottom, text(author, white.transparentize(30%), size: 1.25em, font: base_font))
  }, paper)
}

#let mainpage(language, faculty, faculty_color, title, author, paper) = {
  signedpage(language, faculty, faculty_color, author, {
    place(center + horizon, text(title, size: 2em, font: "TUL Mono", white))
  }, paper)
}

#let thankspage(language, faculty, faculty_color, author, paper) = {
  signedpage(language, faculty, faculty_color, author, {
    place(center + horizon, text(
      get_lang_item(language, "thanks_for_attention"), size: 2em, font: "TUL Mono", white
    ))
  }, paper)
}

#let presentation(args, content) = {
  let language = req_arg(args, "document.language")
  let faculty = req_arg(args, "document.faculty")
  let faculty_color = faculty_color(faculty)
  let presentation_args = req_arg(args, "presentation_info")
  let author = req_arg(args, "author.name")
  let paper = "presentation-4-3"
  
  if presentation_args.at("aspect_16-9") {
    paper = "presentation-16-9"
  }
  mainpage(
    language, faculty, faculty_color,
    req_arg(args, "title").at(language), author, paper,
  )
  apply_style(language, faculty, faculty_color, {
    content
    bibliogr(args)
  }, paper)
  if presentation_args.at("append_thanks") {
    thankspage(language, faculty, faculty_color, author, paper,)
  }
}
