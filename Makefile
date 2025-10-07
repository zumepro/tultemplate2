.PHONY: view_example
view_example: documentation.pdf
	xdg-open $<

.PHONY: watch_documentation
watch_documentation:
	typst watch --font-path template/fonts documentation.typ & xdg-open documentation.pdf

.PHONY: watch_bp_cs
watch_bp_cs:
	typst watch --root . --font-path template/fonts theses/bp_cs/bp.typ bp.pdf & xdg-open bp.pdf

.PHONY: watch_dp_cs
watch_dp_cs:
	typst watch --root . --font-path template/fonts theses/dp_cs/dp.typ dp.pdf & xdg-open dp.pdf

.PHONY: documentation
documentation: documentation.pdf

PACKDIR := pack/tultemplate2
BUNDLEDIR := pack/bundle

TO_PACK := $(shell find template -type f) template/LICENSE
BUNDLE_TARGETS := $(TO_PACK:%=$(BUNDLEDIR)/%) $(BUNDLEDIR)/citations.bib $(BUNDLEDIR)/Makefile
PACK_TARGETS := $(TO_PACK:%=$(PACKDIR)/%) $(PACKDIR)/documentation.typ \
				$(PACKDIR)/documentation.pdf $(PACKDIR)/citations.bib

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

$(PACKDIR)/%: %
	@mkdir -p $(@D)
	ln -f $< $@

$(BUNDLEDIR)/citations.bib:
	@mkdir -p $(@D)
	touch $@

$(BUNDLEDIR)/Makefile: templategen.mk
	@mkdir -p $(@D)
	ln -f $< $@

$(PACKDIR)/template/LICENSE: LICENSE
	@mkdir -p $(@D)
	ln -f $< $@

$(BUNDLEDIR)/template/LICENSE: LICENSE
	@mkdir -p $(@D)
	ln -f $< $@

$(PACKDIR)/template/tul_citace.csl $(BUNDLEDIR)/template/tul_citace.csl: template/tul_citace.csl
	@mkdir -p $(@D)
	cat $< | sed 's/^\s*\(.*\)$$/\1/' | tr -d '\n' > $@

$(PACKDIR)/template/lang.json: template/lang.json
	@mkdir -p $(@D)
	cat $< | jq -c > $@

$(BUNDLEDIR)/template/lang.json: template/lang.json
	@mkdir -p $(@D)
	cat $< | jq -c > $@

$(PACKDIR)/template/%: template/%
	@mkdir -p $(@D)
	ln -f $< $@

$(BUNDLEDIR)/template/%: template/%
	@mkdir -p $(@D)
	ln -f $< $@

TEMPLATE_SRCS := $(shell find template -type f)

documentation.pdf: documentation.typ $(TEMPLATE_SRCS)
	typst compile --font-path template/fonts $<

include tests/make.mk
