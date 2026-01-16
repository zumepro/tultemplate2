#import "../template/template.typ": *

#show: tultemplate2.with(
  style: "classic",
  faculty: "fm",
  lang: "en",
  document: "sp",
  assignment: (
    personal_number: [A00000007],
    department: [Department of templates],
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
  other_authors: [Ondřej Mekina],
  author_pronouns: "we",
  programme: (en: [MI6000000007 Top secret]),
  specialization: (en: [Creation of templates]),
  citations: "citations.bib",
)

Term paper
