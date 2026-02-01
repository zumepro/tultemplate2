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

= Argumenty šablony

Následujících pár stránek je kompletní soupis argumentů, které tato šablona přijímá.
Pokud s šablonou nemáte rozsáhlé zkušenosti, doporučujeme raději využít generátoru
(https://typst.tul.cz/generate/).

// Automaticky generovaný seznam argumentů
#import "template/arguments.typ": print_argument_docs
#print_argument_docs(lang: "cs")
