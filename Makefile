TITLE:=Brian H. Rutledge

MD:=$(wildcard *-resume.md)
CSS:=$(addprefix css/,import.css normalize.css style.css)
FOOTER:=include/footer.html

HTML:=$(MD:.md=.html)
PDF:=$(MD:.md=.pdf)

all: html pdf
css: $(CSS)
html: $(HTML)
pdf: $(PDF)

%.html: %.md $(CSS)
	pandoc --to=html5 --smart --standalone --section-divs \
		$(addprefix --css=,$(CSS)) \
		--variable=pagetitle:"$(TITLE)" --output=$@ $<

%.pdf: %.html $(FOOTER)
	wkhtmltopdf --quiet --print-media-type --page-size Letter \
		--margin-top 15 --margin-right 25 --margin-bottom 20 --margin-left 25 \
		--footer-html $(FOOTER) --footer-spacing 5 \
		--title "$(TITLE)" $< $@

clean:
	rm -f *.html *.pdf
