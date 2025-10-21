# tultemplate2

Easy Typst template for TUL documents. Begin by compiling `example.typ` and reading it.

## Recommended usage

It is recommended to use either:
- The on-line Typst editor (https://typst.app/play/) - use some zip build from releases
  (https://git.zumepro.cz/tul/tultemplate2/releases).
- The `typst` CLI tool (available in Arch repos and Snap)

## Contributing

The development is done on our own Gitea instance
(over at https://git.zumepro.cz/tul/tultemplate2). We have a GitHub mirror, but don't actively
monitor it. We're sorry for this inconvenience, Gitea just gives us so many useful features.

If you wish to help with the development (or just want to ask us something), feel free to reach out
to the maintainer:

Ondřej Mekina <ondrej@mekina.cz>

## Our goals and dreams

We dream of a simple way for students to make documents. Of a workflow revolving not around
citations, fonts, paragraphs and other formal bs, but around the actual content of the document.

We aim to provide a robust (but simple) framework to build official documents at TUL.

We want to check as much as we can on behalf of the user and stop the compilation of the document if
any formal rules could be broken. Our opinion is that the average user should not even have the
opportunity to break formal rules. And if they want to - they will have to dig a bit (or set
additional parameters in the template).

When we started developing this template, we cosmically underestimated the amount of effort we'd
have to put into this project. Since then we consulted teachers, executives, typographers and
previous TUL template developers. But even now we feel like we're far from perfect. So if you
think you could help us or give us any advice to make this project thrive, please **reach out**.

This project was inspired by Pavel Satrapa's TUL LaTeX bundle
(https://www.nti.tul.cz/~satrapa/vyuka/latex-tul/). It aims to be a modern and more robust
alternative.

By rewriting in Typst, we have access to scripting. So we can programmatically pull up some
information, translationa and abort the compilation when necessary.

Oh and also... it's hella fast.

## How to build in CLI

> [!IMPORTANT]
> This repo uses git lfs to pull fonts. Please set it up (or download a packed build from releases).
> When running in CLI - you'll want to include the embedded fonts:
> `typst compile --font-path template/fonts example.typ`

### Dependencies

- Standard `bash` for Makefile commands (`mkdir`, `rm`, `xdg-open`, `echo`, `cd`, `ln`, `awk`, `sed`, `cat`)
- `jq` for processing JSON files (is pretty standard on most GNU/Linux distros)
- `GNU Make` for Makefiles
- Typst command (`typst` on Snap / `typst` package on Arch-based repos - AUR not required)
- `zip` if you want to make packed builds (perhaps for the on-line editor)

### Building your own thesis

> [!TIP]
> We **strongly** recommend to use the template package generator available at
> https://tulsablona.zumepro.cz/

The generator will help you generate the necessary headers (so you don't have to go error-by-error -
sadly, Typst does not yet support emitting multiple errors or warnings at once).

It will also give you some tips (like to upload the assignment PDF from STAG) on how to structure
the thesis. And at the end, it will generate a whole example document for you.

### Building documentation

The documentation PDF explains different concepts in Typst and in this template.
It's source code can be found in `documentation.typ`.

You can build (and view) it by running:

```sh
make
```

This will compile it once and open it using `xdg-open`.

### Building thesis examples

Thesis examples are in `theses`. They also have assignments pulled from an external file.

Using:

```sh
make bp_cs.pdf
```

Will generate an example bachelor's thesis in czech.

We also have:
- `bp_en.pdf` (partially translate - if you wish to help translating, we'll gladly welcome it)
- `dp_cs.pdf`
