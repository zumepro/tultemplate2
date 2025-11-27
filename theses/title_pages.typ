#let color = red
#set text(font: "Inter")
#set page(foreground: rect(
  width: 90%,
  height: 90%,
  stroke: (paint: color, thickness: .03em, dash: (.5em, .5em))
))

#set text(lang: "cs")
#align(center + horizon, text([
  *Nahraďte soubor "`title-pages.pdf`"* souborem se zadáním vygenerovaným *ze~STAGu*.
], color, 2em))

#text([
  To můžete v online Typst editoru udělat takto:
  + *Počkejte až budete mít oficiálně schválené zadání práce.*
  + Soubor s titulními stranami se vám pak ukáže ve STAGu -- stáhněte soubor ze STAGu.
  + Přejmenujte ho na "`title-pages.pdf`".
  + Otevřete v online Typst editoru prohlížeč souborů.
  + Přetáhněte svůj přejmenovaný soubor do prohlížeče souborů.
  + Pokud jste vše udělali správně, vyskočí vám okno, které se vás ptá, jestli chcete soubor přepsat -- klikněte na přepsat (v angličtině overwrite).

  Oficiálně *není doporučeno soubor vytvářet manuálně*, ale opravdu ho stáhnout ho ze STAGu.
  Soubor ze STAGu navíc obsahuje důležitá metadata.
], black, 11pt)

#pagebreak()

#set text(lang: "en")
#align(center + horizon, text([
  *Replace file "`title-pages.pdf`"* with the title pages document with assignment genenerated *from~STAG*.
], color, 2em))

#text([
  In the online Typst editor you can do it as follows:
  + *Wait until you have your assignment officially approved.*
  + The file with the title pages will then appear in STAG for you --- download the file from STAG.
  + Rename it to "`title-pages.pdf`".
  + Open the file browser in the online Typst editor.
  + Drag and drop your renamed file into the file browser.
  + If you did everything correctly, a window will popup, asking you if you want to overwrite the file --- click on overwrite.

  Officially, it is *not recommended to create the file manually*, but, indeed, download it from STAG.
  The file from STAG also includes some important metadata.
], black, 11pt)
