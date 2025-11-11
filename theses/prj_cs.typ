#import "../template/template.typ": *

#show: tultemplate2.with(
  style: "classic",
  faculty: "fm",
  lang: "cs",
  document: "prj",
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
    cs: [Ukázka dokumentu typu Projekt pro FM TUL v češtině],
    en: [Example document for a Project report for FM TUL in Czech],
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

= Co najdete v této šabloně

Tato šablona má sloužit jako ukázková zpráva k ročníkovému projektu napsaná pomocí jazyka *Typst* a šablony
*tultemplate2*. Může posloužit jako jednoduchý základ i pro vaši práci, stačí se naučit používat
pár užitečných funkcí, jako např. vkládání obrázků, tabulek, citací nebo odkazů.

Na rozdíl od souboru _documentation.typ_, který je dostupný ke stažení na stránkách projektu, obsahuje
tento dokument jenom to nejpotřebnější ze znalostí, co postačí k úspěšnému napsání práce. Pokud vám budou nějaké funkce chybět, můžete se podívat do zmíněného souboru, anebo kontaktovat některého z autorů, kteří se vám pokusí pomoct. Jen pro úplnost je zde ve zkratce něco málo o jazyce typst a motivaci k tvorbě této šablony:

Typst je profesionální sázecí nástroj podobný markdownu, LaTeXu/TeXu, groffu, atd.

Typst je moderní obdobou starších nástrojů, které postrádají spoustu důležitých funkcí, bez kterých
se v dnešní době prakticky nedá fungovat. Uživatel často musí importovat nepřeberné množství
balíčků, které poskytují (podle mě) naprosto základní funkcionalitu - jako například správná podpora
UTF-8 znaků, formátování prvků na základě jazykového lokálu, apod.

= Začínáme se šablonou

Tuto šablonu jste si pravděpodobně stáhli z generátoru na webu www.tulsablona.cz a vložili ji do Typst
online editoru. Tím pádem vidíte kromě zdrojového kódu také výsledný PDF soubor. Jak už asi víte, hlavní
rozdíl mezi tradičními textovými procesory jako Microsoft Word nebo LibreOffice Writer a mezi sázecími
programy jako LaTeX nebo Typst je právě způsob, kterým se upravuje vzhled a obsah dokumentu.

Zatímco ve Wordu jsou uživatelé zvyklí, že pomocí tlačítek a klávesových zkratek mění dokument napřímo,
Typst (a i LaTeX) používají tzv. zdrojový soubor, který není ničím jiným než obyčejným textovým souborem,
a následně na vyžádání umí tento zdrojový soubor zkompilovat tj. proměnit na výsledný dokument, např. ve formátu PDF.

Proto zde najdete popis všech důležitých funkcí nikoliv jako galerii obrázků toho, na která tlačítka se má
klikat, nýbrž jako ukázka a návod všech speciálních sekvencí textu, které Typst podporuje a které šablona vyhodnocuje jinak než obsah zprávy.

== Odstavce

Jak jsou někteří z vás možná zvyklí z Markdownu, odstavce, nadpisy a vlastně pro přehlednost všechny
logicky oddělené bloky se oddělují prázným řádkem. Toho jste si jistě mohli při prohlížení tohoto souboru
všimnout. Můžete si vyzkoušet, co se stane, když
použijete jenom ukončení řádku enterem,

nebo když použijete zmíněný prázdný řádek,



anebo co se stane při použití dvou a více prázdných řádků. (spoiler: 1 a více prázdných řádků mají identické
chování, pouze ukončení řádku je interpretováno stejně jako např. mezerník nebo tabulátor)

Uživatel má tím pádem svobodu v tom, jestli ve zdrojovém souboru používá dlouhé řádky plné textu,
nebo
má
raději
přehlednější
formátování
a sám si obsah dělí na řádky, protože ve výsledném PDF souboru se stejně spojí do jednoho celistvého odstavce.
Musí akorát ručně dbát na to, aby odstavce nebyly příliš krátké, ani příliš dlouhé.

S souvislosti s odstavci bych ještě zmínil, že Typst se za vás stará také o zarovnávání písma a slov do bloků
a dělení slov mezi řádky, když už se na něj nevejdou. Chováním odpovídá pravidlům českého pravopisu a typografie, takže se o to nemusíte vůbec starat.

== Klikatelný obsah

Pokud používáte oficiální Typst online editor, můžete jednoduše klepnout na jakýkoliv text v pravé části (náhledové PDF), který se dá měnit,
a editor podle toho automaticky přesune váš kurzor na správné místo.
Je to sice drobná, ale zato velmi užitečná funkce.

== Nadpisy

První důležitá funkce kromě psaní samotného textu, k čemuž není zapotřebí žádná speciální syntax, jsou nadpisy.
Stejně jako v jiných programech, i Typst podporuje nadpisy více úrovní. Pro nadpis první úrovně se používá znaménko
rovná se a mezera na začátku řádku, čili ve zdrojovém souboru Typstu je používán takto:

```typst
= Můj nadpis první úrovně
```

Pro nadpis druhé úrovně pak použijeme dvě rovná se, pro nadpis třetí úrovně tři rovná se.
Šablona *tultemplate2* Vám ovšem bohužel nedovolí nadpis čtvrté a další úrovně, protože by takový
nadpis porušoval směrnice TUL o formátování dokumentů. Ale nemusíte se bát. Pokud takový nadpis
uděláte -- šablona vyhodí chybu, aby vás na to upozornila.

```typst
= Nadpis
== Podnadpis
=== Podpodnadpis

A pak obsah
```

== Číslování kapitol

Asi jste si všimli, že každý nadpis začíná číslem dané kapitoly. Toto číslování provádí Typst automaticky, promítne se následně i v sekci Obsah na začátku souboru, nemusíte se tak opět o nic starat.

= Kontrola šablony při kompilaci

Tato šablona je vytvořena tak, že když se ji pokusíte zkompilovat s nesprávnou syntaxí nebo s nějakou
chybějící důležitou částí hlavičky,
nenechá vás to provést. Vždy se podívejte na chybové hlášky, které šablona vypisuje, protože vás snadno navedou k opravě všech chyb.
Můžete to vyzkoušet tak, že smažete něco z hlavičky nebo že např. použijete funkci, která není nikde definovaná.

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
#strike[přeškrtnuto]
#highlight[zvýrazněno]
#underline[podtrženo] // podtržení by se NEMĚLO používat
```

Pro úplnost a ukázku je zde přímo v textu *tučný text*, _text kurzívou_, #strike[přeškrtnutý text] a #highlight[text zvýrazněný podle barvy příslušící vaší fakultě], #underline[podtržený text] (ačkoli typografové doporučují podtržení nepoužívat).

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
Obrázek se vloží pomocí funkce `image`.

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

Na konec souboru (nebo klidně doprostřed či na začátek, hlavní je, že pouze jednou) je také možné dát strukturu generující přílohy. Momentálně jsou podporované čtyři typy příloh: odkaz, obsah, PDF soubor vložený na konec dokumentu a odkaz na externí soubor (například přiložený do systému s bakalářskou prací).
Jako demonstrace by měla postačit praktická ukázka, která ve zdrojovém kódu následuje hned za tímto odstavcem, a která generuje přílohy tohoto dokumentu.

#attachments(
  attach_link("Zdrojový kód této šablony", "https://git.zumepro.cz/tul/tultemplate2"),
  attach_content("Testovací obsah vygenerovaný Typstem", [Sem lze psát _stylovaný_ obsah.]),
)
