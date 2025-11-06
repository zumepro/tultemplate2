#import "../template/template.typ": *

#show: tultemplate2.with(
  style: "classic",
  faculty: "fm",
  lang: "cs",
  document: "prj",
  title: (
    cs: "Ukázka dokumentu typu Projekt pro FM TUL v češtině",
    en: "Example document of type Project for FM TUL in Czech",
  ),
  author: "Matěj Žucha",
  author_pronouns: "masculine",
  programme: (cs: "MI6000000007 Přísně tajné"),
  specialization: (cs: "Vytváření šablon"),
  supervisor: "Ondřej Mekina",
  abstract: (
    cs: [
      Tento dokument slouží jako praktická ukázka všech důležitcýh funkcí šablony _tultemplate2_,
      s názornými příklady použítí a jejich podrobným popisem.
    ],
    en: [
      This document serves as a practical demonstration of all the important features of the
      _tultemplate2_ template, with useful examples and their respective descriptions.
    ],
  ),
  keywords: (
    cs: ("Ukázka", "Klíčových", "Slov", "Česky"),
    en: ("Example", "Keywords", "In", "English"),
  ),
  acknowledgement: (cs: "Lorem ipsum dolor sit amet."),
  citations: "citations.bib",
)
