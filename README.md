# INCENTIVE Assays: Controlled Vocabulary

## Introduction

Every lab uses different shorthand names for labeling assays.  For
example, one lab may call a virus strain, _A/Tasmania_, and another may
call it, _A/Tasmania/503/2020/H3N2_. The WHO has a standard for naming
influenza virus strains and would call this _A/Tasmania/503/2020\ (H3N2)_.
By translating all of the laboratory shorthand names to the
WHO form, I make the data more comparable across labs.

The scientists have supplied me with Excel files, which summarize
their results. My process is to parse those Excel files from their
[Wide Format to a Long Format](https://www.statology.org/long-vs-wide-data/)
CSV file with a controlled
vocabulary. Most computational scientists using these data would want
to view the scientists' Excel files to understand their work, and then
would want to use my CSV files for performing their own analyses.

## Which items are controlled?

Several items commonly found in these assays are controlled (for
version 1.5 of the vocabulary):

* **TrialNames** := QIV1, QIV2, QIV3, None
* **AssayNames** := HI, HI-Responder, MN, MN-Plasma, ELLA, ELISA,
                  ADCD, ADCP, FcɣR2A, FcɣR2B,
                  FcɣR3A, FcɣR3B, SpecAb, SolFact
* **SampleTypes** := Samp, Stnd, Blank, Empty, Ctrl, Pctrl, Nctrl, None
* **VisitDay** := D000, D003, D003-8, D028, D030, D058, D180, D365
* **KnownStrains** := A/Brisbane/2/2018 (H1N1), A/Brisbane/57/2007
  (H1N1), A/California/4/2009 (H1N1), ... a long list

While some of these items are obvious, such as **TrialNames**, others
need some explanation.  The **AssayNames** are sometimes directly from
the scientists and, in a few cases where the scientists use long
names, made up by me. I do define the meanings within the vocabulary
file. The **SampleTypes** represent the types of samples present in a
micro-titer plate: _Samples_, _Standards_, _Blanks_, _Empty-Well_,
_Control_, _Positive-Control_, _Negative-Control_, and _None_. The
**VisitDay** names seem a bit long-winded when _D0_ seems adequate,
however, these names sort in lexical order, which can be very useful.
Finally, the **KnownStrains** contains a list of influenza strains
used in these assays, spelled out in WHO canonical format.  In some
cases, there are pairs of strains (again in canonical format) joined
with a `+`. See the comments in the file.

There are several other sections for the controlled vocabulary,
including a set of proposed colors for different subsets of the data,
e.g. EU vs Indian samples, etc. There are also **SubAssayNames**,
**ColumnNames** (defines columns in the CSV files), and **VaxStrains**
(strains used in the vaccine).

## How to use the controlled vocabulary?

The file containing the controlled vocabulary is written in R and
expected to be loaded via `source("Controlled-Vocab.R")` just after
the libraries are loaded at the start of the script. In my own work,
I used a sub-directory for each dataset and parser, with a link to my
single copy of the controlled vocabulary.

I have included some tests in the code to ensure that I don't clobber
existing variables; this was for my benefit as I incorporated the
vocabulary at a late date into existing programs. This inconveniences
me as it means that I need to use an additional clean-up step before
using `source()` again.

```R
rm(list=ls())
source('Controlled-Vocab.R')
```
A quick fix to disable this might be to
redefine the function, `nameCollisionError()`, as a no-op.

### For non-R users, just read the file

Despite writing this file in R, I have worked to ensure that it is
readable to non-programmers as well. For example, to know the
canonical name for a virus strain, scan down the file until you find
the string `KnownStrains` and then look at the strains listed there,
one per line. And they're in alphabetical order too.

# Errors and Corrections

I intended this vocabulary to be complete and correct. If I misspelled
something, or missed controlling a word or concept, please let me know
and I'll update the file. At this time, many of my CSV-conversion
programs source this file directly so major changes to data structures
would be hard but other aspects should be fine.

## Contact

Please send updates to:

Mark Dalphin, mdalphin@immunomeproject.org
