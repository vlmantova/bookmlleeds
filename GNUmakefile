SPLITAT=
LATEXMLPOSTEXTRAFLAGS=--timestamp=0

# default target
bookmlleeds.tar:

include bookml/bookml.mk

%.tar: $$(AUX_DIR)/html/$$*/index.html $$(filter-out $$(AUX_DIR)/html/$$*/imsmanifest.xml,$$(filter-out $$(AUX_DIR)/html/$$*/LaTeXML.cache,$$(call bml.reclist.file,$$(AUX_DIR)/html/$$*)))
	tar -cvf $@ --directory=$(AUX_DIR)/html/$* --exclude=./imsmanifest.xml --exclude=./LaTeXML.cache .
