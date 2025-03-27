## Controlled Vocabulary for INCENTIVE
##
## There are several locations where I try to use a controlled
## vocabulary in the output CSV files that I generate. If members of
## INCENTIVE use this vocabuarly ahead of time, then my work is
## simplified.
##
## This vocabulary is written in R, but is easily understood for
## adding items in a spreadsheet. For example, in the Excel column
## labeled "Trial", one would expect to see "QIV1" (without the
## quotes) or "QIV2" or "QIV3".
##
## To use this file within R, source it and use the items as levels
## for factors:
##
##    source("Controlled-Vocab.R")
##    dat <- read.csv("A-data-file.csv", header=TRUE, as.is=TRUE)
##    dat$Trial <- factor(dat$Trial, levels=TrialNames)
##
## This document evolves as I add new assays and learn new spelling
## variants.
##
## VERSION HISTORY
## (2025-03-27 MeD] Initial public version
##
##**********************************************************************

## What are the Clinical Trials called?
## Use 'None' when it is not from a trial, for example, a positive control.
## Some groups fill in an information type for SampleType not a sample:
##    "BL" = blanks; "PC" = standards; "None" = a "sample" but not from this trial.
TrialNames <- c( 'QIV1', 'QIV2', 'QIV3', 'None' )

## What are the valid Assay Names.
## Add a pseudo-Assay, HI-Responder, to capture the computation of Responder/Non-Reposnder
AssayNames <- c(
    ## First group from Becky Cox's lab.
    'HI', 'HI-Responder', 'MN', 'MN-Plasma', 'ELLA', 'ELISA',
    ## Second group from Arnaud Marchand's lab. Uses UTF-8 Gamma character.
    'ADCD', 'ADCP',
    'FcɣR2A',  'FcɣR2A', 'FcɣR2B', 'FcɣR2B',
    'FcɣR3A',  'FcɣR3A', 'FcɣR3B', 'FcɣR3B',
    ## Third group from Carlotta Dobano's lab
    "SpecAb"    # <-- See IDA-EDA_ISGlobal.R for this: Antigen-specific antibody
)

## Well-types. For a micro-titer plate, one commonly speaks of
## "samples", "blanks", "controls", "standards", etc. Here is a
## list of the "words" that I am currently using for sample types
## found in micro-titer plates:
SampleTypes <- c(
    'Samp',        # "Sample". Contains the sample that we are assaying
    'Stnd',        # "Standard". Contains the "Standard Curve" aka "Calibration curve"
    'Blank',       # "Blank". A well containing buffer, etc, but no analytes
    'Empty',       # "Empty". A well containing air
    'Ctrl',        # "Control". A control of some kind
    'Pctrl',       # "Positive Control".
    'Nctrl',       # "Negative Control".
    'None'         # Used when a "Sample Type" is not appropriate rather than NA.
)

## The "day" that the Sample was taken. Started as "Day 0" was "D0",
## "Day 3" was "D3" and "Day 28" was "D28". Modified to include a
## leading ZERO so lexicographic sorting also sorts by day:
VisitDay <- c(
    "D000",        # Day 0: prior to vaccination
    "D003",        # Day 3: sampled for transcriptome. Beware "Day 3 to 8" = "D3-8".
    "D028",        # Day 28: QIV1 sample post-vaccination
    "D030",        # Day 30: QIV2,3 sample #1 post-vaccination
    "D058",        # Day 58: QIV2,3 sample #2 post-vaccination
    "D180",        # Day 180: QIV2 sample at 6 months
    "D365"         # Day 365: QIV2 sample at 1 year
)

## There have been an incredible number of different spellings for the
## influenza strains used. These names are from the WHO nomenclature
## and when Googled, turn up papers or products that match the name.
## In some locations, I have found misspellings like:
##     "A/Guangdong-Moanan/SWL1536/2019 (H1N1)" and
##     "A/Singapore/IFNIMH-16-0019/2016 (H3N2)"
## Close but not close enough.
##
## In the case of the A-strains, there is a single space between the
## strain name and its '(H1N1)' information.
##
## Interestingly, names like "A/Hong Kong/..." are meant to include a
## space in the name, as shown.
##
## If these names need to be included in filenames, obviously, the
## SLASH character, '/', can not be used as it delimits directories
## under Windows and Linux. I suggest one uses the UTF "long slash
## overlay', U+0338, '̸', e.g.:
##        "A̸Brisbane̸02̸2018 (H1N1)"  # With UTF-8 character
##        "A/Brisbane/02/2018 (H1N1)", # With simple ASCII character
KnownStrains <- c(
    "A/Brisbane/02/2018 (H1N1)",
    "A/Brisbane/57/2007 (H1N1)",
    "A/California/04/2009 (H1N1)",
    "A/California/07/2019 (H1N1)",
    "A/Darwin/9/2021 (H3N2)",
    "A/Darwin/6/2021 (H3N2)",
    "A/Guangdong-Maonan/SWL1536/2019 (H1N1)",
    "A/Hong Kong/45/2019 (H3N2)",               # FIXME: Confirm Hong Kong strain
    "A/Hong Kong/4801/2014 (H3N2)",
    "A/Panama/2007/1999 (H3N2)",
    "A/Singapore/INFIMH-16-0019/2016 (H3N2)",
    "A/Switzerland/9715293/2013 (H3N2)",
    "A/Tasmania/503/2020 (H3N2)",
    "A/Victoria/2570/2019 (H1N1)",
    "A/Wisconsin/588/2019 (H1N1)",
    "B/Austria/1359417/2021",
    "B/Phuket/3073/2013",
    "B/Washington/02/2019"
)

## Names that I have found that look right, but aren't.
## There are lots of others that look wrong, but I have tried to fix
## those already.
UnknownStrains <- c(
    "A/Darwin/09/2021 (H3N2)",                   # Should be '9' not '09'
    "A/Guangdong-Moanan/SWL1536/2019 (H1N1)",    # Moanan --> Maonan
    "A/HongKong/4801/2014 (H3N2)",               # HongKong --> Hong Kong
    "A/Singapore/IFNIMH-16-0019/2016 (H3N2)"     # IFN --> INF
)

##**********************************************************************
## End Of File
