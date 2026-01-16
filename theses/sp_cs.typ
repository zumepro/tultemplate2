#import "../template/template.typ": *

#show: tultemplate2.with(
  style: "classic",
  faculty: "fm",
  lang: "cs",
  document: "sp",
  assignment: (
    personal_number: [A00000007],
    department: [Ústav šablon],
    academical_year: [2025/2026],
    content: [
      __assignment__
    ],
  ),
  title: (
    cs: [Ukázka dokumentu typu Semestrální práce v češtině],
    en: [Example document for a Term paper in Czech],
  ),
  author: [Matěj Žucha],
  author_pronouns: "we",
  programme: (cs: [MI6000000007 Přísně tajné]),
  specialization: (cs: [Vytváření šablon]),
  citations: "citations.bib",
)

Semestrální práce
vaší semestrální prací
