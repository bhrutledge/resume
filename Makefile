TITLE:=Brian H. Rutledge

MD:=$(wildcard *-resume.md)
CSS:=$(addprefix css/,import.css normalize.css style.css)

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

%.pdf: %.html
	wkhtmltopdf --quiet --print-media-type --page-size Letter \
		--title "$(TITLE)" $< $@

clean:
	rm -f *.html *.pdf
