#import "../template/template.typ": *

#show: tultemplate2.with(
  style: "classic",
  faculty: "fm",
  lang: "en",
  document: "prj",
  assignment: (
    personal_number: [A00000007],
    department: [Department of templates],
    academical_year: [2025/2026],
    content: [
      = Principles for drafting:
      + Familiarize yourself with available templates
      + Design several possible template styles
      + Learn to use Typst
      + Implement the template
      + Review the template
      + Fix many issues
      + Review the template
      + Fix many issues
      + Review the template
      + Hopefully nothing more needs fixing
      = List of professional literature:
      _Top secret_
    ],
  ),
  title: (
    cs: [Ukázka dokumentu typu Projekt pro FM TUL v češtině],
    en: [Example document for a Project report for FM TUL in Czech],
  ),
  author: [Matěj Žucha],
  author_pronouns: "me",
  programme: (en: [MI6000000007 Top secret]),
  specialization: (en: [Creation of templates]),
  supervisor: [Ondřej Mekina],
  abstract: (
    cs: [
      Tento dokument slouží jako praktická ukázka všech důležitých funkcí šablony _tultemplate2_,
      s názornými příklady použítí a jejich podrobným popisem.
    ],
    en: [
      This document serves as a practical demonstration of all the important features of the
      _tultemplate2_ template, with useful examples and their respective descriptions.
    ],
  ),
  keywords: (
    cs: [Ukázka, Klíčových, Slov, Česky],
    en: [Example, Keywords, In, English],
  ),
  acknowledgement: (en: [Lorem ipsum dolor sit amet.]),
  citations: "citations.bib",
)

Project
