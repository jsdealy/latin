index: index.md
	../scr.pl --prose index.md | pandoc -f markdown-smart -o out.html -s --css ../tufte/tufte.css && perl -pe 's/<img src/<img width="90" height="90" src/g' out.html > index.html && rm out.html && scpToWebsite.sh -f latin index.html 
