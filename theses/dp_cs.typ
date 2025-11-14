#import "../template/template.typ": *

#show: tultemplate2.with(
  style: "classic",
  faculty: "fm",
  lang: "cs",
  document: "dp",
  assignment: (
    personal_number: [A00000007],
    department: [Ústav šablon],
    academical_year: [2025/2026],
    content: [
      = Zásady pro vypracování:
      + Seznamte se s možnostmi šablon
      + Navrhněte několik možných stylů šablon
      + Seznamte se s nástrojem Typst
      + Implementujte šablonu
      + Zkonzultujte šablonu
      + Opravte spoustu věcí
      + Zkonzultujte šablonu
      + Opravte spoustu věcí
      + Zkonzultujte šablonu
      + Snad už nebude nic potřeba opravit
      = Seznam odborné literatury:
      _Přísně tajné_
    ],
  ),
  title: (
    cs: [Ukázka dokumentu typu Diplomová práce pro FM TUL v češtině],
    en: [Example document for a Diploma thesis for FM TUL in Czech],
  ),
  author: [Matěj Žucha],
  author_pronouns: "masculine",
  programme: (cs: [MI6000000007 Přísně tajné]),
  specialization: (cs: [Vytváření šablon]),
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
  acknowledgement: (cs: [Lorem ipsum dolor sit amet.]),
  citations: "citations.bib",
)

Diplomová práce
diplomovou prací
