#import "utils.typ": assert_type_signature, is_none, map_none, deref, assert_dict_has
#import "type_signature.typ": *

#let lang_keys = variants(literal("cs"), literal("en"));
#let nonrec_str = doc(string, none, "Je doporučeno použít 'content', pokud je to možné");
#let cont_or_str = variants(cont, nonrec_str);
#let opt_cont_or_str = variants(cont, nonrec_str, null);

#let arguments_structure = struct(
  keyval(literal("document"), struct( // document
    doc(
      keyval(literal("visual_style"), variants(literal("classic"))), // document.visual_style
      "style", "Vizuální styl šablony"
    ),

    doc(keyval(literal("faculty"), variants( // document.faculty
      doc(literal("fs"), none, "Fakulta strojní"),
      doc(literal("ft"), none, "Fakulta textilní"),
      doc(literal("fp"), none, "Fakulta přírodovědně-humanitní a pedagogická"),
      doc(literal("ef"), none, "Ekonomická fakulta"),
      doc(literal("fua"), none, "Fakulta umění a architektury"),
      doc(literal("fm"), none, "Fakulta mechatroniky, informatiky a mezioborových studií"),
      doc(literal("fzs"), none, "Fakulta zdravotnických studií"),
      doc(literal("cxi"), none, "Ústav pro nanomateriály, pokročilé technologie a inovace"),
      doc(literal("tul"), none, "Obecný styl a paleta TUL"),
    )), "faculty", "Fakulta (na základě toho budou vybrány barvy, logotypy, ...)"),

    doc(keyval(literal("language"), variants( // document.language
      doc(literal("cs"), none, "Čeština"),
      doc(literal("en"), none, "Angličtina"),
    )), "lang", "Primární jazyk dokumentu"),

    doc(keyval(literal("type"), variants( // document.type
      doc(literal("bp"), none, "Bakalářská práce"),
      doc(literal("dp"), none, "Diplomová práce"),
      doc(literal("prj"), none, "Projekt (ročník před odevzdáním bakalářské práce)"),
      doc(literal("other"), none, "Další dokumenty"),
    )), "document", "Typ dokumentu"),
  )),

  doc(keyval(literal("title_pages"), variants( // title_pages
      doc(string, none, "Cesta k souboru PDF, který má být vložen"),
      doc(null, none, (
        "Stránky jsou generovány pomocí šablony. Tohle u některých prací může vyžadovat doplnění" +
        " informací (argumentů)."
      )),
  )), "title_pages", "Způsob generování stránek na začátku dokumentu"),

  doc(keyval(literal("title"), dict(keyval(variants( // title
    doc(literal("cs"), none, "Název práce v češtině"),
    doc(literal("en"), none, "Název práce v angličtině"),
  ), cont_or_str))), "title", "Název práce"),

  keyval(literal("author"), struct( // author
    doc(keyval( // author.name
      literal("name"), opt_cont_or_str
    ), "author", "Jméno autora včetně titulů"),

    doc(keyval(literal("pronouns"), variants( // author.pronouns
      doc(literal("masculine"), none, "Pro češtinu, oslovení v mužském rodě"),
      doc(literal("feminine"), none, "Pro češtinu, oslovení v ženském rodě"),
      doc(literal("we"), none, "Pro češtinu a angličtinu, oslovení v množném čísle"),
      doc(literal("me"), none, "Pro angličtinu, oslovení v jednotném čísle"),
      doc(null, none, "Pro angličtinu, oslovení v jednotném čísle"),
    )), "author", "Jméno autora včetně titulů"),

    doc(keyval( // author.programme
      literal("programme"), variants(dict(keyval(lang_keys, cont_or_str)), null)
    ), "programme", "Studijní program, pod kterým byl tento dokument vytvořen"),

    doc(keyval( // author.specialization
      literal("specialization"), variants(dict(keyval(lang_keys, cont_or_str)), null)
    ), "specialization", "Specializace, pod kterou byl tento dokument vytvořen"),

    doc(keyval( // author.year_of_study
      literal("year_of_study"), opt_cont_or_str
    ), "year_of_study", "Specializace, pod kterou byl tento dokument vytvořen"),
  )),

  keyval(literal("project"), struct( // project
    doc(keyval(literal("supervisor"), variants(cont, nonrec_str, struct( // project.supervisor
      doc(keyval(literal("name"), cont_or_str), none, "Jméno vedoucího projektu"),
      doc(keyval(literal("institute"), cont_or_str), none, "Ústav vedoucího projektu"),
    ), null)), "supervisor", "Vedoucí projektu"),

    doc(keyval(literal("consultant"), variants(cont, nonrec_str, struct( // project.consultant
      doc(keyval(literal("name"), cont_or_str), none, "Jméno konzultanta projektu"),
      doc(keyval(literal("institute"), cont_or_str), none, "Ústav konzultanta projektu"),
    ), null)), "consultant", "Konzultant projektu"),
  )),

  keyval(literal("abstract"), struct( // abstract
    doc(
      keyval(
        literal("content"), // abstract.content
        variants(struct(..lang_keys.variants.map((k) => {
          keyval(k, variants(cont, nonrec_str, slice(string)))
        })), null)
      ),
      "abstract", "Abstrakt projektu",
    ),

    doc(
      keyval(
        literal("keywords"), // abstract.keywords
        variants(struct(..lang_keys.variants.map((k) => {
          keyval(k, variants(cont, nonrec_str, slice(string)))
        })), null),
      ),
      "keywords", "Klíčová slova projektu"
    ),
  )),

  doc( // acknowledgement
    keyval(literal("acknowledgement"), variants(dict(keyval(lang_keys, cont_or_str)), null)),
    "acknowledgement", "Poděkování",
  ),

  doc( // assignment
    keyval(literal("assignment"), variants(
      doc(string, none, "Zadání bude vloženo z PDF souboru s touto cestou"),
      doc(
        struct(
          keyval(literal("personal_number"), cont_or_str),
          keyval(literal("department"), cont_or_str),
          keyval(literal("academical_year"), cont_or_str),
          doc(keyval(literal("content"), cont), none, "Obsah zadání (zobrazen pod informacemi)"),
        ),
        none, "Zadání bude vygenerováno šablonou"
      ),
      doc(
        null, none,
        "Pokud je zadání vyžadováno typem dokumentu, bude vložena strana s upozorněním na vložení",
      ),
      doc(cont, none, "Zdrojový kód se zadáním (tato možnost se nedoporučuje)"),
    )),
    "assignment", "Stránka / stránky se zadáním",
  ),

  doc( // presentation_info
    keyval(literal("presentation_info"), struct(
      doc(
        keyval(literal("append_thanks"), bool), none,
        "Zda na konec prezentace vložit poděkování za pozornost",
      ),
      doc(
        keyval(literal("wide"), bool), none,
        "Jestli použít široký režim (16:9 - `true`) nebo úzký (4:3 - `false`)",
      ),
      doc(
        keyval(literal("first_heading_is_fullpage"), bool), none,
        ("Pokud je nastaveno `true`, pak se nadpisy první úrovně budou vkládat na " +
        "samostatnou stránku"),
      ),
    )), none, "Argumenty pro dokument typu `presentation`",
  ),

  doc( // citations
    keyval(literal("citations"), string),
    "citations", "Cesta k souboru s citacemi",
  ),
);

#let print_argument_docs() = {
  signature_docs(arguments_structure);
}

#let check_arguments(args, structure: arguments_structure, namespace: none) = {
  let res = signature_check(args, structure, "");
  if not res.at(0) {
    let panic_message = res.at(1);
    panic(panic_message);
  }
}

#let get_arg_single(args, path) = {
  let args = args;
  for segment in path.split(".") {
    if segment not in args {
      panic("invalid argument query path: " + str(path));
    }
    args = args.at(segment);
  }
  args
}

#let get_arg(args, path) = {
  if type(path) == array {
    let res = ();
    for path in path {
      res.push(get_arg_single(args, path));
    }
    res
  } else if type(path) == str {
    get_arg_single(args, path)
  } else {
    panic("invalid argument path");
  }
}

#let req_arg_single(args, path) = {
  let arg = get_arg_single(args, path);
  if is_none(arg) {
    let panic_message = path.split(".").join(" ").replace("_", " ") + " is missing";
    panic(panic_message);
  }
  arg
}

#let req_arg(args, path) = {
  if type(path) == array {
    let res = ();
    for path in path {
      res.push(req_arg_single(args, path));
    }
    res
  } else if type(path) == str {
    req_arg_single(args, path)
  } else {
    panic("invalid argument path");
  }
}

#let map_arg_single(args, path, mapper) = {
  let arg = get_arg(args, path);
  map_none(arg, mapper)
}

#let map_arg(args, path, mapper) = {
  if type(path) == array {
    let res = ();
    for path in path {
      res.push(map_arg_single(args, path, mapper));
    }
    res
  } else if type(path) == str {
    map_arg_single(args, path, mapper)
  } else {
    panic("invalid argument path");
  }
}

#let arguments(
  document_info,
  title_pages,
  title,
  author_info,
  project_info,
  abstract_info,
  acknowledgement,
  assignment,
  presentation,
  citations,
) = {
  (
    document: document_info,
    title_pages: title_pages,
    title: title,
    author: author_info,
    project: project_info,
    abstract: abstract_info,
    acknowledgement: acknowledgement,
    assignment: assignment,
    presentation_info: presentation,
    citations: citations,
  )
}

#let document_info(visual_style, faculty_abbreviation, language_abbreviation, document_type) = {
  (
    visual_style: visual_style,
    faculty: faculty_abbreviation,
    language: language_abbreviation,
    type: document_type,
  )
}

#let author_info(name, pronouns, programme, specialization, year_of_study) = {
  (
    name: name,
    pronouns: pronouns,
    programme: programme,
    specialization: specialization,
    year_of_study: year_of_study,
  )
}

#let project_info(supervisor, consultant) = {
  (supervisor: supervisor, consultant: consultant)
}

#let abstract_info(abstract, keywords) = {
  (content: abstract, keywords: keywords)
}
