BUILD_DIR := target
PACKS_ROOT := $(BUILD_DIR)/pack
PACKDIR := $(PACKS_ROOT)/tultemplate2
BUNDLEDIR := $(PACKS_ROOT)/bundle

TO_PACK := $(shell find template -type f) template/LICENSE
BUNDLE_THESES := bp_cs bp_en dp_cs dp_en prj_cs prj_en
BUNDLE_TARGETS := $(TO_PACK:%=$(BUNDLEDIR)/%) $(BUNDLEDIR)/citations.bib $(BUNDLEDIR)/bp_cs.typ \
				  $(BUNDLE_THESES:%=$(BUNDLEDIR)/%.typ) $(BUNDLEDIR)/Makefile
PACK_TARGETS := $(TO_PACK:%=$(PACKDIR)/%) $(PACKDIR)/documentation.typ \
				$(PACKDIR)/documentation.pdf $(PACKDIR)/citations.bib $(PACKDIR)/Makefile

TEMPLATE_SRCS := $(shell find template -type f)

# == MAIN TARGETS ==

.PHONY: view_documentation
view_documentation: $(BUILD_DIR)/documentation.pdf
	xdg-open $<

.PHONY: pack
pack: $(PACKDIR)/tultemplate2.zip

.PHONY: bundle
bundle: $(BUNDLE_TARGETS)
	@echo "!! Bundles are made for tultemplategen and not for direct use !!"

.PHONY: watch_documentation
watch_documentation: $(BUILD_DIR)/documentation.pdf
	xdg-open $< & typst watch --font-path template/fonts documentation.typ $<

.PHONY: thesis_%
thesis_%: $(BUILD_DIR)/%.pdf
	xdg-open $<

.PHONY: documentation
documentation: $(BUILD_DIR)/documentation.pdf

.PHONY: clean
clean:
	rm -rf target

# == ROOTS ==

$(BUILD_DIR):
	mkdir $@

$(PACKS_ROOT): | $(BUILD_DIR)
	mkdir $@

$(PACKDIR): | $(PACKS_ROOT)
	mkdir $@

$(BUNDLEDIR): | $(PACKS_ROOT)
	mkdir $@

# == UTILS ==

define minify_csl
	cat $(1) | sed 's/^\s*\(.*\)$$/\1/' | tr -d '\n' > $(2)
endef

define minify_json
	cat $(1) | jq -c > $(2)
endef

define replace_with_file_line
	sed "s/$(1)/$$(sed '$(3)q;d' $(2))/g"
endef

# == DOCUMENTATION ==

$(BUILD_DIR)/documentation.pdf: documentation.typ $(TEMPLATE_SRCS) | $(BUILD_DIR)
	typst compile --font-path template/fonts $< $@

# == THESES EXAMPLES ==

$(BUILD_DIR)/subs_%.txt: theses/%.typ | $(BUILD_DIR)
	awk 'BEGIN{RS=""; ORS="\n\n"} NR>2{print}' $< > $@

$(BUILD_DIR)/header_%.txt: theses/%.typ
	awk 'BEGIN{RS=""; ORS="\n\n"} NR<3{print}' $< > $@

$(BUILD_DIR)/content_%_cs.txt: $(BUILD_DIR)/subs_%_cs.txt theses/content_cs.typ
	cat theses/content_cs.typ | \
		$(call replace_with_file_line,{{ta}},$<,1) | $(call replace_with_file_line,{{tou}},$<,2) | \
		awk 'BEGIN{RS=""; ORS="\n\n"} NR>2{print}' > $@

$(BUILD_DIR)/content_%_en.txt: $(BUILD_DIR)/subs_%_en.txt theses/content_en.typ
	cat theses/content_en.typ | \
		$(call replace_with_file_line,{{what}},$<,1) | \
		awk 'BEGIN{RS=""; ORS="\n\n"} NR>2{print}' > $@

$(BUILD_DIR)/%.typ: $(BUILD_DIR)/header_%.txt $(BUILD_DIR)/content_%.txt | $(BUILD_DIR)
	cat $^ > $@

$(BUILD_DIR)/%.pdf: $(BUILD_DIR)/%.typ $(TEMPLATE_SRCS) | $(BUILD_DIR)
	typst compile --font-path template/fonts --root . $< $@

# == PACKS - clean builds for direct use ==

$(PACKDIR)/%: % | $(PACKDIR)
	ln -f $< $@

$(PACKDIR)/template: | $(PACKDIR)
	mkdir $@

$(PACKDIR)/template/LICENSE: LICENSE | $(PACKDIR)/template
	ln -f $< $@

$(PACKDIR)/Makefile: packed.mk | $(PACKDIR)
	ln -f $< $@

$(PACKDIR)/template/tul_citace.csl: template/tul_citace.csl | $(PACKDIR)/template
	$(call minify_csl,$<,$@)

$(PACKDIR)/template/lang.json: template/lang.json | $(PACKDIR)/template
	$(call minify_json,$<,$@)

$(PACKDIR)/template/%: template/% | $(PACKDIR)/template
	@mkdir -p $(@D)
	ln -f $< $@

$(PACKDIR)/%.pdf: $(BUILD_DIR)/%.pdf | $(PACKDIR)
	ln -f $< $@

$(PACKDIR)/tultemplate2.zip: $(PACK_TARGETS) | $(PACKDIR)
	rm -f $@
	cd $(PACKS_ROOT) && zip -r tultemplate2.zip tultemplate2

# == BUNDLES - packs for tultemplategen ==

$(BUNDLEDIR)/template: | $(BUNDLEDIR)
	mkdir $@

$(BUNDLEDIR)/template/LICENSE: LICENSE | $(BUNDLEDIR)/template
	ln -f $< $@

$(BUNDLEDIR)/Makefile: templategen.mk | $(BUNDLEDIR)
	ln -f $< $@

$(BUNDLEDIR)/template/tul_citace.csl: template/tul_citace.csl | $(BUNDLEDIR)/template
	$(call minify_csl,$<,$@)

$(BUNDLEDIR)/template/lang.json: template/lang.json | $(BUNDLEDIR)/template
	$(call minify_json,$<,$@)

$(BUNDLEDIR)/citations.bib: citations.bib | $(BUNDLEDIR)
	ln -f $< $@

$(BUNDLEDIR)/template/%: template/% | $(BUNDLEDIR)/template
	@mkdir -p $(@D)
	ln -f $< $@

$(BUNDLEDIR)/%.typ: $(BUILD_DIR)/content_%.txt | $(BUNDLEDIR)
	sed 's/\.\.\/template\//template\//' $< > $@

# == TESTS ==

include tests/make.mk
