.PHONY: all clean

.PRECIOUS: %.xml

TARGETS=latexmlleeds.zip latexmlleeds/index.html latexmlleeds/LaTeXML-Leeds.epub latexmlleeds/LaTeXML-Leeds.pdf

all: $(TARGETS)

clean:
	-rm -f $(TARGETS)

latexmlleeds.zip: latexmlleeds/index.html latexmlleeds/LaTeXML-Leeds.epub latexmlleeds/LaTeXML-Leeds.pdf
	zip -r "$@" latexmlleeds

latexmlleeds/index.html: LaTeXML-Leeds.xml latexmlleeds.css latexmlleeds-html5.xsl
	latexmlpost \
		--javascript="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"\
		--mathtex --svg --stylesheet=latexmlleeds-html5.xsl \
		--css=latexmlleeds.css --destination="$@" "$<"

latexmlleeds/%.epub: %.tex latexmlleeds.css
	latexmlc --splitat=chapter --svg --css=latexmlleeds.css \
    --destination="$@" "$<"

latexmlleeds/%.pdf: %.tex
	latexmk -latexoption="-interaction=noninteractionmode -halt-on-error" -pdf "$<"

%.xml: %.tex latexmlleeds.sty latexmlleeds.sty.ltxml
	latexml --destination="$@" "$<"

