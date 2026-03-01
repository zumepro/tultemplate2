#import "template/template.typ": *

#show: tultemplate2.with(
  title: (cs: [Technická dokumentace Typst TUL šablony]),
  author: ([Ondřej Mekina], [Matěj Žucha]),
)

#profile("release")

= Informace o sestavení

Tento dokument byl sestaven #datetime.today().display("[day]. [month]. [year]").
#highlight[Informace v tomto dokumentu nemusí sedět pro starší verze šablony.]
Pokud máte šablonu vygenerovanou generátorem, nebo staženou jako minimální build, zkontrolujte
časové razítko v souboru `template/build_date.txt`.

= Minimální build pro offline použití

Pokud chcete pouze adresář se šablonou (bez ostatních vygenerovaných souborů), stáhněte si soubor
https://typst.tul.cz/tultemplate2_minimal.zip.
#highlight[Tato možnost se ale nedoporučuje pro začátečníky.]

`tultemplate2_minimal.zip` je automaticky generovaný soubor s nejnovější stabilní verzí šablony
sestavenou k přímému použití.

Pro automatické sestavení lze využít následujícího souboru _Makefile_
(se systémově dostupnými nástroji _typst_, _wget_ a _unzip_).

#raw(read("./minimal.mk"), block: true, lang: "make")

Tento soubor je rovněž dostupný v repozitáři šablony (https://git.zumepro.cz/tul/tultemplate2)
pod názvem `minimal.mk`.

= Zdrojový kód a zdroje sestavení

Repozitář šablony není jediným zdrojem pro sestavení všech nástrojů, se kterými uživatelé budou
pracovat.
Dále si můžete prohlédnout způsob, jakým se sestavuje nejnovější verze šablony, ukázek a generátoru.

== Přehled toolchainu šablony

#v(.5em)

#import "@preview/fletcher:0.5.8" as fletcher

#let template = "https://git.zumepro.cz/tul/tultemplate2"
#let generator = "https://git.zumepro.cz/tul/tultemplategen"
#let much_pdf_tools = "https://git.zumepro.cz/ondrej.mekina/much_pdf_tools"
#let theses = "https://git.zumepro.cz/tul/tultemplate_theses"
#let stagspider = "https://git.zumepro.cz/tul/tultemplate_stagspider"
#let htmltypst = "https://git.zumepro.cz/ondrej.mekina/htmltypst"
#let web = "https://git.zumepro.cz/tul/tultemplate-web"

#align(center, {
  fletcher.diagram(
    fletcher.node(
      (-1, -1),
      link(much_pdf_tools)[pdf nástroje],
      shape: fletcher.shapes.rect,
      stroke: black,
      inset: .5em,
    ),
    fletcher.node(
      (1, -1),
      text([Typst], size: .8em),
      inset: .5em,
    ),
    fletcher.node(
      (0, 0),
      link(template, text([tultemplate2], size: 1.5em)),
      shape: fletcher.shapes.rect,
      stroke: black,
      inset: 1em,
    ),
    fletcher.edge((-1, -1), (0, 0), "-|>"),
    fletcher.edge((1, -1), (0, 0), "--|>"),
    fletcher.edge("-|>"),
    fletcher.node(
      (0, 1),
      link(theses, text([ukázky], size: 1.3em)),
      shape: fletcher.shapes.rect,
      stroke: black,
      inset: .6em,
    ),
    fletcher.node(
      (-1, 1),
      link(stagspider, text([stagspider], size: .8em)),
      shape: fletcher.shapes.rect,
      stroke: gray,
      inset: .5em,
    ),
    fletcher.edge("--|>"),
    fletcher.node(
      (-1, 2),
      link(generator, text([generátor], size: 1.3em)),
      shape: fletcher.shapes.rect,
      stroke: black,
      inset: .6em,
    ),
    fletcher.edge((0, 0), (-1, 2), "-|>"),
    fletcher.edge((0, 1), (-1, 2), "-|>"),
    fletcher.node(
      (1, 1),
      link(htmltypst, text([htmltypst], size: .8em)),
      shape: fletcher.shapes.rect,
      stroke: gray,
      inset: .5em,
    ),
    fletcher.edge((1, -1), (1, 1), "--|>"),
    fletcher.edge("--|>"),
    fletcher.node(
      (1, 2),
      link(web, text([web], size: 1.3em)),
      shape: fletcher.shapes.rect,
      stroke: black,
      inset: .6em,
    ),
    fletcher.edge((-1, 2), (1, 2), "--|>"),
    fletcher.edge((0, 0), (1, 2), "-|>"),
    fletcher.edge((0, 1), (1, 2), "-|>"),
    fletcher.edge("--|>"),
    fletcher.node(
      (1, 3),
      link("https://typst.tul.cz/cs/", text([typst.tul.cz])),
      inset: .6em,
    ),
    fletcher.node(
      (-1, 3),
      link("https://typst.tul.cz/generate/?lang=cs", text([typst.tul.cz/generate/])),
      inset: .6em,
    ),
    fletcher.edge((-1, 2), (-1, 3), "--|>"),
  )
})

== Repozitáře

- #link(template, [*tultemplate2*]) -- Domov šablony. Zde se tvoří samotná šablona.
- #link(generator, [*tultemplategen*]) -- Repozitář generátoru. Zde se na základě nejnovější šablony
  tvoří webový generátor.
- #link(web, [*tultemplate-web*]) -- Webová dokumentace k šabloně a generátoru. Dostupná na
  https://typst.tul.cz/cs/
- #link(theses, [*tultemplate_theses*]) -- Generování celých ukázkových dokumentů a vzorového kódu
  pro generátor.
- #link(much_pdf_tools, [*much_pdf_tools*]) -- WASM nástroje pro práci s PDF v Typstu.
- #link(htmltypst, [*htmltypst*]) -- Nástroje na automatické sázení Typst kódu pro web.
- #link(stagspider, [*tultemplate_stagspider*]) -- Automatický crawler na data ze STAGu.
  Data se používají v generátoru pro snadnější výběr některých položek (například specializací).

= Argumenty šablony

Následujících pár stránek je kompletní soupis argumentů, které tato šablona přijímá.
Pokud s šablonou nemáte rozsáhlé zkušenosti, doporučujeme raději využít generátoru
(https://typst.tul.cz/generate/).

// Automaticky generovaný seznam argumentů
#import "template/arguments.typ": print_argument_docs
#print_argument_docs(lang: "cs")
