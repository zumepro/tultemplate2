#let color = red
#set text(font: "Inter")
#set page(foreground: rect(
  width: 90%,
  height: 90%,
  stroke: (paint: color, thickness: .03em, dash: (.5em, .5em))
))

#set text(lang: "cs")
#align(center + horizon, text([
  *Nahraďte soubor "`assignment.pdf`"* souborem se zadáním.
], color, 2em))

#text([
  To můžete v online Typst editoru udělat takto:
  + Soubor se zadáním stáhněte ze systému. Pokud vaše fakulta nemá žádný systém, požádejte svého vedoucího o PDF soubor se zadáním.
  + Přejmenujte ho na "`assignment.pdf`".
  + Otevřete v online Typst editoru prohlížeč souborů.
  + Přetáhněte svůj přejmenovaný soubor do prohlížeče souborů.
  + Pokud jste vše udělali správně, vyskočí vám okno, které se vás ptá, jestli chcete soubor přepsat -- klikněte na přepsat (v angličtině overwrite).
], black, 11pt)

#pagebreak()

#set text(lang: "en")
#align(center + horizon, text([
  *Replace file "`assignment.pdf`"* with your assignment document.
], color, 2em))

#text([
  In the online Typst editor you can do it as follows:
  + Download the assignment file from the system. If your faculty doesn't have a system, ask your supervisor for a PDF file with the assignment.
  + Rename it to "`assignment.pdf`".
  + Open the file browser in the online Typst editor.
  + Drag and drop your renamed file into the file browser.
  + If you did everything correctly, a window will popup, asking you if you want to overwrite the file --- click on overwrite.
], black, 11pt)
