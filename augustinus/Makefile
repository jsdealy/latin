confessiones: confessiones1.md
	../scr.pl --prose confessiones1.md | pandoc -f markdown-smart -o out.html -s --css ../tufte/tufte.css && perl -pe 's/<img src/<img width="90" height="90" src/g' out.html > confessiones1.html && rm out.html && scpToWebsite.sh confessiones1.html
