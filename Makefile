TYPST_PACKAGES ?=

BUILD_DIR := target
PACKS_ROOT := $(BUILD_DIR)/pack
PACKSTAGING := $(PACKS_ROOT)/staging
PACKDIR := $(PACKS_ROOT)/tultemplate2
BUNDLEDIR := $(PACKS_ROOT)/bundle
MINIMALDIR := $(PACKS_ROOT)/minimal

LIBDIR := template/lib
LIB_MUCHPDFTOOLS := $(LIBDIR)/much_pdf_tools
LIB_TARGETS_MUCHPDFTOOLS := lib.typ much_pdf_tools.wasm
LIB_URL_MUCHPDFTOOLS := https://tulsablona.zumepro.cz/lib/much_pdf_tools

MINIMAL_ASSET_ROOTS := template/assets template/fonts template/citations
MINIMAL_SRCS := $(shell find template -type f -regex '^.*\.typ$$') \
				$(shell find $(MINIMAL_ASSET_ROOTS) -type f) \
				template/lang.json \
				$(LIB_TARGETS_MUCHPDFTOOLS:%=$(LIB_MUCHPDFTOOLS)/%)
TEMPLATE_SRCS := $(MINIMAL_SRCS) template/example_appendix.pdf
ADD_TO_PACK := template/LICENSE
TO_PACK_MINIMAL := $(MINIMAL_SRCS) $(ADD_TO_PACK)
TO_PACK := $(TEMPLATE_SRCS) $(ADD_TO_PACK)
BUNDLE_THESES := bp_cs bp_en dp_cs dp_en prj_cs prj_en sp_cs sp_en presentation_cs presentation_en
BUNDLE_TARGETS := $(TO_PACK:%=$(BUNDLEDIR)/%) $(BUNDLEDIR)/citations.bib $(BUNDLEDIR)/bp_cs.typ \
				  $(BUNDLE_THESES:%=$(BUNDLEDIR)/%.typ) $(BUNDLEDIR)/Makefile \
				  $(BUNDLEDIR)/title-pages.pdf $(BUNDLEDIR)/assignment.pdf
PACK_TARGETS := $(TO_PACK:%=$(PACKDIR)/%) $(PACKDIR)/documentation.typ \
				$(PACKDIR)/documentation.pdf $(PACKDIR)/citations.bib $(PACKDIR)/Makefile
MINIMAL_TARGETS := $(TO_PACK_MINIMAL:%=$(MINIMALDIR)/%)

# == MAIN TARGETS ==

.PRECIOUS: $(BUILD_DIR)/%.pdf

.PHONY: view_documentation
view_documentation: $(BUILD_DIR)/documentation.pdf
	xdg-open $<

.PHONY: pack
pack: $(PACKDIR)/tultemplate2.zip

.PHONY: bundle
bundle: $(BUNDLE_TARGETS)
	@echo "!! Bundles are made for tultemplategen and not for direct use !!"

.PHONY: minimal
minimal: $(MINIMAL_TARGETS) $(MINIMALDIR)/tultemplate2_minimal.zip

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
	rm -rf template/lib

# == ROOTS ==

$(BUILD_DIR):
	mkdir $@

$(PACKS_ROOT): | $(BUILD_DIR)
	mkdir $@

$(PACKSTAGING): | $(PACKS_ROOT)
	mkdir $@

$(PACKDIR): | $(PACKS_ROOT)
	mkdir $@

$(BUNDLEDIR): | $(PACKS_ROOT)
	mkdir $@

$(MINIMALDIR): | $(PACKS_ROOT)
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

define typst_pkgs
$(if $(TYPST_PACKAGES), --package-cache-path $(TYPST_PACKAGES))
endef

define typst_compile
	typst compile --font-path template/fonts$(call typst_pkgs) --root .
endef

# == LIBS ==

$(LIBDIR):
	mkdir $@

$(LIB_MUCHPDFTOOLS): | $(LIBDIR)
	mkdir $@

template/lib/much_pdf_tools/lib.typ: | $(LIB_MUCHPDFTOOLS)
	cd $(LIB_MUCHPDFTOOLS) && wget "$(LIB_URL_MUCHPDFTOOLS)/lib.typ"

template/lib/much_pdf_tools/much_pdf_tools.wasm: | $(LIB_MUCHPDFTOOLS)
	cd $(LIB_MUCHPDFTOOLS) && wget "$(LIB_URL_MUCHPDFTOOLS)/much_pdf_tools.wasm"

# == DOCUMENTATION ==

$(BUILD_DIR)/documentation.pdf: documentation.typ $(TEMPLATE_SRCS) | $(BUILD_DIR)
	$(call typst_compile) $< $@

# == THESES EXAMPLES ==

$(BUILD_DIR)/presentation_%.typ: theses/presentation_%.typ | $(BUILD_DIR)
	ln -f $< $@

$(BUILD_DIR)/subs_%.txt: theses/%.typ | $(BUILD_DIR)
	awk 'BEGIN{RS=""; ORS="\n\n"} NR>2{print}' $< > $@

$(BUILD_DIR)/header_base_%.txt: theses/%.typ | $(BUILD_DIR)
	awk 'BEGIN{RS=""; ORS="\n\n"} NR<3{print}' $< > $@

$(BUILD_DIR)/assignment_%_cs.txt: theses/assignment_cs.typ | $(BUILD_DIR)
	ln -f $< $@

$(BUILD_DIR)/assignment_%_en.txt: theses/assignment_en.typ | $(BUILD_DIR)
	ln -f $< $@

$(BUILD_DIR)/header_substituted_%.txt: $(BUILD_DIR)/header_base_%.txt $(BUILD_DIR)/assignment_%.txt
	sed -e "/__assignment__/r $(BUILD_DIR)/assignment_$*.txt" -e "/__assignment__/d" $< > $@

$(BUILD_DIR)/content_%_cs.txt: $(BUILD_DIR)/subs_%_cs.txt theses/content_cs.typ
	cat theses/content_cs.typ | \
		$(call replace_with_file_line,{{ta}},$<,1) | $(call replace_with_file_line,{{tou}},$<,2) | \
		awk 'BEGIN{RS=""; ORS="\n\n"} NR>2{print}' > $@

$(BUILD_DIR)/content_%_en.txt: $(BUILD_DIR)/subs_%_en.txt theses/content_en.typ
	cat theses/content_en.typ | \
		$(call replace_with_file_line,{{what}},$<,1) | \
		awk 'BEGIN{RS=""; ORS="\n\n"} NR>2{print}' > $@

$(BUILD_DIR)/%.typ: $(BUILD_DIR)/header_substituted_%.txt $(BUILD_DIR)/content_%.txt | $(BUILD_DIR)
	cat $^ > $@

$(BUILD_DIR)/%.pdf: $(BUILD_DIR)/%.typ $(TEMPLATE_SRCS) | $(BUILD_DIR)
	$(call typst_compile) $< $@

template/example_appendix.pdf: theses/example_appendix.typ
	$(call typst_compile) $< $@

# == PACK STAGING - files prepared for packing or bundling ==

$(PACKSTAGING)/template: | $(PACKSTAGING)
	mkdir $@

$(PACKSTAGING)/template/citations: | $(PACKSTAGING)/template
	mkdir $@

$(PACKSTAGING)/template/LICENSE: LICENSE | $(PACKSTAGING)/template
	ln -f $< $@

$(PACKSTAGING)/template/citations/%: template/citations/% | $(PACKSTAGING)/template/citations
	$(call minify_csl,$<,$@)

$(PACKSTAGING)/template/lang.json: template/lang.json | $(PACKSTAGING)/template
	$(call minify_json,$<,$@)

$(PACKSTAGING)/documentation.pdf: $(BUILD_DIR)/documentation.pdf | $(PACKSTAGING)
	ln -f $< $@

$(PACKSTAGING)/%.pdf: $(BUILD_DIR)/%.pdf | $(PACKSTAGING)
	ln -f $< $@

$(PACKSTAGING)/%: % | $(PACKSTAGING)
	@mkdir -p $(@D)
	ln -f $< $@

# == PACKS - clean builds for direct use ==

$(PACKDIR)/Makefile: packed.mk | $(PACKDIR)
	ln -f $< $@

$(PACKDIR)/tultemplate2.zip: $(PACK_TARGETS) | $(PACKDIR)
	rm -f $@
	cd $(PACKS_ROOT) && zip -r tultemplate2.zip tultemplate2

$(PACKDIR)/%: $(PACKSTAGING)/% | $(PACKDIR)
	@mkdir -p $(@D)
	ln -f $< $@

# == BUNDLES - packs for tultemplategen ==

$(BUNDLEDIR)/Makefile: templategen.mk | $(BUNDLEDIR)
	ln -f $< $@

$(BUNDLEDIR)/presentation_%.typ: theses/presentation_%.typ | $(BUNDLEDIR)
	cat $< | awk 'BEGIN{RS=""; ORS="\n\n"} NR>2{print}' > $@

$(BUNDLEDIR)/%.typ: $(BUILD_DIR)/content_%.txt | $(BUNDLEDIR)
	sed 's/\.\.\/template\//template\//' $< > $@

$(BUNDLEDIR)/title-pages.pdf: theses/title_pages.typ | $(BUNDLEDIR)
	$(call typst_compile) $< $@

$(BUNDLEDIR)/assignment.pdf: theses/assignment.typ | $(BUNDLEDIR)
	$(call typst_compile) $< $@

$(BUNDLEDIR)/%: $(PACKSTAGING)/% | $(BUNDLEDIR)
	@mkdir -p $(@D)
	ln -f $< $@

# == MINIMAL - stripped-down template packs ==

$(MINIMALDIR)/%: $(PACKSTAGING)/% | $(MINIMALDIR)
	@mkdir -p $(@D)
	ln -f $< $@

$(MINIMALDIR)/tultemplate2_minimal.zip: $(MINIMAL_TARGETS) | $(MINIMALDIR)
	rm -f $@
	cd $(MINIMALDIR) && zip -r $(notdir $@) template

# == TESTS ==

include tests/make.mk
