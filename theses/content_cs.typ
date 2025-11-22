#import "../template/template.typ": *

#show: tultemplate2

= Úvod do této šablony

Tato šablona má sloužit jako ukázka práce typu `{{ta}}` v nástroji *Typst* a šabloně *tultemplate2*.
Může posloužit jako jednoduchý základ i pro vaši práci, stačí se naučit používat pár užitečných funkcí, jako např. vkládání obrázků, tabulek, citací nebo odkazů.

Na rozdíl od souboru _documentation.typ_, který je dostupný ke stažení na stránkách projektu, obsahuje tento dokument jenom to nejpotřebnější ze znalostí, co postačí k úspěšnému napsání práce.
Pokud vám budou nějaké funkce chybět, můžete se podívat do zmíněného souboru, anebo kontaktovat některého z autorů, kteří se vám pokusí pomoct.
Jen pro úplnost je zde ve zkratce něco málo o nástroji Typst a motivaci k tvorbě této šablony:

Typst je profesionální sázecí nástroj podobný Markdownu, LaTeXu/TeXu, Groffu, atd.

Typst je moderní obdobou starších nástrojů, které postrádají spoustu důležitých funkcí, bez kterých se v dnešní době prakticky nedá fungovat.
Uživatel často musí importovat nepřeberné množství balíčků, které poskytují (podle mě) naprosto základní funkcionalitu -- jako například správná podpora UTF-8 znaků, formátování prvků na základě jazykového lokálu, apod.

== Začínáme pracovat

Tuto šablonu jste si pravděpodobně stáhli z generátoru na webu https://tulsablona.zumepro.cz a vložili ji do Typst online editoru.
Tím pádem vidíte kromě zdrojového kódu také výsledný PDF soubor.
Jak už asi víte, hlavní rozdíl mezi tradičními textovými procesory jako Microsoft Word nebo LibreOffice Writer a mezi sázecími programy jako LaTeX nebo Typst je právě způsob, kterým se upravuje vzhled a obsah dokumentu.

Zatímco ve Wordu jsou uživatelé zvyklí, že pomocí tlačítek a klávesových zkratek mění dokument napřímo, Typst (a i LaTeX) používají tzv. zdrojový soubor, který není ničím jiným než obyčejným textovým souborem, a následně na vyžádání umí tento zdrojový soubor zkompilovat tj. proměnit na výsledný dokument, např. ve formátu PDF.

Proto v tomto dokumentu najdete popis všech důležitých funkcí nikoliv jako galerii obrázků toho, na která tlačítka se má klikat, nýbrž jako ukázka a návod všech speciálních sekvencí textu, které Typst podporuje a které šablona vyhodnocuje jinak než obsah zprávy.

#rect[
  *TIP*:
  Uložte si tento dokument pro pozdější použití.
  Až budete hledat nějakou specifickou funkci, můžete se k ní prokliknout přes seznam obsahu nahoře.
]

== Hlavička a obsah

Když se podíváte na zdroj dokumentu (vlevo, pokud jste v online editoru), tak si můžete všimnout, že zdroj se skládá z dvou hlavních části: hlavičku (ta na první pohled může vypadat docela strašidelně) a obsah.

=== Hlavička

Hlavička definuje všechny potřebné informace pro úspěšné vygenerování dokumentu -- například fakultu, název práce, atd.

Údaje v hlavičce buď můžete upravit rovnou ručně, nebo se k obsahu prokliknout a začít psát.
Na to navážeme hned v další kapitole.

=== Obsah

Obsah je už z většiny samotný text vaší práce.
Zdroj dokumentu, kromě samotného textu, také obsahuje speciální znaky (odborně tomu říkáme syntaxe), které Typstu vysvětlí jak si dokument přejete naformátovat.

== Klikatelný obsah v hlavičce

Pokud používáte oficiální Typst online editor, můžete jednoduše klepnout na téměř jakýkoliv text na pravé půlce obrazovky (náhledové PDF), a editor podle toho automaticky přesune váš kurzor na správné místo.
Je to sice drobná, ale zato velmi užitečná funkce.

#rect[
  *TIP*:
  Zkuste například dvakrát poklepat na obsah abstraktu (nebo název práce u projektů a semestrálních prací -- pokud nemáte titulní strany ze STAGu) a začít psát.
]

== Kontrola šablony při kompilaci

Tato šablona je vytvořena tak, že když se ji pokusíte zkompilovat s nesprávnou syntaxí nebo s nějakou chybějící důležitou částí hlavičky, nenechá vás to provést.
Vždy se podívejte na chybové hlášky, které šablona vypisuje, protože vás snadno navedou k opravě všech chyb.
Můžete to vyzkoušet tak, že smažete něco z hlavičky nebo že např. použijete funkci, která není nikde definovaná.

Pokud jste hlavičku vygenerovali z generátoru -- neměli byste s ní mít žádné problémy.
Generátor je nastaven tak, aby vás nenechal vygenerovat špatnou hlavičku.

= Základní formátování obsahu

Formátování (sázení) textu v Typstu je ve většině případů velice jednoduché.
V této kapitole vám ukážeme nějaké základy, které budete běžně používat.

== Odstavce

Jak jsou někteří z vás možná zvyklí z Markdownu, odstavce, nadpisy a vlastně pro přehlednost všechny logicky oddělené bloky se oddělují prázným řádkem.
Toho jste si jistě mohli při prohlížení tohoto souboru všimnout.
Můžete si vyzkoušet, co se stane, když
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

V souvislosti s odstavci bych ještě zmínil, že Typst se za vás stará také o zarovnávání písma a slov do bloků
a dělení slov mezi řádky, když už se na něj nevejdou.

== Nadpisy

První důležitá funkce kromě psaní samotného textu, k čemuž není zapotřebí žádná černá magie, jsou nadpisy.
Stejně jako v jiných programech, i Typst podporuje nadpisy více úrovní. Pro nadpis první úrovně se používá znaménko rovná se a mezera na začátku řádku, čili ve zdrojovém souboru Typstu je používán takto:

```typst
= Můj nadpis první úrovně
```

Pro nadpis druhé úrovně pak použijeme dvě rovná se, pro nadpis třetí úrovně tři rovná se.
Šablona *tultemplate2* Vám ovšem bohužel nedovolí nadpis čtvrté a další úrovně, protože by takový nadpis porušoval směrnice TUL o formátování dokumentů.
Ale nemusíte se bát. Pokud takový nadpis uděláte -- šablona vyhodí chybu, aby vás na to upozornila.

```typst
= Nadpis
== Podnadpis
=== Podpodnadpis

A pak obsah
```

== Číslování kapitol

Asi jste si všimli, že ve výstupu každý nadpis začíná číslem dané kapitoly.
Toto číslování provádí Typst automaticky, promítne se následně i v sekci *Obsah* na začátku souboru, nemusíte se tak opět o nic starat.

#rect[
  *TIP*:
  Schválně si zkuste napsat nadpis čtvrté úrovně.
  Alespoň se tak jednodušše seznámíte se způsobem, jakým vám tato šablona skrz Typst hlásí chyby.
  Pokud se při poklikání na error ocitnete v jiném souboru -- prostě se jednodušše vraťte přes menu souborů.
]

== Zvýrazňování textu

Syntaxe základního zvýraznění je velmi podobná například Markdownu.
Stačí použít následující symboly:

```typst
*tučně*
_kurzívou_
#highlight[zvýrazněno]
```

Další stylování lze dělat právě přes funkce, viz třeba:

```typst
#strike[přeškrtnuto]
```

Pro úplnost a ukázku je zde přímo v textu *tučný text*, _text kurzívou_, #strike[přeškrtnutý text] a #highlight[text zvýrazněný podle barvy příslušící vaší fakultě].
Lze sázet také #underline[podtržený text] (ačkoli typografové doporučují podtržení nepoužívat).

== Zalamování řádků

Typst vám nějak zalomil řádek a vám se to nelíbí? Pojďme to vyřešit.

=== Nucené zalomení rádku

Pokud chcete vynutit zalomení, stačí na konec řádku ve zdrojovém souboru napsat znak "`/`".
Například:

```typst
*Alice*: Jak napsat skvělou práci? \
*Bob*: Pomocí Typstu!
```

V příkladu výše bude otazník posledním znakem prvního řádku -- Typst nám tady řádky nespojí.

=== Nezalomitelná mezera

Možná už jste tento pojem někdy slyšeli.
Pokud chcete například napsat nějaký název a nemá v něm být zalomení řádku, můžete použít znak "`~`".
Ukázka:

```typst
Ano, chodím na Technickou univerzitu v~Liberci.
```

V ukázce výše ve výstupu Typst nikdy neukončí řádek mezi písmenem "v" a slovem "Liberci".
Vlnovka se ve výstupu nezobrazí -- místo ní bude mezera.

== Jak napsat speciální znak

Znaky jako `_`, `*`, `~`, ... jsou speciální (jak už nyní víte).
Ale co když je chcete napsat... jako opravdu napsat (do své práce).

Stačí před jakýkoliv znak napsat zpětné lomítko (AltGr / Pravý Alt + Q na české klávesnici) a stane se z něj znak normální.

```typst
Takhle tedy můžete například zapsat znak podtržítka: \_
```

Takhle tedy můžete například zapsat znak podtržítka: \_

Chcete napsat samotné zpětné lomítko?
Uhádnete jak se to dělá? ... Dáte před něj zpětné lomítko.

```typst
Nějak takhle: \\
```

Nějak takhle: \\

== Odkazy<links>

Odkazy je možné dělat na URL/URI zdroje, emaily, telefony, atd...
Odkázat na URL (URI) je možné bez zavolání funkce, odkaz stačí prostě a jednodušše napsat:
https://git.zumepro.cz/tul/tultemplate2

```typst
https://git.zumepro.cz/tul/tultemplate2
```

Tohle interně volá funkci `link`.

Pokud odkazujeme na méně časté věci (jako emaily), můžeme použít funkci `link` přímo:
```typst
#link("mailto:ondrej@mekina.cz")[Email maintainera této šablony]
```

Funkci link nejprve v kulatých závorkách dáte cíl odkazu (například URL adresu) a dále v hranatých závorkách obsah, který se zobrazí v dokumentu.

Dalši předpony (URI schémata) můžete najít třeba na Wikipedii
https://en.wikipedia.org/wiki/List_of_URI_schemes.

== Citace

Šablona podporuje správu citací pomocí standardního BibLaTeX @bibtex souboru, stejně jako například LaTeX.
Generování citací v BibLaTeX zápisu umí téměř každá stránka nebo program, které mají pro citace podporu -- doporučujeme použít buď #link("https://www.zotero.org/")[Zotero] nebo #link("https://www.citacepro.com/")[Citace.com].
Kód takovéto citace ve vhodném formátu stačí přidat do souboru _citations.bib_, poté je možné se na ně odkazovat pomocí `@jmeno_citace`, nebo `#cite(<jmeno_citace>)`.
Můžu se tak třeba odkázat na citaci Typstu #cite(<typst>).

Formát souboru _citations.bib_ je naprosto stejný jako pro LaTeX.
Tyto citace lze přímo vložit třeba z webu https://www.citace.com ve formátu BibLaTeX -- Typst tento formát také umí přečíst.
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

Trochu navážeme na *Odkazy* (@links).

Můžete dělat i vnitřní odkazy třeba na kapitoly, stránky nebo obrázky s popiskem (zabalené ve `figure`).

```typst
= Dobrá kapitola<dobra_kapitola>

Podívejme se na Dobrou kapitolu (@dobra_kapitola).
```

Takhle vypadá kotva:

```typst
<nazev_kotvy>
```

Kotvu dáte na zalistovaný obsah (například za nadpis nebo obrázek) a můžete na ní odkazovat stejně jako na citace:

```typst
@nazev_kotvy
```
Můžeme se podívat na názornou ukázku odkazu (@ukazka_odkazu).

== Zkratky

LaTeX TUL šablona má na začátku dokumentu seznam zkratek -- proto jsme ho přidali i do této šablony.
Seznam zkratek je v této šabloně nastaven tak, aby se zobrazoval pouze pokud je v něm alespoň jedna zkratka (přišlo nám to poměrně logické).

Zkratku #abbr("ABC", "Abeceda") vytvoříte (definujete) v textu například takto:

```typst
Zkratka #abbr("ABC", "Abeceda") je zkratka pro abecedu písmen.
```

Potom zkratku #abbr("ABC") už použijete přímo (bez opakované definice):

```typst
První písmeno #abbr("ABC") je písmeno "A".
```

Šablona zajistí následující věci:
- Zkratka se zobrazí v seznamu zkratek
- Při prvním použití zkratky vás šablona donutí zkratku definovat
- Zkratka bude definována pouze jednou (poprvé), jinak na vás šablona začne červeně křičet

Při prvním použití zkratky (při definici) bude zkratka v textu vypadat takto: #abbr("ZK", "Zkratka")

Při dalších použití bude vypadat takto: #abbr("ZK")

#highlight[
  Tedy zkratku _nepřidáváte_ přímo do seznamu zkratek, ale elegantně jí používáte přímo v textu.
]

= Používání funkcí

Používání většiny funkcionalit Typstu je prováděno pomocí tzv. volání funkce. Je to velmi podobné předchozím ukázkám, akorát místo toho, aby se text obalil pouze jedním symbolem či podobnou jednoduchou značkou, obalíme text jménem dané funkce.
Syntaxe vypadá nějak takto:
```typst
#název_funkce[samotný text nebo jiné parametry]
```
Pokud v editoru napíšete symbol hashtagu, začne vám automaticky našeptávat všechny možné funkce a jejich popisy.
Přejdeme rovnou k dalším praktickým příkladům.

== Obrázky

Obrázky je možné vkládat samotné, nebo i s popiskem.
Obrázek se vloží pomocí funkce `image`.

Přidání popisku a zároveň zalistování obrázku v indexu (aby se na ně třeba dalo odkazovat) lze udělat pomocí funkce `figure`.

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

První parametr funkce je zobrazovaný obsah, v našem případě zmíněný `image`.
K němu můžeme psát různé parametry, v příkladu výše (kde zobrazujeme logomark TUL) máme třeba nastavení šířky obrázku v procentech -- tedy v procentech šířky stránky.
Jako poslední je parametr `caption`, s jehož pomocí můžeme nastavit popisek obrázku/figury.

Obrázky se zobrazí na začátku dokumentu v seznamu (pokud to daný typ dokumentu vyžaduje).
I toto za vás Typst dělá automaticky, vám tak stačí do textu přidávat obrázky, jak se to hodí, a všechny se poté korektně zobrazí v *Seznamu obrázků* s odkazem i správně uvedenou stránkou, na které se obrázek nachází.
Obrázky jsou také automaticky číslovány podle předepsaného způsobu, podobně jako kapitoly.

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

Parametr `columns` udává počet sloupců tabulky.
Poté následuje libovolný počet buněk tabulky, pro lepší přehlednost jsou v příkladu jednotlivé řádky oddělené.
Nakonec je zde opět parametr `caption` sloužící k zadání popisku tabulky.

#highlight[Hlavičku tabulky (první řádek) je dobré zabalit do funkce header (viz. výše)], to je kvůli tomu, že Typst do vygenerovaného PDF souboru poté přidá metadata (například pro osoby se zrakovým postižením).

#figure(table(
  columns: 3,
  table.header([], [*Sloupec 1*], [*Sloupec 2*]),
  [*Řádek 1*], [a], [b],
  [*Řádek 2*], [c], [d],
), caption: "Moje krásná tabulka")

Tabulky se zobrazí na začátku dokumentu v seznamu (pokud to daný typ dokumentu vyžaduje).
Jak už jste asi pochopili, i toto provede šablona automaticky.

= Přílohy

Na konec souboru je také možné přidat seznam příloh.
Momentálně jsou podporované čtyři typy příloh: odkaz, obsah, PDF soubor vložený na konec dokumentu a odkaz na externí soubor (například přiložený do systému s {{tou}}).
Jako demonstrace by měla postačit praktická ukázka, která ve zdrojovém kódu následuje hned za tímto odstavcem, a která generuje přílohy tohoto dokumentu.

#attachments(
  attach_link("Zdrojový kód této šablony", "https://git.zumepro.cz/tul/tultemplate2"),
  attach_content("Testovací obsah vygenerovaný Typstem", [Sem lze psát _stylovaný_ obsah.]),
)
