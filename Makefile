TYPST_PACKAGES ?=

BUILD_DIR := target
PACKS_ROOT := $(BUILD_DIR)/pack
PACKDIR := $(PACKS_ROOT)/tultemplate2
BUNDLEDIR := $(PACKS_ROOT)/bundle

LIBDIR := template/lib
LIB_MUCHPDFTOOLS := $(LIBDIR)/much_pdf_tools
LIB_TARGETS_MUCHPDFTOOLS := lib.typ much_pdf_tools.wasm
LIB_URL_MUCHPDFTOOLS := https://tulsablona.zumepro.cz/lib/much_pdf_tools

TEMPLATE_SRCS := $(shell find template -type f) \
				 $(LIB_TARGETS_MUCHPDFTOOLS:%=$(LIB_MUCHPDFTOOLS)/%) template/example_appendix.pdf
TO_PACK := $(TEMPLATE_SRCS) template/LICENSE
BUNDLE_THESES := bp_cs bp_en dp_cs dp_en prj_cs prj_en sp_cs sp_en presentation_cs presentation_en
BUNDLE_TARGETS := $(TO_PACK:%=$(BUNDLEDIR)/%) $(BUNDLEDIR)/citations.bib $(BUNDLEDIR)/bp_cs.typ \
				  $(BUNDLE_THESES:%=$(BUNDLEDIR)/%.typ) $(BUNDLEDIR)/Makefile \
				  $(BUNDLEDIR)/title-pages.pdf $(BUNDLEDIR)/assignment.pdf
PACK_TARGETS := $(TO_PACK:%=$(PACKDIR)/%) $(PACKDIR)/documentation.typ \
				$(PACKDIR)/documentation.pdf $(PACKDIR)/citations.bib $(PACKDIR)/Makefile

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
	$(call typst_compile) $< $@

template/example_appendix.pdf: theses/example_appendix.typ
	$(call typst_compile) $< $@

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

$(BUNDLEDIR)/presentation_%.typ: theses/presentation_%.typ | $(BUNDLEDIR)
	cat $< | awk 'BEGIN{RS=""; ORS="\n\n"} NR>2{print}' > $@

$(BUNDLEDIR)/%.typ: $(BUILD_DIR)/content_%.txt | $(BUNDLEDIR)
	sed 's/\.\.\/template\//template\//' $< > $@

$(BUNDLEDIR)/title-pages.pdf: theses/title_pages.typ | $(BUNDLEDIR)
	$(call typst_compile) $< $@

$(BUNDLEDIR)/assignment.pdf: theses/assignment.typ | $(BUNDLEDIR)
	$(call typst_compile) $< $@

# == TESTS ==

include tests/make.mk
