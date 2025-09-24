.PHONY: view_example
view_example: example.pdf
	xdg-open $<

.PHONY: example
example: example.pdf

TEMPLATE_SRCS := $(shell find template -type f)

%.pdf: %.typ $(TEMPLATE_SRCS)
	typst compile --font-path template/fonts $<
