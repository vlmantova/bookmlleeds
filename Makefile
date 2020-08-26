.PHONY: all clean

.PRECIOUS: %.xml

TARGETS=latexmlleeds/index.html latexmlleeds/LaTeXML-Leeds.epub latexmlleeds/LaTeXML-Leeds.pdf

all: $(TARGETS)

clean:
	-rm -f $(TARGETS)

<<<<<<< HEAD
%.epub: %.tex
	latexmlc --splitat=chapter --svg --css=latexmlleeds.css \
		--destination="$@" "$<"

%.html: %.xml
=======
latexmlleeds/index.html: LaTeXML-Leeds.xml
>>>>>>> 78a2264... recommend to generate HTML in a subfolder
	latexmlpost \
		--javascript="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"\
		--mathtex --svg --stylesheet=latexmlleeds-html5.xsl \
		--css=latexmlleeds.css --destination="$@" "$<"

latexmlleeds/%.epub: %.tex
	latexmlc --splitat=chapter --svg --css=latexmlleeds.css \
    --destination="$@" "$<"

latexmlleeds/%.pdf: %.tex
	latexmk -latexoption="-interaction=noninteractionmode -halt-on-error" -pdf "$<"

%.xml: %.tex
	latexml --destination="$@" "$<"

