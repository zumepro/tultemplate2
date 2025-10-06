#import "template/template.typ": *

#show: tultemplate2.with(
  title: (cs: "Návod na použití Typst TUL šablony"),
  author: "Ondřej Mekina, Matěj Žucha",
  supervisor: "Ondřej Mekina",
)

= Lehký úvod do Typstu a této šablony

Typst je profesionální sázecí nástroj podobný markdownu, LaTeXu/TeXu, groffu, atd.

Typst je moderní obdobou starších nástrojů, které postrádají spoustu důležitých funkcí, bez kterých
se v dnešní době prakticky nedá fungovat. Uživatel často musí importovat nepřeberné množství
balíčků, které poskytují (podle mě) naprosto základní funkcionalitu - jako například správná podpora
UTF-8 znaků, formátování prvků na základě jazykového lokálu, apod.

Další velkou výhodou Typstu je velmi rychlá kompilace dokumentů. S použitím inkrementální kompilace
pomocí Typstové funkce `watch` je vše prakticky instantní. On-line Typst aplikace na URL
https://typst.app/play, kterou bych doporučil používat začátečníkům, se prakticky až vychloubá
rychlou kompilací -- změny vidíte téměř po každém stisku klávesy.

Tyto dva hlavní důvody byly mou motivací pro tvorbu této šablony.

== Hlášení chyb a návrhy na funkce

Mainteinerem šablony jsem já, Ondřej Mekina, ale jakékoliv návhry na zlepšení, pomoc s vývojem a
hlášení chyb moc rád uvítám.

Pokud budete mít dotaz na fungování (vysvětlivky se snažím přidávat do tohoto ukázkového dokumentu),
návrh, nebo budete chtít nahlásit chybu, využijte jeden z následujících komunikačních kanálů:
- Můj e-mail: #link("mailto:ondrej@mekina.cz", "ondrej@mekina.cz")
- Issues na gitu šablony: https://git.zumepro.cz/tul/tultemplate2

= První krůčky, aneb jak rozchodit šablonu

== Editor, CLI, LSP

Jaký zvolit editor?

=== Pro lidi, kteří svůj život nežijí v příkazové řádce

Pro začátečníky doporučuji použít on-line Typst editor https://typst.app/play. Můžete ho vyzkoušet
i bez účtu.

=== Pro Arch uživatele

Pro pokročilejší je možné použít i CLI (je v Arch repu a jmenuje se... uhodnete to? `typst`).
Soubor zkompilujete pomocí:
```sh
typst compile file.typ
```
#highlight[Pozor! Pro kompilaci s touto šablonou budete chtít ještě fonty:]
```sh
typst compile --font-path template/fonts file.typ
```
Kde `template` je název složky s touto šablonou -- změňte dle potřeby.

Jako LSP doporučuji použít `tinymist` (pro nvim je v masonu), téměř kompletně podporuje funkce
(umí například `textDocument/definition` nebo `textDocument/signatureHelp`, docela fajn věci).

== Absolutní minimum

Rozchodit šablonu je poměrně jednoduché. Stačí do projektu vložit složku se šablonou a použít
import, nezapomeňte nahradit `nazev_slozky` za název složky.
```typst
#import "nazev_slozky/template.typ": *
```
Takto naimportujete všechny nabízené funkce. To obsahuje hlavní šablonovou funkci `tultemplate`,
ale i dodatečné funkce pro jednodušší práci se šablonou -- k těm se dostaneme později.

Dále je potřeba funkci zavolat jako šablonu, abychom pod ní mohli psát obsah.
```typst
#show: tultemplate
```
A to je vše. Absolutní minimum pro rozchození šablony. Nebojte se, pokud neznáte názvy
vzhledů šablony, zkratku fakulty, nebo zkratku pro jazyk. Šablona vás navede pomocí chybových
hlášek (nebo se můžete podívat do zdrojového souboru pro toto PDF `example.typ`).

== Titulní stránka

Nyní pojďme přidat nějaký obsah na titulní stránku. Jednoduše do volání šablony přidáme další
parametry.
```typst
#show: tultemplate.with(..., title: (cs: "Můj úžasný dokument"), author: "Já")
```
Všechny možné parametry by vám měl našeptávat váš editor (nebo LSP) -- poslouchejte takové nápovědy,
opravdu hodně vám to usnadní práci.

= Základy formátování v Typstu

// tohle je podnadpis :)
#heading(
  level: 3,
  range(1, 6).map((v) => range(1, v).map((_) => "pod").join("") + "nadpisy").join(", ") + ", ..."
)<chained_subheading>

Velmi jednoduché. Stačí na začátek řádku dát znak `=` kolikrát chcete.
```typst
= Nadpis
== Podnadpis
=== Podpodnadpis
==== už tomu asi rozumíte ...

A pak obsah
```

== Zvýrazňování textu

Syntaxe je velmi podobná například markdownu. Stačí:
```typst
*tučně*
_kurzívou_
```
Další stylování lze dělat přes funkce.
```typst
#underscore[podtrženo]
#strike[přeškrtnuto]
```

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

Už jsme několikrát narazili na funkce, tak to dále neodkládejme a vzhůru na @functions.

== Funkce<functions>

Funkce se v Typstu volají pomocí znaku `#`.
Některé funkce neberou žádné parametry.
```typst
#linebreak // Zalomí (ukončí) řádek, je možné také udělat jeden prázdný řádek v kódu
```
Některé funkce berou parametry ve skriptovací podobě.
```typst
#profile("debug") // Zapne ladící profil (todo funkce nehází chyby, o tom více později)
```
A některé funkce berou klasický obsah -- v těch je možné psát obsah jako kdyby byl mimo funkci.
```typst
#highlight[
  = Nadpis

  Text. *Tučný text*
]
```
#highlight[
  Sledujte nápovědy editoru. Když napíšete \#, tak vám editor nabídne kupu funkcí.
  V on-line editoru se dá hledat ve vyskakovací nabídce. Vestavěné funkce jsou pojmenovány
  srozumitelně a očekávatelně.
]

== Obrázky

Obrázky je možné vkládat samotné i třeba s popiskem.

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

#figure(image("template/assets/tul_logo.svg", width: 25%), caption: [
  Logo *TUL*
])

Obrázky se zobrazí na začátku dokumentu v seznamu (pokud to daný typ dokumentu vyžaduje).

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

#highlight[Hlavičku tabulky (první řádek) je dobré zabalit do funkce header (viz. výše)], to je
kvůli tomu, že Typst do vygenerovaného PDF souboru poté přidá metadata (například pro osoby se
zrakovým postižením).

#figure(table(
  columns: 3,
  table.header([], [*Sloupec 1*], [*Sloupec 2*]),
  [*Řádek 1*], [a], [b],
  [*Řádek 2*], [c], [d],
), caption: "Moje krásná tabulka")

Tabulky se zobrazí na začátku dokumentu v seznamu (pokud to daný typ dokumentu vyžaduje).

== Citace

Šablona podporuje správu citací pomocí standardního BibTeX @bibtex souboru, stejně jako
například LaTeX. Citace ve vhodném formátu stačí přidat do souboru _citations.bib_, poté je možné se
na ně odkazovat pomocí `@jmeno_citace`, nebo `#cite(<jmeno_citace>)`. Můžu se tak třeba odkázat na
citaci Typstu #cite(<typst>).

Formát souboru _citations.bib_ je naprosto stejný jako pro LaTeX. Tyto citace lze přímo vložit
třeba z webu https://www.citace.com ve formátu BibTeX -- Typst tento formát také umí přečíst.

Soubor, ze kterého se načtou citace lze změnit pomocí argumentu šablony:

```typst
#show: tultemplate2.with(
  ...
  citations: "jinysoubor.bib",
  ...
)
```

== Vnitřní odkazy a kotvy

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

== Pro pokročilé

Typst má spoustu dalších způsobů stylování (a i skriptování). Podívejte se třeba na zdrojový kód
pro nadpis @chained_subheading.

Tyto pokročilejší funkce v drtivé většině dokumentů vůbec není potřeba použít. Nicméně pro
ty, kteří to chtějí vyzkoušet, nebo to opravdu potřebují: podívejte se buď do zdrojového kódu
této šablony nebo na dokumentaci Typstu https://typst.app/docs/.

= Pracujeme se šablonou

V předchozí kapitole jsme se dozvěděli, jak pracovat s Typstem. Šablona je navržena tak, aby
co nejvíce využívala základních funkcí Typstu -- například:
- Když uděláte nadpis -- zobrazí se v tabulce obsahu
- Když zvýrazníte text pomocí funkce `highlight` -- zvýraznění bude v barvách vaší fakulty
- Když přidáte citaci, zobrazí se v bibliografii na konci dokumentu
- Nadpis první úrovně bude na nové stránce
- ...

V této kapitole se naučíme vymaxovat využití této šablony za pomocí dalších funkcí a syntaxe.

#pagebreak(weak: true)
== Parametry této šablony

Šablonu standardně použijete takto:
```typst
#show: tultemplate2.with(
  <název_parametru>: <hodnota_parametru>,
  <nazev_dalšího_parametru>: "<hodnota_dalšího_parametru>",
  ...
)
```

Funkce `tultemplate2` přijímá následující parametry.
Zvýrazněné hodnoty jsou základní -- pokud vynecháte parametr, pak bude použita tato hodnota.

#line()
- `style` (vizuální styl dokumentu)
  - *`"classic"`* - Klasický vizuální styl. Tento styl je neblíže klasické formální
    podobě dokumentů. _(doporučeno pro nováčky této šablony)_
#line()
- `faculty` (zkratka fakulty)
  - *`"tul"`* - barvy a logomarky univerzity
  - `"fs"` - fakulta strojní
  - `"ft"` - fakulta textilní
  - `"fp"` - fakulta přírodovědně-humanitní a pedagogická
  - `"ef"` - ekonomická fakulta
  - `"fua"` - fakulta umění a architektury
  - `"fm"` - fakulta mechatroniky, informatiky a mezioborových studií
  - `"fzs"` - fakulta zdravotnických studií
  - `"cxi"` - ústav pro nanomateriály, pokročilé technologie a inovace
#line()
- `lang` (základní jazyk dokumentu)
  - *`"cs"`* - čeština
  - `"en"`
#line()
- `document` (typ dokumentu)
  - *`"other"`* - nespecifikovaný (neformální) typ dokumentu
  - `bp` - Bakalářská práce
#line()
- `title` (nadpis dokumentu)
  - Ve formátu `(<zkratka_jazyka>: "<nadpis>")`, například `(cs: "Můj nadpis")`
  - Pro většinu dokumentů (kromě `other`) jsou vyžadovány verze _cs_ a _en_ (kvůli abstraktu).
#line()
- `author` (autor/autoři dokumentu)
  - Příklad: `"Pavel Novák"` nebo `"Petra Velká, Jindřich Peterka"`
#line()
- `author_pronouns` (jazykový rod autora - není potřeba pro angličtinu, která má základní hodnotu)
  - Pro vybraný jazyk _cs_:
    - `"masculine"` - Mužský rod
    - `"feminine"` - Ženský rod
    - `"we"` - Množné číslo
  - Pro vybraný jazyk _en_:
    - *`"me"`* - První osoba jednotného čísla
    - `"we"` - První osoba množného čísla
#line()
- `supervisor` (vedoucí práce) <arg_supervisor>
  - V podobě textového řetězce, příklad: `"prof. Jindřich Jindřich"`
  - Ve formátu `(name: "<jméno>", institute: "<institut>")` (toto lze využít například při DP)
#line()
- `consultant` (konzultant práce)
  - Stejně jako u #link(<arg_supervisor>, [`supervisor`])
#line()
- `programme` (studijní program) <arg_programme>
  - Ve formátu `(<zkratka_jazyka>: "<název_programu>")`
  - Je vyžadován jazyk, který je vybrán pro celou šablonu -- tohle je pojistka, aby uživatel šablony
    nevynechal vybraný jazyk
#line()
- `branch` (studijní obor)
  - Stejně jako #link(<arg_programme>, [`programme`])
#line()
- `abstract` (abstrakt)
  - Ve formátu `(<zkratka_jazyka>: [<abstrakt>])`, například `(cs: [Můj *krásný* abstrakt.])`
  - Dokumenty vyžadují _cs_ i _en_ abstrakt (kromě typu dokumentu `other`).
#line()
- `keywords` (klíčová slova zobrazovaná pod abstraktem)
  - Ve formátu `(<zkratka_jazyka>: ("slovo1", "slovo2", ...))`
#line()
- `assignment` (PDF soubor se zadáním)
  - Ve formě cesty k souboru, například: `"zadani.pdf"`. Pokud je tento argument vynechán, bude
    vložena hláška "vložte zadání" na příslušné místo v dokumentu -- tu stranu můžete pak nahradit
    originálem zadání.
#line()
- `citations` (BibTex soubor s citacemi)
  - Ve formě cesty k souboru, například: `"citace.bib"`. Pokud není specifikován, bude použit
    výchozí (`"citations.bib"`).

#pagebreak(weak: true)
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

V některých typech dokumentů budete chtít přidat přílohy. Přílohy se přikládají v různých podobách:

- Jako odkaz (URL/URI adresa)
- Zmínka externího souboru (například další soubor nahraný do systému)
- Přiložený obsah (vygenerovaný Typstem v tomto dokumentu -- je tedy součástí tohoto kódu)
- Externí PDF soubor přiložený jako obsah (jiný PDF dokument, vložený do příloh v kompletní
  podobě -- to je dobré například do tisku, kde můžete přílohy vytisknout s dokumentem)

#highlight[
  Přílohy lze definovat *pouze na jednom* místě v dokumentu, aby se zabránilo omylnému opakování
  příloh. Přílohy doporučujeme definovat *na konci* souboru pro přehlednost.
]

Zde je ukázka definice příloh (je také použita na konci tohoto ukázkového souboru):

```typst
#attachments(
  attach_link(
    "Zdrojový kód této šablony",
    "https://git.zumepro.cz/tul/tultemplate2"
  ),
  attach_content(
    "Testovací obsah vygenerovaný Typstem",
    [Sem lze psát _stylovaný_ obsah.]
  ),
)
```

= Workflow a jak si zjednoduššit práci

Tyhle věci používat _nemusíte_, aby vám šablona fungovala. Nicméně často jsou poměrně fajn.

== Protypování

=== Profily

Šablona disponuje funkcí `profile`. Funkce na prototypování šablony jsou nastaveny tak, aby
při zapnutí profilu pro finální verzi buď vrátily čistou verzi dokumentu, nebo vyhodily error.

K dispozici jsou profily:
- `debug` - Prototypování je povoleno, výstupem bude verze dokumentu s poznámkami
- `release` - Výstupem bude čistý výsledný dokument

Při generování výstupu je doporučeno hned za volání šablony na začátku souboru přidat:

```typst
#profile("release")
```

To vám pojistí, aby ve výstupu nebyly poznámky a todo.

Pokud funkci `profile` nezavoláte, pak šablone použije profil "debug".

=== Todo

Pomocí `todo` svému budoucímu já můžete připomenout, že je něco potřeba dodělat. Funkce todo obsah
zvýrazní, a v případě, že je zvolený profil "release", při kompilaci vyhodí error. To vám
vlastně zabrání použít funkci todo v profilu "release".

Zvýraznění také můžete vypnout (ale pak se vám `todo` bude hůř hledat - budete muset hledat v kódu).

Zde je ukázkové použití:
#block([
```typst
#todo(
  "koupit vajíčka",
  accent: false // vypnout zvýraznění (pokud chcete)
)
```
], breakable: false)

=== Lorem

Typst má funkci, která vám vygeneruje text Lorem Ipsum -- ten může sloužit na otestování délky
paragrafů, počtu písmen, atd...

```typst
#lorem(10)
```

Výše volaná funkce vygeneruje deset slov Lorem Ipsum. Doporučuji `lorem` kombinovat s `todo`.

```typst
#todo(lorem(10), accent: false)
```

Takhle si můžete předpřipravit délku odstavců a vyzkoušet si, jestli se rozsahem práce trefíte
do požadavků. Pak můžete postupně přepisovat/vyplňovat.

Funkce `todo` vám zároveň zabrání v tom, aby se text Lorem Ipsum vyskytl ve výsledném dokumentu.

#attachments(
  attach_link("Zdrojový kód této šablony", "https://git.zumepro.cz/tul/tultemplate2"),
  attach_content("Testovací obsah vygenerovaný Typstem", [Sem lze psát _stylovaný_ obsah.]),
)
