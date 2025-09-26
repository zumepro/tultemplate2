.PHONY: test_%
test_%: tests/%.pdf
	xdg-open $<

tests/%.pdf: tests/%.typ
	typst compile --root . --font-path template/fonts $<
