#!/usr/bin/tcsh -f
##
## VERSION HISTORY
## [2026-03-05 MeD] Initial version to capture my command-line usage of pandoc
##
##*********************************************************************************************************
/usr/bin/pandoc          \
    --to=pdf             \
    --pdf-engine=xelatex \
    --output=README.pdf  \
    -V colorlinks=true   \
    -V linkcolor=blue    \
    -V toccolor=gray     \
    README.md
