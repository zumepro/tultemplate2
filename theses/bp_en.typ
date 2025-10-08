#import "../template/template.typ": *

#show: tultemplate2.with(
  style: "classic",
  faculty: "fm",
  lang: "en",
  document: "bp",
  title: (
    en: "Example document for a Bachelor's thesis for FM TUL in English",
    cs: "Ukázka dokumentu typu Bakalářská práce pro FM TUL v angličtině",
  ),
  author: "Matěj Žucha",
  author_pronouns: "me",
  supervisor: "Ondřej Mekina",
  consultant: "Michal Procházka (nepovinný údaj)",
  programme: (en: "My beautiful study programme"),
  branch: (en: "My beautiful study branch"),
  abstract: (
    en: [
      This document serves as a practical demonstration of all the important features of the
      _tultemplate2_ template, with useful examples and their respective descriptions.
    ],
    cs: [
      Tento dokument slouží jako praktická ukázka všech důležitcýh funkcí šablony _tultemplate2_,
      s názornými příklady použítí a jejich podrobným popisem.
    ],
  ),
  keywords: (
    en: ("Example", "Keywords", "In", "English"),
    cs: ("Ukázka", "Klíčových", "Slov", "Česky"),
  ),
  acknowledgement: (en: "Lorem ipsum dolor sit amet."),
  citations: "citations.bib",
)

= A quick few words about this template

This template should serve as an example Bachelor thesis written with the help of the *Typst* programming language and the *tultemplate2* template. It can be used as a starting point for your own report, you just have to learn a few of its useful functions, e.g. how to insert images, tables, citacions or links.

In contrast with the _documentation.typ_ file, which is available for download on the project's page, this document only contains the most necessary knowledge to complete most reports. If you find this document lacking in features, you can look at the aforementioned docs or contact one of the authors, who will try to help you. Just for the sake of completeness, here is a few words about the Typst programming aanguage and about Typst, as well as about the motivation behind the creation of this template:

Typst is a professional typesetting language similar to markdown, LaTeX/TeX, groff, etc.

Typst is the modern equivalent of older typesetting tools, which often lack a lot of important features, such that make it next to impossible to work without today. The user must often import an incountable number of packages, which only provide only the most basic of functionalities - for example proper UTF-8 character support, formatting of elements based on the set locale, etc.

= Getting Started with the Template

You have probably downloaded this template from the generator on the website www.tulsablona.cz and inserted it into the Typst online editor. Therefore, besides the source code, you can also see the resulting PDF file. As you probably know, the main difference between traditional word processors like Microsoft Word or LibreOffice Writer and typesetting programs like LaTeX or Typst is the way in which the appearance and content of the document are edited.

While Word users are used to changing the document directly using buttons and keyboard shortcuts, Typst (and also LaTeX) use a so-called source file, which is nothing more than an ordinary text file, and can then, on request, compile this source file – i.e., turn it into the final document, for example in PDF format.

That’s why here you will find a description of all the important functions not as a gallery of images showing which buttons to click, but rather as an example and guide to all the special text sequences that Typst supports and that the template interprets differently from the main content of the report.

== Paragraphs

Some of you might know this concept from using Markdown, where paragraphs, headings and for the sake of clarity all logically coherent blocks are separated by an empty line. You might have already spotted this while reading through this document. You can try for yourself what happens when
you just end the line

or when you properly use an empty line,




or maybe what happens if you use two or more empty rows. (spoiler: 1 or more empty lines share identical behavior, while newlining only is interpreted the same as using spaces or tabs)

Therefore, the user has freedom of choosing whether he uses long lines full of text,
or
if
he
prefers
a
cleaner
formatting
and manages the separation of content to lines, because it all gets concatenated into a nice consice paragraph.
The user has to manually watch out for the length of the paragraphs, so that they are neither too short or too long.

In the context of paragraphs, it should be mentioned that Typst also manages the alignment of text and words into blocks and the division of words between lines when they don't fit.
This behavior complies with the English grammar and typography rules fully, so you don't have to think about that at all.

== Headings

První důležitá funkce kromě psaní samotného textu, k čemuž není zapotřebí žádná speciální syntax, jsou nadpisy.
Stejně jako v jiných programech, i Typst podporuje nadpisy více úrovní. Pro nadpis první úrovně se používá znaménko
rovná se a mezera na začátku řádku, čili ve zdrojovém souboru Typstu je používán takto:

```typst
= Můj nadpis první úrovně 
```

Pro nadpis druhé úrovně pak použijeme dvě rovná se, pro nadpis třetí úrovně tři rovná se... Úrovní podnadpisů je dost na to, že vám pravděpodobně nedojdou.

```typst
= Nadpis
== Podnadpis
=== Podpodnadpis
==== už tomu asi rozumíte ...

A pak obsah
```

== Číslování kapitol

Asi jste si všimli, že každý nadpis začíná číslem dané kapitoly. Toto číslování provádí Typst automaticky, promítne se následně i v sekci Obsah na začátku souboru, nemusíte se tak opět o nic starat.

= Používání funkcí

Používání většiny funkcionalit Typstu je prováděno pomocí tzv. volání funkce. Je to velmi podobné předchozím ukázkám,
akorát místo toho, aby se text obalil pouze jedním symbolem či podobnou jednoduchou značkou, obalíme text jménem dané funkce. Syntaxe vypadá nějak takto:
```typst
#Název_funkce[samotný text nebo jiné parametry]
```
Pokud v editoru napíšete symbol hashtagu, začne vám automaticky našeptávat všechny možné funkce a jejich popisy. Přejdeme rovnou k dalším praktickým příkladům.

== Zvýrazňování textu

Syntaxe základního zvýraznění je velmi podobná například Markdownu. Stačí použít následující symboly:

```typst
*tučně*
_kurzívou_
``` 

Další stylování lze dělat právě přes funkce, viz třeba:

```typst
#underline[podtrženo]
#strike[přeškrtnuto]
#highlight[zvýrazněno]
```

Pro úplnost a ukázku je zde přímo v textu *tučný text*, _text kurzívou_, #underline[podtržený text], #strike[přeškrtnutý text] a #highlight[text zvýrazněný podle barvy příslušící vaší fakultě].

== Odkazy<links>

Odkazy je možné dělat na URL/URI zdroje, e-maily, telefony, atd...
Odkázat URL (URI) je možné bez zavolání funkce, odkaz stačí prostě a jednodušše napsat:
https://git.zumepro.cz/tul/tultemplate2

```typst
https://git.zumepro.cz/tul/tultemplate2
```

Tohle interně volá funkci `link`.

Pokud odkazujeme na méně časté věci (jako e-maily), můžeme použít funkci `link` přímo.
```typst
#link("mailto:ondrej@mekina.cz")
```

Dalši předpony (URI schémata) můžete najít třeba na Wikipedii
https://en.wikipedia.org/wiki/List_of_URI_schemes.

== Obrázky

Obrázky je možné vkládat samotné, nebo i s popiskem.

Obrázek se vloží pomocí funkce `image`:

Přidání popisku a zároveň zalistování obrázku v indexu (aby se na ně třeba dalo odkazovat) lze
udělat pomocí funkce `figure`.

#block([
  ```typst
  #figure(
    image("mujobrazek.jpg"),
    caption: [
      *Krásný* obrázek, který vypadá jako obrázek.
    ]
  )
  ```
], breakable: false)

Tady je praktická ukázka jednoduchého vložení obrázku s popiskem:

#figure(image("../template/assets/tul_logo.svg", width: 25%), caption: [
  Logo *TUL*
])

První parametr funkce je zobrazovaný obsah, v našem případě zmíněný `image`. K němu můžeme psát různé parametry, v příkladu máme třeba nastavení šířky obrázku v procentech. Jako poslední je parametr `caption`, s jehož pomocí můžeme nastavit popisek obrázku/figury.

Obrázky se zobrazí na začátku dokumentu v seznamu (pokud to daný typ dokumentu vyžaduje). I toto za vás Typst dělá automaticky, vám tak stačí do textu přidávat obrázky, jak se to hodí, a všechny se poté korektně zobrazí v Seznamu obrázků s odkazem i správně uvedenou stránkou, na které se obrázek nachází. Obrázky jsou také automaticky číslovány podle předepsaného způsobu, podobně jako kapitoly.

== Tabulky

Tabulky lze vytvářet takto:

```typst
#figure(table(
  columns: 3,
  table.header([], [*Sloupec 1*], [*Sloupec 2*]),
  [*Řádek 1*], [a], [b],
  [*Řádek 2*], [c], [d],
), caption: "Moje krásná tabulka")
```

Parametr `columns` udává počet sloupců tabulky. Poté následuje libovolný počet buněk tabulky, pro lepší přehlednost jsou v příkladu jednotlivé řádky oddělené. Nakonec je zde opět parametr `caption` sloužící k zadání popisku tabulky.

#highlight[Hlavičku tabulky (první řádek) je dobré zabalit do funkce header (viz. výše)], to je
kvůli tomu, že Typst do vygenerovaného PDF souboru poté přidá metadata (například pro osoby se
zrakovým postižením).

#figure(table(
  columns: 3,
  table.header([], [*Sloupec 1*], [*Sloupec 2*]),
  [*Řádek 1*], [a], [b],
  [*Řádek 2*], [c], [d],
), caption: "Moje krásná tabulka")

Tabulky se zobrazí na začátku dokumentu v seznamu (pokud to daný typ dokumentu vyžaduje). Jak už jste asi pochopili, i toto provede šablona automaticky.

== Citace

Šablona podporuje správu citací pomocí standardního BibTeX @bibtex souboru, stejně jako
například LaTeX. Generování citací v BibTeX zápisu umí téměř každá stránka nebo program, které mají pro citace podporu.
Kód takovéto citace ve vhodném formátu stačí přidat do souboru _citations.bib_, poté je možné se
na ně odkazovat pomocí `@jmeno_citace`, nebo `#cite(<jmeno_citace>)`. Můžu se tak třeba odkázat na
citaci Typstu #cite(<typst>).

Formát souboru _citations.bib_ je naprosto stejný jako pro LaTeX. Tyto citace lze přímo vložit
třeba z webu https://www.citace.com ve formátu BibTeX -- Typst tento formát také umí přečíst.
Můžete se do souboru s příponou .bib podívat, zjistíte, že je to opravdu jen obyčejný textový soubor se specifickou strukturou.
V přiloženém ukázkovém souboru už nějaké citace jsou - např. již použitá citace se jménem `typst`.

Soubor, ze kterého se načtou citace lze změnit pomocí argumentu šablony (tj. struktura na začátku souboru):

```typst
#show: tultemplate2.with(
  ...
  citations: "jinysoubor.bib",
  ...
)
```

== Vnitřní odkazy a kotvy<ukazka_odkazu>

Trochu navážeme na Odkazy (@links).

Můžete dělat i vnitřní odkazy třeba na kapitoly, stránky nebo obrázky s popiskem (zabalené ve
`figure`).

```typst
= Dobrá kapitola<dobra_kapitola>

Podívejme se na Dobrou kapitolu (@dobra_kapitola).
```

Takhle vypadá kotva:

```typst
<nazev_kotvy>
```

Kotvu dáte někam do souboru a můžete na ní odkazovat stejně jako na citace:

```typst
@nazev_kotvy
```
Můžeme se podívat na názornou ukázku odkazu (@ukazka_odkazu).

== Zkratky

LaTeX TUL šablona má k začátku dokumentu seznam zkratek. Proto jsme ho přidali i do této šablony.
Seznam zkratek je v této šabloně nastaven tak, aby se zobrazoval pouze pokud je v něm alespoň jedna
zkratka (přišlo nám to poměrně logické).

Zkratku #abbr("ABC", "Abeceda") vytvoříte (definujete) pomocí:

```typst
#abbr("ABC", "Abeceda")
```

Potom zkratku #abbr("ABC") už můžete použít přímo (bez opakované definice):

```typst
#abbr("ABC")
```

Šablona zajistí následující věci:
- Zkratka se zobrazí v seznamu zkratek
- Při prvním použití zkratky vás šablona donutí zkratku definovat
- Definice zkratky bude použita právě jednou (poprvé)

Při prvním použití zkratky (při definici) bude zkratka v textu vypadat takto:
#abbr("ZK", "Zkratka").
Při dalších použití bude vypadat takto: #abbr("ZK").

#highlight[
  Tedy zkratku _nepřidáváte_ přímo do seznamu zkratek, ale elegantně jí používáte přímo v textu.
]

== Přílohy

Na konec souboru (nebo klidně doprostřed či na začátek, hlavní je, že pouze jednou) je také možné dát strukturu generující přílohy. Momentálně jsou podporované dva typy příloh, odkaz a obsah.
Jako demonstrace by měla postačit praktická ukázka, která ve zdrojovém kódu následuje hned za tímto odstavcem, a která generuje přílohy tohoto dokumentu.

#attachments(
  attach_link("Zdrojový kód této šablony", "https://git.zumepro.cz/tul/tultemplate2"),
  attach_content("Testovací obsah vygenerovaný Typstem", [Sem lze psát _stylovaný_ obsah.]),
)
