#import "../template/template.typ": *

#show: tultemplate2.with(
  style: "classic",
  faculty: "fm",
  lang: "en",
  document: "presentation",
  author: [Ondřej Mekina],
  title: (
    en: [Ukázka prezentace v šabloně tultemplate2],
  ),
  presentation: (
    append_thanks: true,
    wide: false,
    first_heading_is_fullpage: true,
  ),
  citations: "citations.bib",
)

= Intro

== How to use this presentation

- this template serves as a demo usage of the Typst TUL template for creating presentations
- you can use all the functionalities of Typst, the same you would in all the other documents
- slides are created in a similiar fashion to LaTeX - each level 1 heading detones a new slide
  - this behaves differently when using the _first_heading_is_fullpage_ option - more on that later
- you can also use level 2 headings

= Template options

== Template function arguments

- _append_thanks_: Whether to end the presentation with a Thank you slide
- _wide_: Using the 16:9 aspect ratio for all slides instead of 4:3
- _first_heading_is_fullpage_: creates a standalone page for each level 1 heading, this breaks down the presentation nicely
  - also creates a new slide for each level 2 heading
  - if the option is not set, level 2 headings *do not* create a new slide

== Structure

- The presentations begins with a title page - configured in the generator
- there is no automatically generated table of contents - the user may create it easily using dashes or an ordered list
- after the content of the presentation, there is a slide with all citation sources - this one is automatically generated
- optionally a Thank you slide

== Usage of citations

- here are two example citations: Citation 1 @typst and citation 2 @bibtex
