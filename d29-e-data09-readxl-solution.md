
# Data: Reading Excel Sheets

*Purpose*: The Tidyverse is built to work with tidy data. Unfortunately, most data in the wild are not tidy. The good news is that we have a lot of tools for *wrangling* data into tidy form. The bad news is that "every untidy dataset is untidy in its own way." I can't show you you every crazy way people decide to store their data. But I can walk you through a worked example to show some common techniques.

In this case study, I'll take you through the process of *wrangling* a messy Excel spreadsheet into machine-readable form. You will both learn some general tools for wrangling data, and you can keep this notebook as a *recipe* for future messy datasets of similar form.

*Reading*: (None)




``` r
library(tidyverse)
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.5
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
## ✔ purrr     1.0.4     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

``` r
library(readxl) # For reading Excel sheets
library(httr) # For downloading files

## Use my tidy-exercises copy of UNDOC data for stability
url_undoc <- "https://github.com/zdelrosario/tidy-exercises/blob/master/2019/2019-12-10-news-plots/GSH2013_Homicide_count_and_rate.xlsx?raw=true"
filename <- "./data/undoc.xlsx"
```

I keep a copy of the example data in a personal repo; download a local copy.


``` r
## NOTE: No need to edit
curl::curl_download(
        url_undoc,
        filename
      )
```

## Wrangling Basics
<!-- ------------------------- -->

### __q1__ Run the following code and pay attention to the column names. Open the downloaded Excel sheet and compare. Why are the column names so weird?


``` r
## NOTE: No need to edit; run and inspect
df_q1 <- read_excel(filename)
```

```
## New names:
## • `` -> `...2`
## • `` -> `...3`
## • `` -> `...4`
## • `` -> `...5`
## • `` -> `...6`
## • `` -> `...7`
## • `` -> `...8`
## • `` -> `...9`
## • `` -> `...10`
## • `` -> `...11`
## • `` -> `...12`
## • `` -> `...13`
## • `` -> `...14`
## • `` -> `...15`
## • `` -> `...16`
## • `` -> `...17`
## • `` -> `...18`
## • `` -> `...19`
```

``` r
df_q1 %>% glimpse
```

```
## Rows: 447
## Columns: 19
## $ `Intentional homicide count and rate per 100,000 population, by country/territory (2000-2012)` <chr> …
## $ ...2                                                                                           <chr> …
## $ ...3                                                                                           <chr> …
## $ ...4                                                                                           <chr> …
## $ ...5                                                                                           <chr> …
## $ ...6                                                                                           <chr> …
## $ ...7                                                                                           <chr> …
## $ ...8                                                                                           <dbl> …
## $ ...9                                                                                           <dbl> …
## $ ...10                                                                                          <dbl> …
## $ ...11                                                                                          <dbl> …
## $ ...12                                                                                          <dbl> …
## $ ...13                                                                                          <dbl> …
## $ ...14                                                                                          <dbl> …
## $ ...15                                                                                          <dbl> …
## $ ...16                                                                                          <chr> …
## $ ...17                                                                                          <chr> …
## $ ...18                                                                                          <chr> …
## $ ...19                                                                                          <chr> …
```

**Observations**:

- The top row is filled with expository text. The actual column names are several rows down.

Most `read_` functions have a *skip* argument you can use to skip over the first few lines. Use this argument in the next task to deal with the top of the Excel sheet.

### __q2__ Read the Excel sheet.

Open the target Excel sheet (located at `./data/undoc.xlsx`) and find which line (row) at which the year column headers are located. Use the `skip` keyword to start your read at that line.


``` r
## TODO:
df_q2 <- read_excel(
  filename,
  skip = 6
)
```

```
## New names:
## • `` -> `...1`
## • `` -> `...2`
## • `` -> `...3`
## • `` -> `...4`
## • `` -> `...5`
## • `` -> `...6`
```

``` r
df_q2 %>% glimpse
```

```
## Rows: 444
## Columns: 19
## $ ...1   <chr> "Africa", NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
## $ ...2   <chr> "Eastern Africa", NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
## $ ...3   <chr> "Burundi", NA, "Comoros", NA, "Djibouti", NA, "Eritrea", NA, "E…
## $ ...4   <chr> "PH", NA, "PH", NA, "PH", NA, "PH", NA, "PH", NA, "CJ", NA, "PH…
## $ ...5   <chr> "WHO", NA, "WHO", NA, "WHO", NA, "WHO", NA, "WHO", NA, "CTS", N…
## $ ...6   <chr> "Rate", "Count", "Rate", "Count", "Rate", "Count", "Rate", "Cou…
## $ `2000` <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 6.2, 70…
## $ `2001` <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 7.7, 90…
## $ `2002` <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 4.8, 56…
## $ `2003` <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 2.5, 30…
## $ `2004` <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 4.0, 1395.0, NA, NA, 3.…
## $ `2005` <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 3.5, 1260.0, NA, NA, 1.…
## $ `2006` <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 3.5, 1286.0, NA, NA, 6.…
## $ `2007` <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 3.4, 1281.0, NA, NA, 5.…
## $ `2008` <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 3.6, 1413.0, NA, NA, 5.…
## $ `2009` <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "5.6", "2218", NA, NA, …
## $ `2010` <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "5.5", "2239", NA, NA, …
## $ `2011` <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "6.3", "2641", NA, NA, …
## $ `2012` <chr> "8", "790", "10", "72", "10.1", "87", "7.1", "437", "12", "1104…
```

Use the following test to check your work.


``` r
## NOTE: No need to change this
assertthat::assert_that(setequal(
              (df_q2 %>% names() %>% .[7:19]),
              as.character(seq(2000, 2012))
            ))
```

```
## [1] TRUE
```

``` r
print("Nice!")
```

```
## [1] "Nice!"
```

Let's take stock of where we are:


``` r
df_q2 %>% head()
```

```
## # A tibble: 6 × 19
##   ...1   ...2  ...3  ...4  ...5  ...6  `2000` `2001` `2002` `2003` `2004` `2005`
##   <chr>  <chr> <chr> <chr> <chr> <chr>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
## 1 Africa East… Buru… PH    WHO   Rate      NA     NA     NA     NA     NA     NA
## 2 <NA>   <NA>  <NA>  <NA>  <NA>  Count     NA     NA     NA     NA     NA     NA
## 3 <NA>   <NA>  Como… PH    WHO   Rate      NA     NA     NA     NA     NA     NA
## 4 <NA>   <NA>  <NA>  <NA>  <NA>  Count     NA     NA     NA     NA     NA     NA
## 5 <NA>   <NA>  Djib… PH    WHO   Rate      NA     NA     NA     NA     NA     NA
## 6 <NA>   <NA>  <NA>  <NA>  <NA>  Count     NA     NA     NA     NA     NA     NA
## # ℹ 7 more variables: `2006` <dbl>, `2007` <dbl>, `2008` <dbl>, `2009` <chr>,
## #   `2010` <chr>, `2011` <chr>, `2012` <chr>
```

We still have problems:

- The first few columns don't have sensible names. The `col_names` argument allows us to set manual names at the read phase.
- Some of the columns are of the wrong type; for instance `2012` is a `chr` vector. We can use the `col_types` argument to set manual column types.

### __q3__ Change the column names and types.

Use the provided names in `col_names_undoc` with the `col_names` argument to set *manual* column names. Use the `col_types` argument to set all years to `"numeric"`, and the rest to `"text"`.

*Hint 1*: Since you're providing manual `col_names`, you will have to *adjust* your `skip` value!

*Hint 2*: You can use a named vector for `col_types` to help keep type of which type is assigned to which variable, for instance `c("variable" = "type")`.


``` r
## NOTE: Use these column names
col_names_undoc <-
  c(
    "region",
    "sub_region",
    "territory",
    "source",
    "org",
    "indicator",
    "2000",
    "2001",
    "2002",
    "2003",
    "2004",
    "2005",
    "2006",
    "2007",
    "2008",
    "2009",
    "2010",
    "2011",
    "2012"
  )

## TASK: Use the arguments `skip`, `col_names`, and `col_types`
df_q3 <- read_excel(
  filename,
  sheet = 1,
  skip = 7,
  col_names = col_names_undoc,
  col_types = c(
    "region"     = "text",
    "sub_region" = "text",
    "territory"  = "text",
    "source"     = "text",
    "org"        = "text",
    "indicator"  = "text",
    "2000" = "numeric",
    "2001" = "numeric",
    "2002" = "numeric",
    "2003" = "numeric",
    "2004" = "numeric",
    "2005" = "numeric",
    "2006" = "numeric",
    "2007" = "numeric",
    "2008" = "numeric",
    "2009" = "numeric",
    "2010" = "numeric",
    "2011" = "numeric",
    "2012" = "numeric"
  )
)
```

```
## Warning: Expecting numeric in P315 / R315C16: got '2366*'
```

```
## Warning: Expecting numeric in Q315 / R315C17: got '1923*'
```

```
## Warning: Expecting numeric in R315 / R315C18: got '1866*'
```

```
## Warning: Expecting numeric in S381 / R381C19: got 'x'
```

```
## Warning: Expecting numeric in S431 / R431C19: got 'x'
```

```
## Warning: Expecting numeric in S433 / R433C19: got 'x'
```

```
## Warning: Expecting numeric in S435 / R435C19: got 'x'
```

```
## Warning: Expecting numeric in S439 / R439C19: got 'x'
```

```
## Warning: Expecting numeric in S445 / R445C19: got 'x'
```

Use the following test to check your work.


``` r
## NOTE: No need to change this
assertthat::assert_that(setequal(
              (df_q3 %>% names()),
              col_names_undoc
            ))
```

```
## [1] TRUE
```

``` r
assertthat::assert_that((df_q3 %>% slice(1) %>% pull(`2012`)) == 8)
```

```
## [1] TRUE
```

``` r
print("Great!")
```

```
## [1] "Great!"
```

## Danger Zone
<!-- ------------------------- -->

Now let's take a look at the head of the data:


``` r
df_q3 %>% head()
```

```
## # A tibble: 6 × 19
##   region sub_region territory source org   indicator `2000` `2001` `2002` `2003`
##   <chr>  <chr>      <chr>     <chr>  <chr> <chr>      <dbl>  <dbl>  <dbl>  <dbl>
## 1 Africa Eastern A… Burundi   PH     WHO   Rate          NA     NA     NA     NA
## 2 <NA>   <NA>       <NA>      <NA>   <NA>  Count         NA     NA     NA     NA
## 3 <NA>   <NA>       Comoros   PH     WHO   Rate          NA     NA     NA     NA
## 4 <NA>   <NA>       <NA>      <NA>   <NA>  Count         NA     NA     NA     NA
## 5 <NA>   <NA>       Djibouti  PH     WHO   Rate          NA     NA     NA     NA
## 6 <NA>   <NA>       <NA>      <NA>   <NA>  Count         NA     NA     NA     NA
## # ℹ 9 more variables: `2004` <dbl>, `2005` <dbl>, `2006` <dbl>, `2007` <dbl>,
## #   `2008` <dbl>, `2009` <dbl>, `2010` <dbl>, `2011` <dbl>, `2012` <dbl>
```

Irritatingly, many of the cell values are left *implicit*; as humans reading these data, we can tell that the entries in `region` under `Africa` also have the value `Africa`. However, the computer can't tell this! We need to make these values *explicit* by filling them in.

To that end, I'm going to *guide* you through some slightly advanced Tidyverse code to *lag-fill* the missing values. To that end, I'll define and demonstrate two helper functions:

First, the following function counts the number of rows with `NA` entries in a chosen set of columns:


``` r
## Helper function to count num rows w/ NA in vars_lagged
rowAny <- function(x) rowSums(x) > 0
countna <- function(df, vars_lagged) {
  df %>%
    filter(rowAny(across(vars_lagged, is.na))) %>%
    dim %>%
    .[[1]]
}

countna(df_q3, c("region"))
```

```
## Warning: There was 1 warning in `filter()`.
## ℹ In argument: `rowAny(across(vars_lagged, is.na))`.
## Caused by warning:
## ! Using an external vector in selections was deprecated in tidyselect 1.1.0.
## ℹ Please use `all_of()` or `any_of()` instead.
##   # Was:
##   data %>% select(vars_lagged)
## 
##   # Now:
##   data %>% select(all_of(vars_lagged))
## 
## See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
```

```
## [1] 435
```

Ideally we want this count to be *zero*. To fill-in values, we will use the following function to do one round of *lag-filling*:


``` r
lagfill <- function(df, vars_lagged) {
  df %>%
    mutate(across(
      vars_lagged,
      function(var) {
        if_else(
          is.na(var) & !is.na(lag(var)),
          lag(var),
          var
        )
      }
    ))
}

df_tmp <-
  df_q3 %>%
  lagfill(c("region"))

countna(df_tmp, c("region"))
```

```
## [1] 429
```

We can see that `lagfill` has filled the `Africa` value in row 2, as well as a number of other rows as evidenced by the reduced value returned by `countna`.

What we'll do is continually run `lagfill` until we reduce `countna` to zero. We could do this by repeatedly running the function *manually*, but that would be silly. Instead, we'll run a `while` loop to automatically run the function until `countna` reaches zero.

### __q4__ I have already provided the `while` loop below; fill in `vars_lagged` with the names of the columns where cell values are *implicit*.

*Hint*: Think about which columns have implicit values, and which truly have missing values.


``` r
## Choose variables to lag-fill
vars_lagged <- c("region", "sub_region", "territory", "source", "org")

## NOTE: No need to edit this
## Trim head and notes
df_q4 <-
  df_q3 %>%
  slice(-(n()-5:-n()))

## Repeatedly lag-fill until NA's are gone
while (countna(df_q4, vars_lagged) > 0) {
  df_q4 <-
    df_q4 %>%
    lagfill(vars_lagged)
}
```

And we're done! All of the particularly tricky wrangling is now done. You could now use pivoting to tidy the data into long form.

<!-- include-exit-ticket -->
