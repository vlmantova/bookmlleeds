.PHONY: all

.PRECIOUS: %.xml

all: LaTeXML-Leeds.html LaTeXML-Leeds.epub LaTeXML-Leeds.pdf

%.epub: %.tex
	latexmlc --splitat=chapter --css=latexmlleeds.css \
    --destination="$@" "$<"

%.html: %.xml
	latexmlpost \
    --javascript="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"\
    --mathtex --stylesheet=latexmlleeds-html5.xsl \
    --css=latexmlleeds.css --destination="$@" "$<"

%.xml: %.tex
	latexml --destination="$@" "$<"

%.pdf: %.tex
	latexmk -latexoption="-interaction=noninteractionmode -halt-on-error" -pdf "$<"