TYPST_FONTPATH := --font-path template/fonts

.PHONY: watch_%
watch_%: %.pdf
	xdg-open $< & typst watch $(TYPST_FONTPATH) $*.typ

.PHONY: view_%
view_%: %.pdf
	xdg-open $<

.PHONY: %.pdf
%.pdf: %.typ
	typst compile $(TYPST_FONTPATH) $<
