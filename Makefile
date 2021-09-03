.PHONY: all clean

.PRECIOUS: %.xml %.pdf

TARGETS=latexmlleeds.zip latexmlleeds/index.html LaTeXML-Leeds.epub LaTeXML-Leeds.pdf LaTeXML-Leeds.xml LaTeXML-Leeds.pdf latexmlleeds/bmluser.zip

all: $(TARGETS)

clean:
	-rm -f $(TARGETS)
	-rm -fr bmlimages latexmlleeds
	-latexmk -C LaTeXML-Leeds.tex

latexmlleeds.zip: latexmlleeds/index.html latexmlleeds/index.plain.html latexmlleeds/bmluser.zip
	-rm -f "$@"
	zip -r "$@" $< latexmlleeds

latexmlleeds/bmluser.zip: bmluser/latexmlleeds.css bmluser/latexmlleeds.plain.css
	-rm -f "$@"
	zip -r "$@" $<

latexmlleeds/index.html: LaTeXML-Leeds.xml LaTeXML-Leeds.pdf LaTeXML-Leeds.epub
	$(LML_PREFIX)latexmlpost --pmml --mathtex --destination="$@" --navigationtoc=context --splitat=section --timestamp=0 "$<"

latexmlleeds/index.plain.html: LaTeXML-Leeds.plain.xml LaTeXML-Leeds.pdf LaTeXML-Leeds.epub
	$(LML_PREFIX)latexmlpost --pmml --mathtex --destination="$@" --timestamp=0 "$<"

%.epub: %.tex
	$(LML_PREFIX)latexmlc --preload=[style=plain]bookml/bookml --splitat=section --destination="$@" --timestamp=0 "$<"

%.pdf: %.tex
	latexmk -interaction=nonstopmode -halt-on-error -pdf "$<"

%.xml: %.tex
	$(LML_PREFIX)latexml --destination="$@" "$<"

%.plain.xml: %.tex
	$(LML_PREFIX)latexml --preload=[style=plain]bookml/bookml --destination="$@" "$<"
