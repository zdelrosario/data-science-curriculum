
# Data: Cleaning

*Purpose*: Most of the data you'll find in the wild is *messy*; you'll need to clean those data before you can do useful work. In this case study, you'll learn some more tricks for cleaning data. We'll use these data for a future exercise on modeling, so we'll build on the work you do here today.

*Reading*: (*None*, this exercise *is* the reading.)


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

*Background*: This exercise's data comes from the UCI Machine Learning Database; specifically their [Heart Disease Data Set](https://archive.ics.uci.edu/ml/datasets/Heart+Disease). These data consist of clinical measurements on patients, and are intended to help predict heart disease.


``` r
## NOTE: No need to edit; run and inspect
url_disease <- "http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data"
filename_disease <- "./data/uci_heart_disease.csv"

## Download the data locally
curl::curl_download(
        url_disease,
        destfile = filename_disease
      )
```

This is a *messy* dataset; one we'll have to clean if we want to make sense of it. Let's load the data and document the ways in which it's messy:


``` r
## NOTE: No need to edit; run and inspect
read_csv(filename_disease) %>% glimpse()
```

```
## New names:
## Rows: 302 Columns: 14
## ── Column specification
## ──────────────────────────────────────────────────────── Delimiter: "," chr
## (2): 0.0...12, 6.0 dbl (12): 63.0, 1.0...2, 1.0...3, 145.0, 233.0, 1.0...6,
## 2.0, 150.0, 0.0...9...
## ℹ Use `spec()` to retrieve the full column specification for this data. ℹ
## Specify the column types or set `show_col_types = FALSE` to quiet this message.
## • `1.0` -> `1.0...2`
## • `1.0` -> `1.0...3`
## • `1.0` -> `1.0...6`
## • `0.0` -> `0.0...9`
## • `0.0` -> `0.0...12`
```

```
## Rows: 302
## Columns: 14
## $ `63.0`     <dbl> 67, 67, 37, 41, 56, 62, 57, 63, 53, 57, 56, 56, 44, 52, 57,…
## $ `1.0...2`  <dbl> 1, 1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1,…
## $ `1.0...3`  <dbl> 4, 4, 3, 2, 2, 4, 4, 4, 4, 4, 2, 3, 2, 3, 3, 2, 4, 3, 2, 1,…
## $ `145.0`    <dbl> 160, 120, 130, 130, 120, 140, 120, 130, 140, 140, 140, 130,…
## $ `233.0`    <dbl> 286, 229, 250, 204, 236, 268, 354, 254, 203, 192, 294, 256,…
## $ `1.0...6`  <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0,…
## $ `2.0`      <dbl> 2, 2, 0, 2, 0, 2, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2,…
## $ `150.0`    <dbl> 108, 129, 187, 172, 178, 160, 163, 147, 155, 148, 153, 142,…
## $ `0.0...9`  <dbl> 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1,…
## $ `2.3`      <dbl> 1.5, 2.6, 3.5, 1.4, 0.8, 3.6, 0.6, 1.4, 3.1, 0.4, 1.3, 0.6,…
## $ `3.0`      <dbl> 2, 2, 3, 1, 1, 3, 1, 2, 3, 2, 2, 2, 1, 1, 1, 3, 1, 1, 1, 2,…
## $ `0.0...12` <chr> "3.0", "2.0", "0.0", "0.0", "0.0", "2.0", "0.0", "1.0", "0.…
## $ `6.0`      <chr> "3.0", "7.0", "3.0", "3.0", "3.0", "3.0", "3.0", "7.0", "7.…
## $ `0`        <dbl> 2, 1, 0, 0, 0, 3, 0, 2, 1, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0,…
```

*Observations*:

- The CSV comes without column names! `read_csv()` got confused and assigned the first row of data as names.
- Some of the numerical columns were incorrectly assigned `character` type.
- Some of the columns are coded as binary values `0, 1`, but they really represent variables like `sex %in% c("male", "female")`.

Let's tackle these problems one at a time:

## Problem 1: No column names

We'll have a hard time making sense of these data without column names. Let's fix that.

### __q1__ Obtain the data.

Following the [dataset documentation](https://archive.ics.uci.edu/ml/datasets/Heart+Disease), transcribe the correct column names and assign them as a character vector. You will use this to give the dataset sensible column names when you load it in q2.

*Hint 1*: The relevant section from the dataset documentation is quoted here:

> Only 14 attributes used:
> 1. #3 (age)
> 2. #4 (sex)
> 3. #9 (cp)
> 4. #10 (trestbps)
> 5. #12 (chol)
> 6. #16 (fbs)
> 7. #19 (restecg)
> 8. #32 (thalach)
> 9. #38 (exang)
> 10. #40 (oldpeak)
> 11. #41 (slope)
> 12. #44 (ca)
> 13. #51 (thal)
> 14. #58 (num) (the predicted attribute)

*Hint 2*: A "copy-paste-edit" is probably the most effective approach here!


``` r
## TODO: Assign the column names to col_names; make sure they are strings
col_names <- c(
  "age",
  "sex",
  "cp",
  "trestbps",
  "chol",
  "fbs",
  "restecg",
  "thalach",
  "exang",
  "oldpeak",
  "slope",
  "ca",
  "thal",
  "num"
)
```

Use the following to check your code.


``` r
## NOTE: No need to change this
assertthat::assert_that(col_names[1] == "age")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[2] == "sex")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[3] == "cp")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[4] == "trestbps")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[5] == "chol")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[6] == "fbs")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[7] == "restecg")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[8] == "thalach")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[9] == "exang")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[10] == "oldpeak")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[11] == "slope")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[12] == "ca")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[13] == "thal")
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(col_names[14] == "num")
```

```
## [1] TRUE
```

``` r
print("Well done!")
```

```
## [1] "Well done!"
```

## Problem 2: Incorrect types

We saw above that `read_csv()` incorrectly guessed some of the column types. Let's fix that by manually specifying each column's type.

### __q2__ Call `read_csv()` with the `col_names` and `col_types` arguments. Use the column names you assigned above, and set all column types to `col_number()`.

*Hint*: Remember that you can always read the documentation to learn how to use a new argument!


``` r
## TODO: Use the col_names and col_types arguments to give the data the
##       correct column names, and to set their types to col_number()
df_q2 <-
  read_csv(
    filename_disease,
    col_names = col_names,
    col_types = cols(
      "age" = col_number(),
      "sex" = col_number(),
      "cp" = col_number(),
      "trestbps" = col_number(),
      "chol" = col_number(),
      "fbs" = col_number(),
      "restecg" = col_number(),
      "thalach" = col_number(),
      "exang" = col_number(),
      "oldpeak" = col_number(),
      "slope" = col_number(),
      "ca" = col_number(),
      "thal" = col_number(),
      "num" = col_number()
    )
  )
```

```
## Warning: One or more parsing issues, call `problems()` on your data frame for details,
## e.g.:
##   dat <- vroom(...)
##   problems(dat)
```

``` r
df_q2 %>% glimpse()
```

```
## Rows: 303
## Columns: 14
## $ age      <dbl> 63, 67, 67, 37, 41, 56, 62, 57, 63, 53, 57, 56, 56, 44, 52, 5…
## $ sex      <dbl> 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1…
## $ cp       <dbl> 1, 4, 4, 3, 2, 2, 4, 4, 4, 4, 4, 2, 3, 2, 3, 3, 2, 4, 3, 2, 1…
## $ trestbps <dbl> 145, 160, 120, 130, 130, 120, 140, 120, 130, 140, 140, 140, 1…
## $ chol     <dbl> 233, 286, 229, 250, 204, 236, 268, 354, 254, 203, 192, 294, 2…
## $ fbs      <dbl> 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0…
## $ restecg  <dbl> 2, 2, 2, 0, 2, 0, 2, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2…
## $ thalach  <dbl> 150, 108, 129, 187, 172, 178, 160, 163, 147, 155, 148, 153, 1…
## $ exang    <dbl> 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1…
## $ oldpeak  <dbl> 2.3, 1.5, 2.6, 3.5, 1.4, 0.8, 3.6, 0.6, 1.4, 3.1, 0.4, 1.3, 0…
## $ slope    <dbl> 3, 2, 2, 3, 1, 1, 3, 1, 2, 3, 2, 2, 2, 1, 1, 1, 3, 1, 1, 1, 2…
## $ ca       <dbl> 0, 3, 2, 0, 0, 0, 2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0…
## $ thal     <dbl> 6, 3, 7, 3, 3, 3, 3, 3, 7, 7, 6, 3, 6, 7, 7, 3, 7, 3, 3, 3, 3…
## $ num      <dbl> 0, 2, 1, 0, 0, 0, 3, 0, 2, 1, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0…
```

Use the following to check your code.


``` r
## NOTE: No need to change this
assertthat::assert_that(assertthat::are_equal(names(df_q2), col_names))
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(all(map_chr(df_q2, class) == "numeric"))
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

## Problem 3: Uninformative values

The numeric codes given for some of the variables are uninformative; let's replace those with more human-readable values.

Rather than go and modify our raw data, we will instead *recode* the variables in our loaded dataset. *It is bad practice to modify your raw data!* Modifying your data in code provides *traceable documentation* for the edits you made; this is a key part of doing [reproducible science](https://www.nature.com/articles/s41562-016-0021). It takes more work, but *your results will be more trustworthy if you do things the right way!*

### __q3__ Create *conversion functions* to recode factor values as human-readable strings. I have provided one function (`convert_sex`) as an example.

*Note*: "In the wild" you would be responsible for devising your own sensible level names. However, I'm going to provide specific codes such that I can write unittests to check your answers:

| Variable  | Levels |
|-----------|--------|
| `sex`     | `1 = "male", 0 = "female"` |
| `fbs`     | `1 = TRUE, 0 = FALSE` |
| `restecg` | `0 = "normal", 1 = "ST-T wave abnormality", 2 = "Estes' criteria"` |
| `exang`   | `1 = TRUE, 0 = FALSE` |
| `slope`   | `1 = "upsloping", 2 = "flat", 3 = "downsloping"` |
| `thal`    | `3 = "normal", 6 = "fixed defect", 7 = "reversible defect"` |


``` r
## NOTE: This is an example conversion
convert_sex <- function(x) {
  case_when(
    x == 1 ~ "male",
    x == 0 ~ "female",
    TRUE ~ NA_character_
  )
}
convert_cp <- function(x) {
  case_when(
    x == 1 ~ "typical angina",
    x == 2 ~ "atypical angina",
    x == 3 ~ "non-anginal pain",
    x == 4 ~ "asymptomatic",
    TRUE ~ NA_character_
  )
}
convert_fbs <- function(x) {
  if_else(x == 1, TRUE, FALSE)
}
convert_restecv <- function(x) {
  case_when(
    x == 0 ~ "normal",
    x == 1 ~ "ST-T wave abnormality",
    x == 2 ~ "Estes' criteria",
    TRUE ~ NA_character_
  )
}
convert_exang <- function(x) {
  if_else(x == 1, TRUE, FALSE)
}
convert_slope <- function(x) {
  case_when(
    x == 1 ~ "upsloping",
    x == 2 ~ "flat",
    x == 3 ~ "downsloping",
    TRUE ~ NA_character_
  )
}
convert_thal <- function(x) {
  case_when(
    x == 3 ~ "normal",
    x == 6 ~ "fixed defect",
    x == 7 ~ "reversible defect",
    TRUE ~ NA_character_
  )
}
```

Use the following to check your code.


``` r
## NOTE: No need to change this
assertthat::assert_that(assertthat::are_equal(
  convert_cp(c(1, 2, 3, 4)),
  c("typical angina", "atypical angina", "non-anginal pain", "asymptomatic")
))
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(assertthat::are_equal(
  convert_fbs(c(1, 0)),
  c(TRUE, FALSE)
))
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(assertthat::are_equal(
  convert_restecv(c(0, 1, 2)),
  c("normal", "ST-T wave abnormality", "Estes' criteria")
))
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(assertthat::are_equal(
  convert_exang(c(1, 0)),
  c(TRUE, FALSE)
))
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(assertthat::are_equal(
  convert_slope(c(1, 2, 3)),
  c("upsloping", "flat", "downsloping")
))
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(assertthat::are_equal(
  convert_thal(c(3, 6, 7)),
  c("normal", "fixed defect", "reversible defect")
))
```

```
## [1] TRUE
```

``` r
print("Excellent!")
```

```
## [1] "Excellent!"
```

### __q4__ Use your `convert_` functions from q3 to mutate the columns and recode the variables.


``` r
df_q4 <-
  df_q2 %>%
  mutate(
    sex = convert_sex(sex),
    cp = convert_cp(cp),
    fbs = convert_fbs(fbs),
    restecg = convert_restecv(restecg),
    exang = convert_exang(exang),
    slope = convert_slope(slope),
    thal = convert_thal(thal)
  )
df_q4
```

```
## # A tibble: 303 × 14
##      age sex    cp      trestbps  chol fbs   restecg thalach exang oldpeak slope
##    <dbl> <chr>  <chr>      <dbl> <dbl> <lgl> <chr>     <dbl> <lgl>   <dbl> <chr>
##  1    63 male   typica…      145   233 TRUE  Estes'…     150 FALSE     2.3 down…
##  2    67 male   asympt…      160   286 FALSE Estes'…     108 TRUE      1.5 flat 
##  3    67 male   asympt…      120   229 FALSE Estes'…     129 TRUE      2.6 flat 
##  4    37 male   non-an…      130   250 FALSE normal      187 FALSE     3.5 down…
##  5    41 female atypic…      130   204 FALSE Estes'…     172 FALSE     1.4 upsl…
##  6    56 male   atypic…      120   236 FALSE normal      178 FALSE     0.8 upsl…
##  7    62 female asympt…      140   268 FALSE Estes'…     160 FALSE     3.6 down…
##  8    57 female asympt…      120   354 FALSE normal      163 TRUE      0.6 upsl…
##  9    63 male   asympt…      130   254 FALSE Estes'…     147 FALSE     1.4 flat 
## 10    53 male   asympt…      140   203 TRUE  Estes'…     155 TRUE      3.1 down…
## # ℹ 293 more rows
## # ℹ 3 more variables: ca <dbl>, thal <chr>, num <dbl>
```

## Prepare the Data for Modeling

Now we have a clean dataset we can use for EDA and modeling---great! Before we finish this exercise, let's do some standard checks to understand these data:

### __q5__ Perform your *first checks* on `df_q4`. Answer the questions below.

*Hint*: You may need to do some "deeper checks" to answer some of the questions below.


``` r
df_q4 %>% summary()
```

```
##       age            sex                 cp               trestbps    
##  Min.   :29.00   Length:303         Length:303         Min.   : 94.0  
##  1st Qu.:48.00   Class :character   Class :character   1st Qu.:120.0  
##  Median :56.00   Mode  :character   Mode  :character   Median :130.0  
##  Mean   :54.44                                         Mean   :131.7  
##  3rd Qu.:61.00                                         3rd Qu.:140.0  
##  Max.   :77.00                                         Max.   :200.0  
##                                                                       
##       chol          fbs            restecg             thalach     
##  Min.   :126.0   Mode :logical   Length:303         Min.   : 71.0  
##  1st Qu.:211.0   FALSE:258       Class :character   1st Qu.:133.5  
##  Median :241.0   TRUE :45        Mode  :character   Median :153.0  
##  Mean   :246.7                                      Mean   :149.6  
##  3rd Qu.:275.0                                      3rd Qu.:166.0  
##  Max.   :564.0                                      Max.   :202.0  
##                                                                    
##    exang            oldpeak        slope                 ca        
##  Mode :logical   Min.   :0.00   Length:303         Min.   :0.0000  
##  FALSE:204       1st Qu.:0.00   Class :character   1st Qu.:0.0000  
##  TRUE :99        Median :0.80   Mode  :character   Median :0.0000  
##                  Mean   :1.04                      Mean   :0.6722  
##                  3rd Qu.:1.60                      3rd Qu.:1.0000  
##                  Max.   :6.20                      Max.   :3.0000  
##                                                    NA's   :4       
##      thal                num        
##  Length:303         Min.   :0.0000  
##  Class :character   1st Qu.:0.0000  
##  Mode  :character   Median :0.0000  
##                     Mean   :0.9373  
##                     3rd Qu.:2.0000  
##                     Max.   :4.0000  
## 
```

**Observations**:

Variables:
- Numerical: `age, trestbps, chol, thalach, oldpeak, ca, num`
- Factors: `sex, cp, restecg, slope, thal, heart_disease`
- Logical: `fbs, exang, heart_disease`

Missingness:


``` r
map(
  df_q4,
  ~ sum(is.na(.))
)
```

```
## $age
## [1] 0
## 
## $sex
## [1] 0
## 
## $cp
## [1] 0
## 
## $trestbps
## [1] 0
## 
## $chol
## [1] 0
## 
## $fbs
## [1] 0
## 
## $restecg
## [1] 0
## 
## $thalach
## [1] 0
## 
## $exang
## [1] 0
## 
## $oldpeak
## [1] 0
## 
## $slope
## [1] 0
## 
## $ca
## [1] 4
## 
## $thal
## [1] 2
## 
## $num
## [1] 0
```

From this, we can see that most variables have no missing values, but `ca` has `4` and `thal` has `2`.

Missingness pattern:


``` r
df_q4 %>%
  filter(is.na(ca) | is.na(thal)) %>%
  select(ca, thal, everything())
```

```
## # A tibble: 6 × 14
##      ca thal          age sex   cp    trestbps  chol fbs   restecg thalach exang
##   <dbl> <chr>       <dbl> <chr> <chr>    <dbl> <dbl> <lgl> <chr>     <dbl> <lgl>
## 1     0 <NA>           53 fema… non-…      128   216 FALSE Estes'…     115 FALSE
## 2    NA normal         52 male  non-…      138   223 FALSE normal      169 FALSE
## 3    NA reversible…    43 male  asym…      132   247 TRUE  Estes'…     143 TRUE 
## 4     0 <NA>           52 male  asym…      128   204 TRUE  normal      156 TRUE 
## 5    NA reversible…    58 male  atyp…      125   220 FALSE normal      144 FALSE
## 6    NA normal         38 male  non-…      138   175 FALSE normal      173 FALSE
## # ℹ 3 more variables: oldpeak <dbl>, slope <chr>, num <dbl>
```

There are six rows with missing values.

If we were just doing EDA, we could stop here. However we're going to use these data for *modeling* in a future exercise. Most models can't deal with `NA` values, so we must choose how to handle rows with `NA`'s. In cases where only a few observations are missing values, we can simply *filter out* those rows.

### __q6__ Filter out the rows with missing values.


``` r
df_q6 <-
  df_q4 %>%
  filter(!is.na(ca), !is.na(thal))

df_q6
```

```
## # A tibble: 297 × 14
##      age sex    cp      trestbps  chol fbs   restecg thalach exang oldpeak slope
##    <dbl> <chr>  <chr>      <dbl> <dbl> <lgl> <chr>     <dbl> <lgl>   <dbl> <chr>
##  1    63 male   typica…      145   233 TRUE  Estes'…     150 FALSE     2.3 down…
##  2    67 male   asympt…      160   286 FALSE Estes'…     108 TRUE      1.5 flat 
##  3    67 male   asympt…      120   229 FALSE Estes'…     129 TRUE      2.6 flat 
##  4    37 male   non-an…      130   250 FALSE normal      187 FALSE     3.5 down…
##  5    41 female atypic…      130   204 FALSE Estes'…     172 FALSE     1.4 upsl…
##  6    56 male   atypic…      120   236 FALSE normal      178 FALSE     0.8 upsl…
##  7    62 female asympt…      140   268 FALSE Estes'…     160 FALSE     3.6 down…
##  8    57 female asympt…      120   354 FALSE normal      163 TRUE      0.6 upsl…
##  9    63 male   asympt…      130   254 FALSE Estes'…     147 FALSE     1.4 flat 
## 10    53 male   asympt…      140   203 TRUE  Estes'…     155 TRUE      3.1 down…
## # ℹ 287 more rows
## # ℹ 3 more variables: ca <dbl>, thal <chr>, num <dbl>
```

Use the following to check your code.


``` r
## NOTE: No need to change this
assertthat::assert_that(
  dim(
    df_q6 %>%
      filter(rowSums(across(everything(), is.na)) > 0)
  )[1] == 0
)
```

```
## [1] TRUE
```

``` r
print("Well done!")
```

```
## [1] "Well done!"
```

## In summary

- We cleaned the dataset by giving it sensible names and recoding factors with human-readable values.
- We filtered out rows with missing values (`NA`'s) *because we intend to use these data for modeling*.

<!-- include-exit-ticket -->
