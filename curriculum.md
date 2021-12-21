# Learning outcomes

By the end of this course, students will be able to...

## Setup

- install Rstudio and other data science packages (e-setup00-install)
- load packages to access useful functions (e-setup01-packages)
- access documentation to use R functions (e-setup02-functions)
- access vignettes to learn new functions (e-setup03-docs)
- use Rstudio shortcuts to improve productivity (e-setup04-rstudio-shortcuts)

## Data

- Isolate
  - data using `filter` (e-data01-isolate)
  - variables using `select` (e-data01-isolate)
- Recognize
  - basic data objects: vectors, types (e-setup05-vectors, e-setup06-types)
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
  - data from an Excel sheet (e-data09-readxl)
  - data from googlesheets (e-data12-simple-pipeline)
- Wrangle
  - data from a messy source (e-data09-readxl, e-data13-cleaning)
  - strings with stringr (e-data06-strings)
  - complex code into readable, functional pipelines (e-data07-placeholders)
  - loops into functional calls using purrr (e-data10-map)
  - factors with forcats (e-data11-factors)
- Liberate
  - data from images with WebPlotDigitizer (e-data14-webplotdigitizer)
  - data from printed tables with Tabula (e-data15-tabula)

## Visualization

- State and use the basic components of the *grammar of graphics*:
  - geometry (many!)
  - aesthetics (e-vis00-basics)
  - theme (e-vis06-themes)
  - layers (e-vis04-scatterplot)
- Create
  - bar charts (e-vis01-bar-charts)
  - histograms (e-vis02-histograms)
  - boxplots (e-vis03-boxplots)
  - scatterplots (e-vis04-scatterplot)
  - line plots (e-vis05-lines)
  - small multiple plots (e-vis06-multiples)
  - tweaks to visual aesthetics (e-vis06-themes)
- Design
  - EDA-quality graphics (many!)
  - presentation-ready graphics (e-vis06-themes, e-comm01-story-basics)
  - comparisons using small multiples (e-vis08-multiples)
  - improved visuals through an iterative approach (e-vis09-improve)
- Criticize
  - data visualizations based on *the visual hierarchy* (e-vis07-perception)

## Statistical Literacy

- Distinguish
  - between error and uncertainty (c02-michelson, e-stat07-error-bias)
  - between populations and samples (e-stat04-population)
- Describe
  - a random quantity with a distribution (e-stat01-distributions)
  - a dataset with descriptive statistics (e-stat03-descriptive, e-stat05-moment)
  - a future outcome using a fitted model (e-stat11-ci-pi)
  - the benefits of randomization for data collection (e-stat12-randomization)
- Apply
  - the principles of curiosity and skepticism to perform EDA (e-stat00-eda-basics)
- Quantify
  - an approximate probability with Monte Carlo (e-stat02-probability)
  - the degree of uncertainty in an estimate (e-stat06-clt, e-stat09-bootstrap)
  - the degree of uncertainty in a prediction (e-stat11-ci-pi)
- Fit
  - a distribution (e-stat08-fit-dist)
- Question
  - whether observed variability is real or induced (e-model00-source)
  - whether a given degree of certainty is sufficient to make a decision (e-stat10-hyp-intro)
  - whether a model is overfit to a given dataset (e-model02-train-validate)
  - whether a model interpretation is real or spurious (e-model03-interp-warnings)
  <!-- - whether a given numerical result relates to a qualitative conclusion -->
  <!-- - whether a given study has sufficient relevance to a given question -->

## Statistical Modeling

- Fit
  - a linear model (e-model01-intro)
  - a logistic regression classifier (e-model04-logistic)
- Assess
  - whether a model is flexible enough to fit a given dataset (e-model02-train-validate)
  - a linear model for interpretability (e-model03-interp-warnings)
  - the accuracy of a classifier (e-model05-roc)
- Select
  - features based on an appropriate error estimate (e-stat02-model-train-validate)
  - hyperparameters based on an appropriate error estimate (e-stat02-model-train-validate)

## Communication

- write easily-readable code by following a styleguide (e-comm00-style)
- use [active and constructive responding](https://gostrengths.com/what-is-active-and-constructive-responding/) to encourage cordial discussion (e-comm01-responding)
- tell a story using the ABT framework (e-comm02-story-basics)

## Reproducibility

- use Git for basic version control (e-rep01-intro-git, e-rep03-track)
- create a GitHub repository (e-rep02-create)
- structure a project directory (e-rep04-directories)
