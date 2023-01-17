
# Data: A Simple Data Pipeline

*Purpose*: Analyzing existing data is helpful, but it's even more important to be able to *obtain relevant data*. One kind of data is survey data, which is helpful for understanding things about people. In this short exercise you'll learn how to set up your own survey, link it to a cloud-based sheet, and automatically download that sheet for local data analysis.

*Reading*: (None, this exercise *is* the reading)


```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✔ ggplot2 3.4.0      ✔ purrr   1.0.1 
## ✔ tibble  3.1.8      ✔ dplyr   1.0.10
## ✔ tidyr   1.2.1      ✔ stringr 1.5.0 
## ✔ readr   2.1.3      ✔ forcats 0.5.2
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

```r
library(googlesheets4)
```

## Reading a Sheet with `googlesheets4`

The [googlesheets4](https://googlesheets4.tidyverse.org/) package provides a convenient interface to Google Sheet's API [1]. We'll use this to set up a *very simple* data pipeline: A means to collect data at some user-facing point, and load that data for analysis.

## Public sheets

Back in c02-michelson you actually used googlesheets4 to load the speed of light data:


```r
## Note: No need to edit this chunk!
url_michelson <- "https://docs.google.com/spreadsheets/d/1av_SXn4j0-4Rk0mQFik3LLr-uf0YdA06i3ugE6n-Zdo/edit?usp=sharing"

## Put googlesheets4 in "deauthorized mode"
gs4_deauth()
## Get sheet metadata
ss_michelson <- gs4_get(url_michelson)
## Load the sheet as a dataframe
df_michelson <-
  read_sheet(ss_michelson) %>%
  select(Date, Distinctness, Temp, Velocity) %>%
  mutate(Distinctness = as_factor(Distinctness))
```

```
## ✔ Reading from "michelson1879".
```

```
## ✔ Range 'Sheet1'.
```

```r
df_michelson %>% glimpse
```

```
## Rows: 100
## Columns: 4
## $ Date         <dttm> 1879-06-05, 1879-06-07, 1879-06-07, 1879-06-07, 1879-06-…
## $ Distinctness <fct> 3, 2, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2, 2, 2, 2, 1, 3, 3, 2, …
## $ Temp         <dbl> 76, 72, 72, 72, 72, 72, 83, 83, 83, 83, 83, 90, 90, 71, 7…
## $ Velocity     <dbl> 299850, 299740, 299900, 300070, 299930, 299850, 299950, 2…
```

I made this sheet public so that anyone can access it. The line `gs4_deauth()` tells the googlesheets4 package not to ask for login information; this way you can easily load this public sheet, even without having a Google account.

But what if we want to load one of our own *private* data sheets?

## Private sheets

In order to load a private data sheet, you'll need to *authorize* googlesheets4 to use your Google account. The following line should open a browser window that will ask for your permissions.


```r
## NOTE: No need to edit; run to authorize R to use your google account
gs4_auth()
```

Now that you've authorized your account, let's create a very simple data-collection pipeline.

## Setting up a Form + Sheet

One convenient feature of Google Sheets is that it nicely integrates with Google Forms: We can create a form (a survey) and link it to a sheet. Let's do that!

### __q1__ Create your own form.

Go to [Google Forms](https://www.google.com/forms/about/) and create a new form. Add at least one question.

### __q2__ Navigate to the `Responses` tab and click `Create Spreadsheet`. Select `Create a new spreadsheet` and accept the default name.

![Create spreadsheet linked to form](./images/e-data12-responses.png)

### __q3__ Copy the URL for your new sheet and copy it below. Run the following chunk to load your (probably empy) sheet.


```r
## NOTE: I'm not going to put a URL here, as one of my personal sheets
##       won't work for you....
url_custom_sheet <- ""

df_custom_sheet <- read_sheet(url_custom_sheet)
df_custom_sheet %>% glimpse()
```

Now as results from your survey come in, you can simply re-run this notebook to grab the most recent version of your data for local analysis.

This is *very simple* but *surprisingly powerful*: I use a pipeline exactly like this for the exit tickets!

<!-- include-exit-ticket -->

## Notes

[1] It's `googlesheets4` because the package is designed for V4 of Google Sheet's API.
