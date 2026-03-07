#!/usr/bin/tcsh -f
##
## VERSION HISTORY
## [2026-03-05 MeD] Initial version to capture my command-line usage of pandoc
##
##*********************************************************************************************************
## To make this "pretty" will need to replace all 'ɣ' with $\gamma$ in the text.
/usr/bin/sed -e 's/ɣ/$\\gamma$/g' README.md | \
    /usr/bin/pandoc      \
    --to=pdf             \
    --pdf-engine=xelatex \
    --output=README.pdf  \
    -V colorlinks=true   \
    -V linkcolor=blue    \
    -V toccolor=gray
    
