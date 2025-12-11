#import "../template/template.typ": *

#show: tultemplate2.with(
  style: "classic",
  faculty: "fm",
  lang: "en",
  document: "dp",
  assignment: (
    personal_number: [A00000007],
    department: [Department of templates],
    academical_year: [2025/2026],
    content: [
      __assignment__
    ],
  ),
  title: (
    cs: [Ukázka dokumentu typu Diplomová práce v angličtině],
    en: [Example document for a Diploma thesis in English],
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

Diploma thesis
