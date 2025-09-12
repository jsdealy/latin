MD_FILES := $(wildcard dbg*.md)

HTML_FILES := $(MD_FILES:.md=.html)

all: $(HTML_FILES)

ifeq ($(LIGHT),1)
	$(info Did not push anything to the website because LIGHT mode was used.)
dbg%.html: dbg%.md
	../scr.pl --prose $< | pandoc -f markdown-smart -o out.html -s --css ../tufte/tufte.css && perl -pe 's/<img src/<img width="90" height="90" src/g' out.html > $@ && rm out.html
else
dbg%.html: dbg%.md
	../scr.pl --prose $< | pandoc -f markdown-smart -o out.html -s --css ../tufte/tufte.css && perl -pe 's/<img src/<img width="90" height="90" src/g' out.html > $@ && rm out.html && scpToWebsite.sh -f latin $@ && rm $@
endif
