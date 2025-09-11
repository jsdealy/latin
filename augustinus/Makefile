MD_FILES := $(wildcard confessiones*.md)

HTML_FILES := $(MD_FILES:.md=.html)

all: $(HTML_FILES)

confessiones%.html: confessiones%.md
	../scr.pl --prose $< | pandoc -f markdown-smart -o out.html -s --css ../tufte/tufte.css && perl -pe 's/<img src/<img width="90" height="90" src/g' out.html > $@ && rm out.html && scpToWebsite.sh -f latin $@ && rm $@
