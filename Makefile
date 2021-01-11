.PHONY: all clean

.PRECIOUS: %.xml %.pdf

TARGETS=latexmlleeds.zip latexmlleeds/index.html latexmlleeds/LaTeXML-Leeds.epub latexmlleeds/LaTeXML-Leeds.pdf LaTeXML-Leeds.xml LaTeXML-Leeds.pdf

XML_DEPS=latexmlleeds.sty latexmlleeds.sty.ltxml

IMG_DEPS=LaTeXML-Leeds.pdf

all: $(TARGETS)

clean:
	-rm -f $(TARGETS)
	-rm -fr images latexmlleeds
	-rm -f $(addprefix LaTeXML-Leeds.,aux auxlock fdb_latexmk fls log out synctex.gz toc)

images:
	mkdir "$@"

latexmlleeds:
	mkdir "$@"

latexmlleeds.zip: latexmlleeds/index.html latexmlleeds/LaTeXML-Leeds.epub latexmlleeds/LaTeXML-Leeds.pdf
	-rm -f "$@"
	zip -r "$@" latexmlleeds

latexmlleeds/index.html: LaTeXML-Leeds.xml latexmlleeds.css LaTeXML-html5.xsl | latexmlleeds
	latexmlpost --pmml --mathtex --svg --destination="$@" "$<"

latexmlleeds/%.epub: %.tex latexmlleeds.css $(XML_DEPS)
	latexmlc --splitat=chapter --svg --destination="$@" "$<"

%.pdf: %.tex latexmlleeds.sty | images
	latexmk -latexoption="-interaction=nonstopmode -halt-on-error -shell-escape" -pdf "$<"

%.dvi: %.tex latexmlleeds.sty | images
	latexmk -latexoption="-interaction=nonstopmode -halt-on-error -shell-escape" "$<"

latexmlleeds/%.pdf: %.pdf
	cp "$<" "$@"

%.xml: %.tex $(XML_DEPS) $(IMG_DEPS)
	latexml --destination="$@" "$<"
