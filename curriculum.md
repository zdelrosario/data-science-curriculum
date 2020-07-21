# Learning outcomes
**Core** outcomes are topics I will adjust the course to ensure we cover.
**Bonus** topics are those I will cover if we have bonus time.

By the end of this course, students will be able to...

## (Setup)

Core
- install Rstudio and other data science packages (e-setup00-install)
- load packages to access useful functions (e-setup01-packages)
- access documentation to use R functions (e-setup02-functions)
- access vignettes to learn new functions (e-setup03-docs)
- use Rstudio shortcuts to improve productivity (e-setup04-rstudio-shortcuts)

## (Data)

Core
- Recognize
  - basic data objects: vectors, types (e-setup05-vectors, e-setup06-types)
- Isolate
  - data using `filter` (e-data01-isolate)
  - variables using `select` (e-data01-isolate)
- Derive
  - new variables with `mutate` (e-data02-derive)
  - summaries with `group_by` and `summarize` (e-data02-derive)
  - string matches with regular expressions (e-data06-strings)
  - positional and ranking relations with window functions (e-data08-window)
- Tidy
  - by reshaping with `pivot_longer` and `pivot_wider` (e-data03-pivot)
  - by `separate` and `unite` of columns (e-data04-separate-unite)
  - by `join` of multiple tables (e-data05-join)
- Load
  - data from a flat file, e.g. a comma-separated value (csv) file (e-data00-basics)
  - data from googlesheets
- Wrangle
  - data from a messy source, e.g. a nasty excel file (e-data09-readxl)
  - loops into functional calls using purrr (e-data10-map)
- Liberate
  - data from images with WebPlotDigitizer
  - data from printed tables with Tabula

Bonus
- Specialty
  - (lubridate)
  - (forcats)

## (Visualization)

Core
- State the basic components of the *grammar of graphics*: geometry, aesthetics,
  theme, layers
- Create
  - bar charts (e-vis01-bar-charts)
  - histograms (e-vis02-histograms)
  - boxplots (e-vis03-boxplots)
  - scatterplots (e-vis04-scatterplot)
  - line plots (e-vis05-lines)
  - small multiple plots (e-vis06-multiples)
  - tweaks to visual aesthetics (e-vis07-themes)
- Design
  - EDA-quality graphics (many)
  - presentation-ready graphics (e-vis07-themes, e-comm01-story-basics)
- Criticize
  - data visualizations based on *the visual hierarchy*
  - data visualizations based on their intended audience

Bonus
- (Geospatial with sf)
- (Shiny apps)
- (Leaflet maps)

## (Statistical Literacy)

Core
- Distinguish
  - between error and uncertainty (c02-michelson, e-stat07-error-bias)
  - between variability and uncertainty
  - between populations and samples (e-stat04-population)
- Describe
  - a random quantity with a distribution (e-stat01-distributions)
  - a dataset with descriptive statistics (e-stat03-descriptive, e-stat05-moment)
  - the relationship between variables using a model
  - a future outcome using a fitted model
- Apply
  - the principles of curiosity and skepticism to perform EDA (e-stat00-eda-basics)
- Quantify
  - an approximate probability with Monte Carlo (e-stat02-probability)
  - the degree of uncertainty in an estimate (e-stat06-clt, e-stat09-bootstrap)
  - the degree of uncertainty in a prediction
  - testing and training error (e.g. via cross-validation)
- Fit
  - a distribution (e-stat08-fit-dist)
  - a linear model
- Question
  - whether a given numerical result relates to a qualitative conclusion
  - whether a given degree of certainty is sufficient to make a decision
  - whether a given study has sufficient relevance to a given question
  - whether a model is flexible enough to fit a given dataset

Bonus
- Fit
  - a gaussian process
  - a random forest
- Select
  - features based on an appropriate error estimate
  - hyperparameters based on an appropriate error estimate

## (Communication)
- write easily-readable code by following a styleguide (e-comm00-style)
- tell a story using the ABT framework (e-comm01-story-basics)
- judge a data story using the ABT framework
- use GitHub to discuss and improve reports

## (Reproducibility)

Core
- (Git)
- (Command line)
- (File hygiene)
- (Directory structuring)
