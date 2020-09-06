.PHONY: all clean

.PRECIOUS: %.xml %.pdf

TARGETS=latexmlleeds.zip latexmlleeds/index.html latexmlleeds/LaTeXML-Leeds.epub latexmlleeds/LaTeXML-Leeds.pdf

XML_DEPS=latexmlleeds.sty latexmlleeds.sty.ltxml

all: $(TARGETS)

clean:
	-rm -f $(TARGETS)
	-rm -fr latexmlleeds

latexmlleeds:
	mkdir "$@"

latexmlleeds.zip: latexmlleeds/index.html latexmlleeds/LaTeXML-Leeds.epub latexmlleeds/LaTeXML-Leeds.pdf
	-rm -f "$@"
	zip -r "$@" latexmlleeds

latexmlleeds/index.html: LaTeXML-Leeds.xml latexmlleeds.css LaTeXML-html5.xsl | latexmlleeds
	latexmlpost --mathtex --svg --destination="$@" "$<"

latexmlleeds/%.epub: %.tex $(XML_DEPS) latexmlleeds.css
	latexmlc --splitat=chapter --svg --destination="$@" "$<"

%.pdf: %.tex latexmlleeds.sty
	latexmk -latexoption="-interaction=noninteractionmode -halt-on-error" -pdf "$<"

latexmlleeds/%.pdf: %.pdf
	cp "$<" "$@"

%.xml: %.tex $(XML_DEPS)
	latexml --destination="$@" "$<"
