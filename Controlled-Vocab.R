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
## At this time, this file is expected to be loaded via "source()".
## Ideally this source() would occur after other objects (variables)
## were already defined to aid in catching collisions of object names.
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
## [2025-03-27 MeD] Initial public version
## [2025-04-08 MeD] Add colors (this is a strawman) = v1.0
## [2026-01-20 MeD] Review Influenza Virus Names, 'KnownStrains'.
##                  Remove leading zeros in 'KnownStrains' names.
##                  Add checks for object name collisions (ouch!).
##                  Substantial revision of output column names, "ColumnNames"
## [2026-02-07 MeD] Remove COMMA from SubAssayNames and SubAssay$ShortName so
##                  that I can use the command-line "cut -f<field> -d, filename".
##
##**********************************************************************
## Create a function to report errors when this controlled vocabulary
## collides with existing names.
nameCollisionError <- function(collision) {
    stop("Object name, '", collision,
         "', collides with existing name. Can not source('Controlled-Vocab.R').\n")
}

## Try to add an internal version to the controlled vocabulary.
if( exists("VocabVersion")) nameCollisionError("VocabVersion")
VocabVersion <- 'v1.6.1'

## What are the Clinical Trials called?
## Use 'None' when it is not from a trial, for example, a positive control.
## Some groups fill in an information type for SampleType not a sample:
##    "BL" = blanks; "PC" = standards; "None" = a "sample" but not from this trial.
if( exists("TrialNames")) nameCollisionError("TrialNames")
TrialNames <- c( 'QIV1', 'QIV2', 'QIV3', 'None' )

## What are the valid Assay Names.
## Add a pseudo-Assay, HI-Responder, to capture the computation of Responder/Non-Reposnder
if( exists("AssayNames")) nameCollisionError("AssayNames")
AssayNames <- c(
    ## First group from Becky Cox's lab.
    'HI', 'HI-Responder', 'MN', 'MN-Plasma', 'ELLA', 'ELISA',
    ## Second group from Arnaud Marchand's lab. Uses UTF-8 Gamma character.
    ## See note in 'parse-Marchand-Sharma_Systems-Serology.R' about nomenclature.
    ## Names should be: Fc\{gamma}R{Roman Numeral}{A,B}
    ## doi: 10.3389/fimmu.2020.01393
    'ADCD', 'ADCP',
    'FcɣR2A',  'FcɣR2B', 'FcɣR3A',  'FcɣR3B',
    ## Third group from Carlotta Dobano's lab
    "SpecAb",    # <-- See IDA-EDA_ISGlobal.R for this: Antigen-specific antibody
    ## Fourth group from Guzmán-Riese-Trittel - soluable factors released upon stim
    "SF:APRIL", "SF:EGF", "SF:ENA-78 (CXCL5)", "SF:Eotaxin (CCL11)",
    "SF:FGF-2", "SF:G-CSF (CSF-3)", "SF:GM-CSF", "SF:HGF", "SF:IFN alpha",
    "SF:IFN gamma", "SF:IL-1 beta", "SF:IL-10", "SF:IL-12/IL-23p40",
    "SF:IL-13", "SF:IL-15", "SF:IL-17A (CTLA-8)", "SF:IL-18", "SF:IL-1RA",
    "SF:IL-2", "SF:IL-21", "SF:IL-27", "SF:IL-2R", "SF:IL-4", "SF:IL-5",
    "SF:IL-6", "SF:IL-7", "SF:IL-8 (CXCL8)", "SF:IP-10 (CXCL10)",
    "SF:MCP-1 (CCL2)", "SF:MIG (CXCL9)", "SF:MIP-1 alpha (CCL3)",
    "SF:MIP-1 beta (CCL4)", "SF:SDF-1 alpha", "SF:TNF alpha", "SF:VEGF-A"
)

## Enumerate valid Sub-assay names for easier checking of SubAssays
## data frame.  Sub-Assays are seen in the Cox Lab serology where some
## assays have different sub-types. For example, "HI" assay can be
## measured on either a "vaccine strain" or a "non-vaccine strain".
SubAssayNames <- c("HI titre vaccine strain",
                   "HI titre non-vaccine strain",
                   "Neutralizing Ab titre",
                   "NA Inhibiting Ab titre",
                   "IgG endpoint titre",
                   "HA IgG endpoint titre",
                   "NA IgG endpoint titre"
                   )

## As of 2025-03-30 there are "Sub-Assays" or multiple different assays per sheet.
## This table lists the sub-assays as listed by the sheet creator, as well as a
## short name for the CSV file.
##    Trial: Which trial has this sub-assay.
##    Assay: Which assay has this sub-assay.
##    ShortName: Short name that I have assigned for CSV file
##    FullName: Name shown in Excel sheet defining the sub-assay
SubAssays <- data.frame(
    Trial=c(
        "QIV1", "QIV1", "QIV2", "QIV2", "QIV3",
        "QIV1", "QIV2", "QIV3",
        "QIV1", "QIV2", "QIV3",
        "QIV1", "QIV1", "QIV1", "QIV2", "QIV2", "QIV3"
    ),
    Assay=c(
        "HI", "HI", "HI", "HI", "HI",
        "MN", "MN", "MN",
        "ELLA", "ELLA", "ELLA",
        "ELISA", "ELISA", "ELISA", "ELISA", "ELISA", "ELISA"
    ),
    ShortName=c(
        "HI titre vaccine strain",
        "HI titre non-vaccine strain",
        "HI titre vaccine strain",
        "HI titre non-vaccine strain",
        "HI titre vaccine strain",
        "Neutralizing Ab titre",
        "Neutralizing Ab titre",
        "Neutralizing Ab titre",
        "NA Inhibiting Ab titre",
        "NA Inhibiting Ab titre",
        "NA Inhibiting Ab titre",
        "IgG endpoint titre",
        "HA IgG endpoint titre",
        "NA IgG endpoint titre",
        "HA IgG endpoint titre",
        "NA IgG endpoint titre",
        "HA IgG endpoint titre"
    ),
    FullName=c(
        "HI Titres Vaccine Strains",
        "HI Titres Past and future vaccine Strains",
        "HI Titres Vaccine Strains",
        "HI Titres",
        "HI Titres Vaccine Strains",
        "Neutralizing Ab Titres Vaccine Strains",
        "Neutralizing Ab Titres Vaccine Strains",
        "Neutralizing  Ab Titres Vaccine Strains",
        "NA Inhibiting Ab titres reasorted virus strains",
        "NA Inhibiting Ab titres reasorted virus strains",
        "NA Inhibiting Ab titres reasorted virus strains",
        "IgG Endpoint Titres Vaccine Strains",
        "HA IgG Endpoint titers",
        "NA IgG Endpoint Titer",
        "HA IgG Endpoint Titres Vaccine Strains",
        "NA IgG Endpoint Tiiter",
        "HA IgG Endpoint titer"
    ),
    stringsAsFactors=FALSE   # No longer needed as of R ver 4.0
)

## Check that all the entries in SubAssays are legit
stopifnot(SubAssays$Trial %in% TrialNames,
          SubAssays$Assay %in% AssayNames,
          SubAssays$ShortName %in% SubAssayNames
          )

## Well-types.
## For a micro-titer plate, one commonly speaks of "samples",
## "blanks", "controls", "standards", etc. Here is a list of the
## "words" that I am currently using for sample types found in
## micro-titer plates:
if( exists("SampleTypes")) nameCollisionError("SampleTypes")
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

## The "day" that the Sample was taken.

## Initial visit is "Day 0", recorded as "D0". Following was
## "Day 3", recorded as "D3" and "Day 28" as "D28".
## In the CSV files these are Modified to include a
## leading ZERO so lexicographic sorting also sorts by day.
## That is, sort( c("D0", "D3", "D28", "D365")) will be,
## c("D000", "D003", "D028", "D365"), and sort as expected.
##
## Note that in QIV2, "D003" was actually sampled anywhere
## between D003 and D008.
if( exists("VisitDay")) nameCollisionError("VisitDay")
VisitDay <- c(
    "D000",        # Day 0: prior to vaccination
    "D003",        # Day 3: sampled for transcriptome. Beware "Day 3 to 8" = "D3-8".
    "D003-8",      # Day 3-8: Samples in QIV2 (children) meant for day 3 arrived betwen day 3 & 8
    "D028",        # Day 28: QIV1 sample post-vaccination
    "D030",        # Day 30: QIV2,3 sample #1 post-vaccination
    "D058",        # Day 58: QIV2,3 sample #2 post-vaccination
    "D180",        # Day 180: QIV2 sample at 6 months
    "D365"         # Day 365: QIV2 sample at 1 year
)

## Column names in CSV files. The "earlier" ones are used in most (all?)
## assay-based CSV files. Later ones include "factors" used in some assays
## but not others, for example, "UreaPresent", a boolean value used in
## the ISGlobal data set.
## Attempt to order these in a hierarchy as one becomes more and more specific
## the sample and assay, etc.
if( exists("ColumnNames")) nameCollisionError("ColumnNames")
ColumnNames <- c(
    "SampleType", # What type of sample? A "Control" or a "Standard", etc. See SampleTypes, above.
    "Trial",      # Which Trial, QIV1, QIV2, QIV3. See TrialNames, above.
    "SubjectID",  # The subject ID without a leading "QIV1", etc. ATW010, etc
    "Day",        # Visit day, padded with leading zeros: D000, D003, D028, D030, D58, D180, D360
    "Assay",      # See "AssayNames", above
    "Strain",     # Which influenza strain in WHO canonical form. See KnownStrains, below.
    "Protein",    # The "HA" or "NA" protein from the strain. Written "pHA" and "pNA" to avoid NA.
    "StrainProt", # A shorthand name for the protein from a specific strain: pHA_A/Darwin etc
    "Dilution",   # Dilution of a sample, standard or control measurement. Use "1" for no dilution.
    "Value",      # Value measured - a pure number. Expect to see: digits, minus sign, decimal point
    "ValueUnit",  # String describing the unit of measure associated with the "Value"
    "SubAssay",   # String sub-setting Assay. See above, "SubAssays".
    "Isotype",    # The type of Ig: IgG, IgG1, IgG2, IgG3, IgG4, IgM, IgA, etc
    "UreaPresent",# A TRUE / FALSE value. Was Urea present (2 Molar) for affinty measures.
    "Stimulation",# A stimulation applied to blood cells to measure which soluable factors are released.
    "PlateID",    # If multiple plates were run, some ID that is specific to a plate.
    "Well"        # If micro-titer plates used, what well number: A1 - P24.
)

## There have been a large number of different spellings for the
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
if( exists("KnownStrains")) nameCollisionError("KnownStrains")
KnownStrains <- c(
    "A/Brisbane/2/2018 (H1N1)",
    "A/Brisbane/57/2007 (H1N1)",
    "A/California/4/2009 (H1N1)",               # FIXME: Confirm /California/4 is desired
    "A/California/7/2019 (H1N1)",
    "A/Darwin/9/2021 (H3N2)",
    "A/Darwin/6/2021 (H3N2)",                   # FIXME: Confirm '6'
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
    "B/Washington/2/2019",
    ## Following pairs are from a specific assay: Cox Lab serology ELLA
    "A/Equine/Prague/1/1956 (H7N7) + A/California/7/2019 (H1N1)",
    "A/Turkey/Massachusetts/3740/1965 (H6N2) + A/Texas/50/2012 (H2N2)",
    "A/Turkey/Massachusetts/3740/1965 (H6N2) + B/Yamagata/16/1988 (NB)",
    ## "Fake" strains added for special cases:
    "None",          # For negative controls
    "All",           # Mix of 4 vaccine strains: A/Tasmania, A/Victoria, B/Phuket, B/Washington
    "Staph. Enterotoxin B" # Positive control for "SolFact" experiment
)

## Names that I have found that look right, but aren't.
## There are lots of others that look wrong, but I have tried to fix
## those already.
if( exists("UnknownStrains")) nameCollisionError("UnknownStrains")
UnknownStrains <- c(
    "A/Guangdong-Moanan/SWL1536/2019 (H1N1)",    # Moanan --> Maonan
    "A/HongKong/4801/2014 (H3N2)",               # HongKong --> Hong Kong
    "A/Singapore/IFNIMH-16-0019/2016 (H3N2)"     # IFN --> INF
)

## [Following ALIAS table vastly simplified in later versions of data.]
## Translation of names from 'Alias' to 'Canonical' "Known Strains".
## Initial ALIAS were created by matching unknown names to list in "KnownStrains".
##
## Add as many aliases as needed.
##
## FIXME: This data.frame is hard to maintain. Consider using a format
##       more like: c("N1=H7N1", "N2=H6N2", "A/California=A/California/07/2019/H1N1", ...)
##       that is more readable and then using strsplit() to build the AliasStrains df.
if( exists('AliasStrains')) nameCollisionError("AliasStrains")
AliasStrains <-
    data.frame(Alias=c("A/Brisbane/02/2018 (H1N1)",
                       "A/Calfornia/07/2019(H1N1)",
                       "A/California/07/2019 (H1N1)",
                       "B/Washsington/02/2019", "B/WashIngton/02/2019", "B/Washington/02/2019",
                       "A/Darwin/09/2021 (H3N2)", "A/HongKong/4801/2014 (H3N2)",
                       "A/Singapore/IFNIMH-16-0019/2016 (H3N2)",
                       "A/Victoria/2570/2019/H1H1",
                       "A/Tasmania/503/2020/H3N2",
                       "A/Calfornia/07/2019 (H1N1)",
                       "A/Singapore/IFNIMH-16-0019/2016/H3N2",
                       "A/HongKong/4801/2014/H3N2",
                       "A/Wisconsin/588/2019/H1N1",
                       "A/Brisbane/02/2018/H1N1",
                       "A/Equine/Prague/56 (H7) +A/Calfornia/07/2019 (N1)",
                       "A/Turkey/Massachusettes/3740/1965 (H6) + A/Texas/50/2012 (N2)",
                       "A/Turkey/Massachusettes/3740/1965 (H6) + B/Yamagata/16/1988 (NB)"
                     #, "N2", "N1", "B/NB", "NB"
                       ),
               Canonical=c("A/Brisbane/2/2018 (H1N1)",
                           "A/California/7/2019 (H1N1)",
                           "A/California/7/2019 (H1N1)",
                           "B/Washington/2/2019", "B/Washington/2/2019", "B/Washington/2/2019",
                           "A/Darwin/9/2021 (H3N2)", "A/Hong Kong/4801/2014 (H3N2)",
                           "A/Singapore/INFIMH-16-0019/2016 (H3N2)",
                           "A/Victoria/2570/2019 (H1N1)",
                           "A/Tasmania/503/2020 (H3N2)",
                           "A/California/7/2019 (H1N1)",
                           "A/Singapore/INFIMH-16-0019/2016 (H3N2)",
                           "A/Hong Kong/4801/2014 (H3N2)",
                           "A/Wisconsin/588/2019 (H1N1)",
                           "A/Brisbane/2/2018 (H1N1)",
                           "A/Equine/Prague/1/1956 (H7N7) + A/California/7/2019 (H1N1)",
                           "A/Turkey/Massachusetts/3740/1965 (H6N2) + A/Texas/50/2012 (H2N2)",
                           "A/Turkey/Massachusetts/3740/1965 (H6N2) + B/Yamagata/16/1988 (NB)"
                         #, "A/H6N2", "A/H7N1", "B/H6NB", "B/H6NB"
                           )
               )

## Check that 'Canonical' strains are actually 'KnownStrains'
stopifnot(AliasStrains$Canonical %in% KnownStrains)

## Strains present in Vaccine
## Note: QIV3 has half of subject with these and the other half with the following year's vax
VaxStrains <- data.frame(Strain=c("A/Tasmania/503/2020 (H3N2)", "A/Victoria/2570/2019 (H1N1)",
                                  "B/Phuket/3073/2013", "B/Washington/2/2019"),
                         ShortName=c("A/Tasmania", "A/Victoria",
                                     "B/Phuket", "B/Washington")
                         )
stopifnot(VaxStrains$Strain %in% KnownStrains)

## Lookup table to translate to-and-from Excel column names.
## That is: A, B, C, ... Z, AA, AB, AC, ... AZ, BA, ... ZZ ==> 1:702.
## Or, ExcelColumns[1] == 'A', ExcelColumns[27] == 'AA', etc.
ExcelColumns <- c(LETTERS, t(outer(LETTERS, LETTERS, paste0)))

##======================================================================
## Experiment with Colors and Symbols for display in a uniform manner
## Use these by full R name, e.g. and even if the actual colors change
## then re-running your plots will adjust the colors automatically.
## These could be used by name: e.g. Plts$India$QIV2$Resp$col for the
## color of a Responder from the India QIV2 trial.
##
## This is a stawman. I started with "India=Orange" and "Europe=Blue".
## Then I tried different shades of each for the QIV1, 2, and 3
## trials.  Finally, I altered the symbol to be a '+' for a responder
## and a 'o' for a non-responder.
##
## Examine the R defaults with:
##     plot(1:10, 1:10, pch=1:10, col=1:10)
## Examine the current color scheme in 'Plts' using the function below:
##    showColorScheme()
if( exists("Plts")) nameCollisionError("Plts")
Plts <- list(
    India=list(
        QIV1=list(
            Resp= list(col='orange4', pch=3),
            NResp=list(col='orange4', pch=1)
        ),
        QIV2=list(
            Resp= list(col='orange1', pch=3),
            NResp=list(col='orange1', pch=1)
        ),
        QIV3=list(
            Resp= list(col='OrangeRed1', pch=3),
            NResp=list(col='OrangeRed1', pch=1)
        )
    ),
    EU=list(
        QIV1=list(
            Resp= list(col='blue2', pch=3),
            NResp=list(col='blue2', pch=1)
        ),
        QIV2=list(
            Resp= list(col='DodgerBlue2', pch=3),
            NResp=list(col='DodgerBlue2', pch=1)
        ),
        QIV3=list(
            Resp= list(col='SlateBlue1', pch=3),
            NResp=list(col='SlateBlue1', pch=1)
        )
    )
)

## Run this function under R to see the colors and symbols for the 12
## classes known about in 'Plts', above.
if( exists("showColorScheme")) nameCollisionError("showColorScheme")
showColorScheme <- function() {
    ## There are twelve groups to show
    ## Include several points, say ~50 per category
    nr <- 50  # Number of rows
    nc <- 12  # Number of columns
    m <- matrix(rnorm(nr*nc, mean=0, sd=1), nrow=nr, ncol=nc)
    addM <- matrix(rep(0:11, each=nr), nrow=nr, ncol=nc) / 2
    m <- m + addM

    ## Collect color and pch info in matric format to match 'm'
    colCnt <- 1
    pchM <- matrix(1, nrow=nr, ncol=nc)
    colM <- matrix("", nrow=nr, ncol=nc)
    nm <- NULL
    for(cnt in c('India', 'EU')) {
        for(trial in paste0('QIV', 1:3)) {
            for(resp in c('Resp', 'NResp')) {
                pchM[, colCnt] <- Plts[[cnt]][[trial]][[resp]][['pch']]
                colM[, colCnt] <- Plts[[cnt]][[trial]][[resp]][['col']]
                nm[colCnt] <- paste(resp, trial, cnt, sep='-')
                colCnt <- colCnt + 1
            }
        }
    }

    ## Run the actual plot
    oldPar <- par(mar=c(10, 4, 4, 2)+0.1)
    plot(jitter(rep(1:nc, each=nr)), c(m),
         pch=c(pchM), col=c(colM),
         xaxt='n', xlab='',
         ylab='Value', main='Colors for various classes')
    axis(side=1, at=1:nc, label=nm, cex=0.8, las=2)
}

##**********************************************************************
## End Of File
