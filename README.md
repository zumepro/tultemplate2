# tultemplate2

Beautiful documents fast and easy...

## Recommended usage

It is recommended to use either:
- The on-line Typst editor (https://typst.app/play/) - Use the generator at https://typst.tul.cz/generate/.
- The `typst` CLI tool (available in Arch repos and Snap) - see [this chapter](#how-to-build-in-cli).

## Contributing

The development is done on our own Gitea instance (over at https://git.zumepro.cz/tul/tultemplate2).
We have a GitHub mirror (https://github.com/zumepro/tultemplate2), but don't actively
monitor it.
We're sorry for developing on a private server, Gitea just gives us so many useful features.
But you can give us a star on GitHub if you like this project :)

If you wish to help with the development (or just want to ask us something), feel free to reach out
to the maintainer:

Ondřej Mekina <ondrej.mekina@tul.cz>

## The goals of this template

We want a simple way for users to make TUL documents, so you can focus on what matters the most,
your content, and leave the boring stuff to us.

We want to check as much as we can on behalf of the user and not even give them the opportunity to
break formal rules. And if they really want to break formal rules - they'll have to dig a bit.

We regularly consult teachers, executives, typographers and previous TUL template developers.
But even now we feel like we're far from perfect. So if you think you could help us or give us any
advice to make this project thrive, please **reach out**.

Our project aims to be a modern and more robust alternative to existing TUL templates.
By rewriting in Typst, we can programmatically check correct behavior and provide extended
functionality.

Oh and also... it's hella fast. Thanks to Typst's incremental compilation and our function
separation, the template compiles in milliseconds (or tens of milliseconds on slower CPUs).

## How to build in CLI

> [!CAUTION]
> It is highly discouraged to clone this repo directly. This repo contains a whole build system and
> can only emit the resulting minimal template for you.

### Dependencies

- Standard `bash` for Makefile commands (`rm`, `xdg-open`, `touch`)
- `wget` to download the minimal pack
- `GNU Make` for Makefiles
- Typst command (`typst` on Snap / `typst` package on Arch-based repos - AUR not required)
- `unzip` to unpack the minimal template

### Building your own thesis

> [!TIP]
> For new users we **strongly** recommend to use the template package generator available at
> https://typst.tul.cz/generate/

If you know what you're doing and don't want to use the generator, we recommend the following:

1. Install the dependencies.
2. Pull (or copy) `minimal.mk` from this repo.
3. Create `thesis.typ` in the same directory as the `Makefile`.
4. Run `make` to view your thesis and watch for changes (so you can edit and live-preview the thesis).
