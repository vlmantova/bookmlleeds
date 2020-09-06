.PHONY: all clean

.PRECIOUS: %.xml

TARGETS=latexmlleeds.zip latexmlleeds/index.html latexmlleeds/LaTeXML-Leeds.epub latexmlleeds/LaTeXML-Leeds.pdf

all: $(TARGETS)

clean:
	-rm -f $(TARGETS) latexmlleeds

latexmlleeds:
	mkdir "$@"

latexmlleeds.zip: latexmlleeds/index.html latexmlleeds/LaTeXML-Leeds.epub latexmlleeds/LaTeXML-Leeds.pdf
	-rm -f "$@"
	zip -r "$@" latexmlleeds

latexmlleeds/index.html: LaTeXML-Leeds.xml latexmlleeds.css LaTeXML-html5.xsl | latexmlleeds
	latexmlpost \
		--javascript="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" \
		--mathtex --svg --destination="$@" "$<"

latexmlleeds/%.epub: %.tex latexmlleeds.css
	latexmlc --splitat=chapter --svg \
		--destination="$@" "$<"

latexmlleeds/%.pdf: %.tex latexmlleeds.sty
	latexmk -latexoption="-interaction=noninteractionmode -halt-on-error" -pdf "$<"
	mv -f "$*".pdf "$@"

%.xml: %.tex latexmlleeds.sty latexmlleeds.sty.ltxml
	latexml --destination="$@" "$<"
