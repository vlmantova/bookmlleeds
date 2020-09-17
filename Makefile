.PHONY: all clean

.PRECIOUS: %.xml %.pdf

TARGETS=latexmlleeds.zip latexmlleeds/index.html latexmlleeds/LaTeXML-Leeds.epub latexmlleeds/LaTeXML-Leeds.pdf

XML_DEPS=latexmlleeds.sty latexmlleeds.sty.ltxml LaTeXML-Leeds.pdf

all: $(TARGETS)

clean:
	-rm -f $(TARGETS)
	-rm -fr images latexmlleeds

images:
	mkdir "$@"

latexmlleeds:
	mkdir "$@"

latexmlleeds.zip: latexmlleeds/index.html latexmlleeds/LaTeXML-Leeds.epub latexmlleeds/LaTeXML-Leeds.pdf
	-rm -f "$@"
	zip -r "$@" latexmlleeds

latexmlleeds/index.html: LaTeXML-Leeds.xml latexmlleeds.css LaTeXML-html5.xsl | latexmlleeds
	latexmlpost --mathtex --svg --destination="$@" "$<"

latexmlleeds/%.epub: %.tex latexmlleeds.css $(XML_DEPS)
	latexmlc --splitat=chapter --svg --destination="$@" "$<"

%.pdf: %.tex latexmlleeds.sty
	latexmk -latexoption="-interaction=noninteractionmode -halt-on-error -shell-escape" -pdf "$<"

%.dvi: %.tex latexmlleeds.sty
	latexmk -latexoption="-interaction=noninteractionmode -halt-on-error -shell-escape" "$<"

latexmlleeds/%.pdf: %.pdf
	cp "$<" "$@"

%.xml: %.tex $(XML_DEPS)
	latexml --destination="$@" "$<"
