#import "../template/template.typ": *

#show: tultemplate2

= Introduction to this template

This template should serve as an example {{what}} written with the help of the tool *Typst* and the *tultemplate2* template.
It can be used as a starting point for your own report, you just have to learn a few of its useful functions, e.g. how to insert images, tables, citacions or links.

In contrast with the _documentation.typ_ file, which is available for download on the project's page, this document only contains the most necessary knowledge to complete most reports.
If you find this document lacking in features, you can look at the aforementioned docs or contact one of the authors, who will try to help you.
Just for the sake of completeness, here is a few words about the Typst programming language and about Typst, as well as about the motivation behind the creation of this template:

Typst is a professional typesetting language similar to Markdown, LaTeX/TeX, groff, etc.

Typst is the modern equivalent of older typesetting tools, which often lack a lot of important features, such that make it next to impossible to work without today.
The user must often import an incountable number of packages, which only provide only the most basic of functionalities --- for example proper UTF-8 character support, formatting of elements based on the set locale, etc.

== Getting started

You have probably downloaded this template from the generator on the website https://tulsablona.zumepro.cz and inserted it into the Typst online editor.
Therefore, besides the source code, you can also see the resulting PDF file.
As you probably know, the main difference between traditional word processors like Microsoft Word or LibreOffice Writer and typesetting programs like LaTeX or Typst is the way in which the appearance and content of the document are edited.

While Word users are used to changing the document directly using buttons and keyboard shortcuts, Typst (and also LaTeX) use a so-called source file, which is nothing more than an ordinary text file, and can then, on request, compile this source file -- i.e., turn it into the final document, for example in PDF format.

That's why in this document you'll find a description of all the important functions not as a gallery of images showing which buttons to click, but rather as an example and guide to all the special text sequences that Typst supports and that the template interprets differently from the main content of the report.

#rect[
  *TIP*:
  Save this document for later use.
  When you'll search for a specific function, you can jump right to it through the table of contents above.
]

== Clickable content

When using the official Typst online editor, you can simply click on any text in the right side (the preview PDF), and your cursor will jump directly to that text in the source file.
A small but very practical feature.

#rect[
  *TIP*:
  Try double-tapping the content of the abstract (or the thesis title for projects and term papers) and then start typing.
]

== Template compile-time checks

This template is created in such a way that when you try to compile it with incorrect syntax or an imoportant part of the header missing, it won't let you.
Always see the error messages the template provides, as they will simply guide you to fix your mistakes.
You can try this by deleting something from the header, or by using e.g. a function that ins't defined anywhere.

If you generated the header from the generator -- you should have no problem with it.
The generator is configured to only generate valid headers.

= Basic content formatting

Formatting (typesetting) text in Typst is very easy in the majority of cases.
In this chapter we'll show you some basics that you'll use all the time.

== Paragraphs

Some of you might know this concept from using Markdown, where paragraphs, headings and for the sake of clarity all logically coherent blocks are separated by an empty line.
You might have already spotted this while reading through this document.
You can try for yourself what happens when
you just end the line

or when you properly use an empty line,




or maybe what happens if you use two or more empty rows. (spoiler: 1 or more empty lines share identical behavior,
while newlining only is interpreted the same as using spaces or tabs)

Therefore, the user has freedom of choosing whether they use long lines full of text,
or
if
they
prefer
a
cleaner
formatting
and manage the separation of content to lines, because it all gets concatenated into a nice consice paragraph.
The user has to manually watch out for the length of the paragraphs, so that they are neither too short or too long.

In the context of paragraphs, it should be mentioned that Typst also manages the alignment of text and words into blocks and the division of words between lines when they don't fit.

== Headings

The first important feature, apart from writing the text itself (which requires no black magic), is the usage of headings.
Just like in other programs, Typst also supports multi-level headings. For a first-level heading, an equals sign followed by a space is used at the beginning of a line, meaning that in a Typst source file it is written like this:

```typst
= My first level heading
```

For a second-level heading, we then use two equals signs; for a third-level heading, three equals signs...
However, the *tultemplate2* template will not allow a heading of fourth or deeper level, because such a heading would violate TUL's guidelines for writing reports.
But don't worry --- if you try to use fourth-level or deeper heading, the template will warn you not to do that and will refuse to compile until you fix this. More on this behavior later.

```typst
= Heading
== Subheading
=== Subsubheading

And then your content
```

== Chapter Numbering

You've probably noticed that each heading begins with the number of its respective chapter in the output. Typst handles this numbering automatically, and it's also reflected in the *Contents* section at the start of the document, so you don't have to worry about it yourself.

#rect[
  *TIP*:
  As a test, try to write a heading with level four.
  At least you'll familiarize yourself with the way that this template gives you errors through Typst.
  If you'll find yourself in a different file after double-tapping the error --- just simply return to this file through the file menu.
]

== Text Highlighting

The syntax for basic highlighting is very similar to Markdown. You just need to use the following symbols:

```typst
*bold*
_italic_
#highlight[highlighted]
```

More styling options can be applied through functions, for example:

```typst
#strike[struck through]
```

For completeness and demonstration, here in the text we have *bold text*, _italic text_, #strike[struck-through text],
and #highlight[text highlighted with your faculty's color].
It's also possible to typeset #underline[underlined text] (although typographers generally advise against using underlining).

== Links<links>

You can create links to URLs/URIs, emails, phone numbers, and more.
A URL (URI) link can be written directly, without calling any function --- just type it in:
https://git.zumepro.cz/tul/tultemplate2

```typst
https://git.zumepro.cz/tul/tultemplate2
```

Internally, this automatically calls the `link` function.

If we want to link to less common things (like email addresses), we can call the `link` function explicitly:
```typst
#link("mailto:ondrej@mekina.cz")[Email of this template's maintainer]
```
First, you pass the link target (perhaps a URL address) in parentheses to the link function and then you follow up with the content that will be displayed in the document enclosed in brackets.

You can find other prefixes (URI schemes) on Wikipedia:
https://en.wikipedia.org/wiki/List_of_URI_schemes.

== Citations

The template supports citation management using a standard BibLaTeX file @bibtex, just like LaTeX.
Almost every website or program that supports citations can generate BibLaTeX-formatted entries --- we recommend using either #link("https://www.zotero.org/")[Zotero] or #link("https://www.citacepro.com/")[Citace.com].
You simply add the code for such a citation, in the proper format, to the file _citations.bib_.
Once added, you can reference it using `@citation_name` or `#cite(<citation_name>)`.
For example, I can reference the Typst citation as #cite(<typst>).

The format of the _citations.bib_ file is exactly the same as in LaTeX.
You can even copy entries directly from sites like  in BibLaTeX format --- Typst understands that format, too.
If you open a `.bib` file, you'll see that it's simply a plain text file with a specific structure.
The provided sample file already contains several citations --- for instance, the one named `typst`, which was already used above.

You can change the file from which citations are loaded using a template argument (i.e., in the structure at the beginning of your Typst document):

```typst
#show: tultemplate2.with(
  ...
  citations: "anotherfile.bib",
  ...
)
```

== Internal Links and Anchors<example_anchor>

Let's continue from the *Links* section (@links).

You can also create internal links --- for instance, to chapters, pages, or labeled images (those wrapped with the `figure` function).

```typst
= A Good Chapter<good_chapter>

Let's take a look at A Good Chapter (@good_chapter).
```

Here's what an anchor looks like:

```typst
<anchor_name>
```

You place the anchor on a listed item (after a heading or an image for example), and you can reference it the same way you reference citations:

```typst
@anchor_name
```

We can take a look at this illustrative reference (@example_anchor).

== Abbreviations

The LaTeX TUL template includes a list of abbreviations at the beginning of the document --- therefore, we've included one here as well.
This list is configured to appear only if there is *at least one* abbreviation defined --- which seemed quite logical.

You can create (define) the abbreviation #abbr("ABC", "Alphabet") in a text like this:

```typst
The shortcut #abbr("ABC", "Alphabet") is a shortcut for the alphabet of letters.
```

After that, you'll you the abbreviation #abbr("ABC") directly without redefining it:

```typst
The first letter of #abbr("ABC") is the letter "A".
```

The template automatically ensures the following:
- The abbreviation appears in the list of abbreviations
- When you use an abbreviation for the first time, the template requires you to define it
- The abbreviation is only defined once (the first time) or the template will scream in red at you

When used for the first time (definition), the abbreviation will look like this: #abbr("ABR", "Abbreviation")

In subsequent uses, it will appear as: #abbr("ABR")

#highlight[
  In other words, you do _not_ add abbreviations directly to the abbreviation list.
  You simply use them elegantly within the text itself.
]

= Using Functions

Most Typst features are used through what's called function calls.
This is quite similar to the previous examples, except that instead of wrapping text with a single symbol or a simple marker, we wrap it with the name of the function.
The syntax looks like this:

```typst
#function_name[text itself or other parameters]
```

When you type the hashtag symbol in the editor, it will automatically start suggesting all available functions and their descriptions.
Let's move on to some practical examples.

== Images

Images can be inserted either by themselves or with a caption.

An image is inserted using the `image` function:

To add a caption and also include the image in the index (so you can reference it later), use the `figure` function:

#block([
  ```typst
  #figure(
    image("myimage.jpg"),
    caption: [
      *A beautiful* picture that looks like a picture.
    ]
  )
  ```
], breakable: false)

Here's a practical example of inserting an image with a caption:

#figure(image("../template/assets/tul_logo.svg", width: 25%), caption: [
  Logo of *TUL*
])

The first parameter of the function is the displayed content --- in our case, the mentioned `image`.
You can then specify various parameters for it; in the example above (where we display the TUL logomark), we define the image width as a percentage --- a percentage of the page's width.
The last parameter is `caption`, which lets us set the figure's (or image's) caption text.

If the document type requires it, images will automatically appear in a list at the beginning of the document.
Typst handles this automatically for you --- all you need to do is add images wherever appropriate, and they'll show up correctly in the *List of images*, complete with references and page numbers.
Images are also numbered automatically according to the predefined style, similar to chapters.

== Tables

Tables can be created like this:

```typst
#figure(table(
  columns: 3,
  table.header([], [*Column 1*], [*Column 2*]),
  [*Row 1*], [a], [b],
  [*Row 2*], [c], [d],
), caption: "My beautiful table")
```

The `columns` parameter specifies the number of columns in the table.
Then comes any number of table cells --- for clarity, the rows are separated in the example.
Finally, there's again a `caption` parameter, used to provide a caption for the table.

#highlight[It's a good idea to wrap the table header (the first row) in the `header` function (as shown above)] --- this ensures Typst includes extra metadata in the generated PDF (for example, for people with visual impairments).

#figure(table(
  columns: 3,
  table.header([], [*Column 1*], [*Column 2*]),
  [*Row 1*], [a], [b],
  [*Row 2*], [c], [d],
), caption: "My beautiful table")

Tables also appear at the beginning of the document in a list (if required by the document type).
As you've probably noticed by now, this template takes care of this automatically too.

= Attachments

At the end of the file, you can add the list of attachments.
Currently, we support four types of attachments: links, content, PDF file attached at the end of the document and a reference to an external file (perhaps attached to the system with your {{what}}).
As a demonstration, there's a practical example included right after this paragraph in the source code, which generates the attachments for this document.

#attachments(
  attach_link("Source code of this template", "https://git.zumepro.cz/tul/tultemplate2"),
  attach_content("Test content generated by Typst", [Here you can write _styled_ content.]),
)

