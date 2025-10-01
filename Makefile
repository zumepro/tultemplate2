.PHONY: view_example
view_example: example.pdf
	xdg-open $<

.PHONY: watch_example
watch_example:
	typst watch --font-path template/fonts example.typ & xdg-open example.pdf

.PHONY: example
example: example.pdf

TO_PACK := $(shell find template -type f) template/LICENSE
PACK_TARGETS := $(TO_PACK:%=pack/tultemplate2/%) pack/tultemplate2/example.typ

.PHONY: pack
pack: pack/tultemplate2.zip

.PHONY: clean
clean:
	rm -rf pack
	rm -f example.pdf

pack/tultemplate2.zip: $(PACK_TARGETS)
	@mkdir -p $(@D)
	rm -f $@
	cd pack && zip -r tultemplate2.zip tultemplate2

pack/tultemplate2/example.typ: example.typ
	ln -f $< $@

pack/tultemplate2/template/LICENSE: LICENSE
	@mkdir -p $(@D)
	ln -f $< $@

pack/tultemplate2/template/%: template/%
	@mkdir -p $(@D)
	ln -f $< $@

TEMPLATE_SRCS := $(shell find template -type f)

%.pdf: %.typ $(TEMPLATE_SRCS)
	typst compile --font-path template/fonts $<

include tests/make.mk
