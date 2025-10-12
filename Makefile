.PHONY: view_documentation
view_documentation: documentation.pdf
	xdg-open $<

.PHONY: watch_documentation
watch_documentation:
	typst watch --font-path template/fonts documentation.typ & xdg-open documentation.pdf

.PHONY: watch_bp_cs
watch_bp_cs: bp.pdf
	xdg-open bp.pdf & typst watch --root . --font-path template/fonts theses/bp.typ bp.pdf

.PHONY: watch_dp_cs
watch_dp_cs: dp.pdf
	xdg-open dp.pdf & typst watch --root . --font-path template/fonts theses/dp.typ dp.pdf

.PHONY: documentation
documentation: documentation.pdf

PACKDIR := pack/tultemplate2
BUNDLEDIR := pack/bundle

TO_PACK := $(shell find template -type f) template/LICENSE
BUNDLE_TARGETS := $(TO_PACK:%=$(BUNDLEDIR)/%) $(BUNDLEDIR)/citations.bib $(BUNDLEDIR)/bp_cs.typ \
				  $(BUNDLEDIR)/bp_en.typ $(BUNDLEDIR)/dp_cs.typ $(BUNDLEDIR)/Makefile
PACK_TARGETS := $(TO_PACK:%=$(PACKDIR)/%) $(PACKDIR)/documentation.typ \
				$(PACKDIR)/documentation.pdf $(PACKDIR)/citations.bib

.PHONY: pack
pack: pack/tultemplate2.zip

.PHONY: bundle
bundle: $(BUNDLE_TARGETS)
	@echo "!! Bundles are made for tultemplategen and not for direct use !!"

.PHONY: clean
clean:
	rm -rf pack
	rm -f documentation.pdf bp.pdf dp.pdf

pack/tultemplate2.zip: $(PACK_TARGETS)
	@mkdir -p $(@D)
	rm -f $@
	cd pack && zip -r tultemplate2.zip tultemplate2

$(PACKDIR)/%: %
	@mkdir -p $(@D)
	ln -f $< $@

$(BUNDLEDIR)/citations.bib: citations.bib
	@mkdir -p $(@D)
	ln -f $< $@

$(BUNDLEDIR)/%.typ: theses/%.typ
	@mkdir -p $(@D)
	awk 'BEGIN{RS=""; ORS="\n\n"} NR>2{print}' $< | sed 's/\.\.\/template\//template\//' > $@

$(BUNDLEDIR)/Makefile: templategen.mk
	@mkdir -p $(@D)
	ln -f $< $@

$(PACKDIR)/template/LICENSE: LICENSE
	@mkdir -p $(@D)
	ln -f $< $@

$(BUNDLEDIR)/template/LICENSE: LICENSE
	@mkdir -p $(@D)
	ln -f $< $@

$(PACKDIR)/template/tul_citace.csl: template/tul_citace.csl
	@mkdir -p $(@D)
	cat $< | sed 's/^\s*\(.*\)$$/\1/' | tr -d '\n' > $@

$(BUNDLEDIR)/template/tul_citace.csl: template/tul_citace.csl
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

TEMPLATE_SRCS := $(shell find template -type f) citations.yml

bp.pdf: theses/bp.typ
	typst compile --font-path template/fonts --root . $< $@

dp.pdf: theses/dp.typ
	typst compile --font-path template/fonts --root . $< $@

documentation.pdf: documentation.typ $(TEMPLATE_SRCS)
	typst compile --font-path template/fonts $<

include tests/make.mk
