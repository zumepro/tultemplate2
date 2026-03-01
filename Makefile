TYPST_PACKAGES ?=

BUILD_DIR := target
PACKS_ROOT := $(BUILD_DIR)/pack
PACKSTAGING := $(PACKS_ROOT)/staging
MINIMALDIR := $(PACKS_ROOT)/minimal

LIBDIR := template/lib
LIB_MUCHPDFTOOLS := $(LIBDIR)/much_pdf_tools
LIB_TARGETS_MUCHPDFTOOLS := lib.typ much_pdf_tools.wasm
LIB_URL_MUCHPDFTOOLS := https://typst.tul.cz/lib/much_pdf_tools

MINIMAL_ASSET_ROOTS := template/assets template/fonts template/citations
MINIMAL_SRCS := $(shell find template -type f -regex '^.*\.typ$$') \
				$(shell find $(MINIMAL_ASSET_ROOTS) -type f) \
				template/lang.json \
				$(LIB_TARGETS_MUCHPDFTOOLS:%=$(LIB_MUCHPDFTOOLS)/%)
TEMPLATE_SRCS := $(MINIMAL_SRCS)
ADD_TO_PACK := template/LICENSE template/build_date.txt
TO_PACK_MINIMAL := $(MINIMAL_SRCS) $(ADD_TO_PACK)
MINIMAL_TARGETS := $(TO_PACK_MINIMAL:%=$(MINIMALDIR)/%)

# == MAIN TARGETS ==

.PRECIOUS: $(BUILD_DIR)/%.pdf

.PHONY: view_documentation
view_documentation: $(BUILD_DIR)/documentation_en.pdf
	xdg-open $<

.PHONY: view_documentation_cs
view_documentation_cs: $(BUILD_DIR)/documentation_cs.pdf
	xdg-open $<

.PHONY: minimal
minimal: $(MINIMAL_TARGETS) $(MINIMALDIR)/tultemplate2_minimal.zip

.PHONY: watch_documentation
watch_documentation: $(BUILD_DIR)/documentation_en.pdf
	xdg-open $< & typst watch --font-path template/fonts documentation_en.typ $<

.PHONY: watch_documentation_cs
watch_documentation_cs: $(BUILD_DIR)/documentation_cs.pdf
	xdg-open $< & typst watch --font-path template/fonts documentation_cs.typ $<

.PHONY: thesis_%
thesis_%: $(BUILD_DIR)/%.pdf
	xdg-open $<

.PHONY: documentation
documentation: $(BUILD_DIR)/documentation_en.pdf $(BUILD_DIR)/documentation_cs.pdf

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

define typst_compile
	typst compile --font-path template/fonts --root .
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

$(BUILD_DIR)/documentation_%.pdf: documentation_%.typ $(TEMPLATE_SRCS) | $(BUILD_DIR)
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

.PHONY: $(PACKSTAGING)/template/build_date.txt
$(PACKSTAGING)/template/build_date.txt: | $(PACKSTAGING)/template
	date +%Y-%m-%dT%H:%M:%S > $@

$(PACKSTAGING)/documentation_%.pdf: $(BUILD_DIR)/documentation_%.pdf | $(PACKSTAGING)
	ln -f $< $@

$(PACKSTAGING)/%.pdf: $(BUILD_DIR)/%.pdf | $(PACKSTAGING)
	ln -f $< $@

$(PACKSTAGING)/%: % | $(PACKSTAGING)
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
