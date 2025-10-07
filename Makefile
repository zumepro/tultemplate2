.PHONY: view_example
view_example: documentation.pdf
	xdg-open $<

.PHONY: watch_documentation
watch_documentation:
	typst watch --font-path template/fonts documentation.typ & xdg-open documentation.pdf

.PHONY: documentation
documentation: documentation.pdf

TO_PACK := $(shell find template -type f) template/LICENSE
BUNDLE_TARGETS := $(TO_PACK:%=pack/tultemplate2/%) pack/tultemplate2/citations.bib
PACK_TARGETS := $(BUNDLE_TARGETS) pack/tultemplate2/documentation.typ \
				pack/tultemplate2/documentation.pdf

.PHONY: pack
pack: pack/tultemplate2.zip

.PHONY: bundle
bundle: $(BUNDLE_TARGETS)

.PHONY: clean
clean:
	rm -rf pack
	rm -f documentation.pdf

pack/tultemplate2.zip: $(PACK_TARGETS)
	@mkdir -p $(@D)
	rm -f $@
	cd pack && zip -r tultemplate2.zip tultemplate2

pack/tultemplate2/%: %
	ln -f $< $@

pack/tultemplate2/template/LICENSE: LICENSE
	@mkdir -p $(@D)
	ln -f $< $@

pack/tultemplate2/template/tul_citace.csl: template/tul_citace.csl
	@mkdir -p $(@D)
	cat $< | sed 's/^\s*\(.*\)$$/\1/' | tr -d '\n' > $@

pack/tultemplate2/template/lang.json: template/lang.json
	@mkdir -p $(@D)
	cat $< | jq -c > $@

pack/tultemplate2/template/%: template/%
	@mkdir -p $(@D)
	ln -f $< $@

TEMPLATE_SRCS := $(shell find template -type f)

documentation.pdf: documentation.typ $(TEMPLATE_SRCS)
	typst compile --font-path template/fonts $<

include tests/make.mk
