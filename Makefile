.PHONY: example
example: example.pdf

TEMPLATE_SRCS := $(shell find template -type f)

%.pdf: %.typ $(TEMPLATE_SRCS)
	typst compile --font-path template/fonts $<
