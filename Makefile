TITLE=Brian H. Rutledge

SRC_MD=$(wildcard *-resume.md)
SRC_CSS=$(addprefix css/,import.css normalize.css style.css)

CSS=resume.css
HTML=$(SRC_MD:.md=.html)
PDF=$(SRC_MD:.md=.pdf)

all: html pdf
css: $(CSS)
html: $(HTML)
pdf: $(PDF)

$(CSS): $(SRC_CSS)
	cat $^ > $@

%.html: %.md $(CSS)
	pandoc --to=html5 --css=$(CSS) --smart --standalone \
		--variable=pagetitle:"$(TITLE)" --output=$@ $<

%.pdf: %.html
	wkhtmltopdf --quiet --print-media-type --page-size Letter \
		--title "$(TITLE)" $< $@

clean:
	rm -f $(CSS) *.html *.pdf
