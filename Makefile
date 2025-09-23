.PHONY: example
example: example.pdf

%.pdf: %.typ
	typst compile --font-path template/fonts $<
