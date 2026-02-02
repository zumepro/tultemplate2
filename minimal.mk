TARGET := thesis

.PHONY: watch
watch: $(TARGET).pdf
	xdg-open $< & typst watch --font-path template/fonts $(TARGET).typ $<

$(TARGET).pdf: $(TARGET).typ template
	typst compile --font-path template/fonts $< $@

tultemplate2_minimal.zip:
	wget https://typst.tul.cz/tultemplate2_minimal.zip

.PRECIOUS: template
template: tultemplate2_minimal.zip
	rm -rf template
	unzip $<
	touch $@

.PHONY: clean
clean:
	rm -rf $(TARGET).pdf template
