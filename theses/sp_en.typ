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
    cs: [Ukázka dokumentu typu Bakalářská práce pro FM TUL v angličtině],
    en: [Example document for a Bachelor's thesis for FM TUL in English],
  ),
  author: [Matěj Žucha],
  author_pronouns: "me",
  programme: (en: [MI6000000007 Top secret]),
  specialization: (en: [Creation of templates]),
  citations: "citations.bib",
)

Seminar thesis
