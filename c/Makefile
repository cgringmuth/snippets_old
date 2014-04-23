ASD = asciidoc
ADFLAGS =

files_html = 
files_html += c.asciidoc

files_man = 


all: man html


html: $(files_html)
	$(ASD) $(ADFLAGS) --doctype=article --backend=html5 $(files_html)

# Currently this is not working
man: $(files_man)
	$(ASD) $(ADFLAGS) --doctype=manpage $(files_man)


clean:
	rm -rf *.html

.PHONY: clean