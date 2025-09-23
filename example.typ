#import "template/template.typ": *

#show: tultemplate.with(
  "classic", "fm", "cs",
  title: "Návod na použití Typst TUL šablony",
  author: "Ondřej Mekina",
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
- E-maily dalších maintainerů: #todo("přidat e-maily")

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
#show: tultemplate.with(<vzhled_sablony>, <fakulta>, <jazyk>)
```
A to je vše. Absolutní minimum pro rozchození šablony. Nebojte se, pokud neznáte názvy
vzhledů šablony, zkratku fakulty, nebo zkratku pro jazyk. Šablona vás navede pomocí chybových
hlášek (nebo se můžete podívat do zdrojového souboru pro toto PDF `example.typ`).

== Titulní stránka

Nyní pojďme přidat nějaký obsah na titulní stránku. Jednoduše do volání šablony přidáme další
parametry.
```typst
#show: tultemplate.with(..., title: "Můj úžasný dokument", author: "Já")
```
Všechny možné parametry by vám měl našeptávat váš editor (nebo LSP) -- poslouchejte takové nápovědy,
opravdu hodně vám to usnadní práci.

= Základy formátování v Typstu

// tohle je podnadpis :)
#heading(
  level: 3,
  range(1, 6).map((v) => range(1, v).map((_) => "pod").join("") + "nadpisy").join(", ") + ", ..."
)

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
A to nám krásně navazuje na další kapitolu.

== Funkce

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
