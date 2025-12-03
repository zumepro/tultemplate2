#import "../template/template.typ": *

#show: tultemplate2.with(
  style: "classic",
  faculty: "fm",
  lang: "cs",
  document: "presentation",
  author: [Ondřej Mekina],
  title: (
    cs: [Ukázka prezentace v šabloně tultemplate2],
  ),
  presentation: (
    append_thanks: true,
    wide: false,
    first_heading_is_fullpage: true,
  ),
  citations: "citations.bib",
)

= Úvod

== Jak použít prezentaci

- tato šablona slouží jako ukázka použití Typst TUL šablony k tvorbě prezentace
- můžete zde používat všechny funkcionality Typstu, stejně jako u ostatních dokumentů
- slajdy fungují podobně jako v Latexu - každý nadpis 1. úrovně tvoří nový slajd
  - v případě použití _first_heading_is_fullpage_ neplatí - viz dále
- možno používat i nadpisy druhé úrovně

= Možnosti šablony

== Argumenty funkce šablony

- _append_thanks_: Jestli na závěr přidat slajd s poděkováním
- _wide_: Použití formátu 16:9 místo 4:3 na všechny slajdy
- _first_heading_is_fullpage_: vloží každý nadpis 1. úrovně na samostatný slajd, takže logicky rozčlení prezentaci
  - zároveň tvoří nový slajd pro každý nadpis 2. úrovně
  - pokud je vypnuta, nadpisy 2. úrovně *netvoří* nový slajd

== Struktura

- prezentace začíná titulní stranou - nastaveno pomocí generátoru
- na začátku není automaticky generovaný obsah - uživatel ho může snadno vytvořit pomocí odrážek či číslovaného seznamu
- po samotném obsahu přichází slajd s citacemi - automaticky generováno
- volitelně poděkování

== Použití citací

- tady jsou citace: Citace 1 @typst a citace 2 @bibtex
