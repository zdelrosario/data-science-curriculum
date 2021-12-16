
# Data: Pivoting Data

*Purpose*: Data is easiest to use when it is *tidy*. In fact, the tidyverse
(including ggplot, dplyr, etc.) is specifically designed to use tidy data. But
not all data we'll encounter is tidy! To that end, in this exercise we'll learn
how to tidy our data by *pivoting*.

As a result of learning how to quickly *tidy* data, you'll vastly expand the set
of datasets you can analyze. Rather than fighting with data, you'll be able to
quickly wrangle and extract insights.

*Reading*: [Reshape Data](https://rstudio.cloud/learn/primers/4.1)
*Topics*: Welcome, Tidy Data (skip Gathering and Spreading columns)
*Reading Time*: ~10 minutes (this exercise contains more reading material)
*Optional readings*:
- [selection language](https://tidyselect.r-lib.org/reference/language.html)

*Note*: Unfortunately, the RStudio primers have not been updated to use the most
up-to-date dplyr tools. Rather than learning the out-of-date tools `gather,
spread`, we will instead learn how to use `pivot_longer` and `pivot_wider`.




```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
```

```
## ✔ ggplot2 3.3.5     ✔ purrr   0.3.4
## ✔ tibble  3.1.2     ✔ dplyr   1.0.7
## ✔ tidyr   1.1.3     ✔ stringr 1.4.0
## ✔ readr   1.4.0     ✔ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

## Tidy Data
<!-- -------------------------------------------------- -->

Tidy data is a form of data where:

1. Each *variable* is in its own *column*
2. Each *observation* is in its own *row*
3. Each *value* is in its own *cell*

Not all data are presented in tidy form; in this case it can be difficult to
tell what the variables are. Let's practice distinguishing between the *columns*
and the *variables*.

### __q1__ What are the variables in the following dataset?


```r
## NOTE: No need to edit; execute
cases <- tribble(
  ~Country, ~`2011`, ~`2012`, ~`2013`,
      "FR",    7000,    6900,    7000,
      "DE",    5800,    6000,    6200,
      "US",   15000,   14000,   13000
)
cases
```

```
## # A tibble: 3 x 4
##   Country `2011` `2012` `2013`
##   <chr>    <dbl>  <dbl>  <dbl>
## 1 FR        7000   6900   7000
## 2 DE        5800   6000   6200
## 3 US       15000  14000  13000
```

- 1. Country, 2011, 2012, and 2013
- 2. Country, year, and some unknown quantity (n, count, etc.)
- 3. FR, DE, and US


```r
## TODO: Modify with your answer
q1_answer <- 0

## NOTE: The following will test your answer
if (((q1_answer + 56) %% 3 == 1) & (q1_answer > 0)) {
  "Correct!"
} else {
  "Incorrect!"
}
```

```
## [1] "Incorrect!"
```

### __q2__ What are the variables in the following dataset?


```r
## NOTE: No need to edit; execute
alloys <- tribble(
  ~thick, ~E_00, ~mu_00, ~E_45, ~mu_45, ~rep,
   0.022, 10600,  0.321, 10700,  0.329,    1,
   0.022, 10600,  0.323, 10500,  0.331,    2,
   0.032, 10400,  0.329, 10400,  0.318,    1,
   0.032, 10300,  0.319, 10500,  0.326,    2
)
alloys
```

```
## # A tibble: 4 x 6
##   thick  E_00 mu_00  E_45 mu_45   rep
##   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 0.022 10600 0.321 10700 0.329     1
## 2 0.022 10600 0.323 10500 0.331     2
## 3 0.032 10400 0.329 10400 0.318     1
## 4 0.032 10300 0.319 10500 0.326     2
```

- 1. thick, E_00, mu_00, E_45, mu_45, rep
- 2. thick, E, mu, rep
- 3. thick, E, mu, rep, angle


```r
## TODO: Modify with your answer
q2_answer <- 0

## NOTE: The following will test your answer
if (((q2_answer + 38) %% 3 == 2) & (q2_answer > 0)) {
  "Correct!"
} else {
  "Incorrect!"
}
```

```
## [1] "Incorrect!"
```

## Pivoting: Examples
<!-- -------------------------------------------------- -->

The dplyr package comes with tools to *pivot* our data into tidy form. There are
two key tools: `pivot_longer` and `pivot_wider`. The names are suggestive of
their use. When our data are too wide we should `pivot_longer`, and when our
data are too long, we should `pivot_wider`.

### Pivot longer
<!-- ------------------------- -->

First, let's see how `pivot_longer` works on the `cases` data. Run the following
code chunk:


```r
## NOTE: No need to edit; execute
cases %>%
  pivot_longer(
    names_to = "Year",
    values_to = "n",
    cols = c(`2011`, `2012`, `2013`)
  )
```

```
## # A tibble: 9 x 3
##   Country Year      n
##   <chr>   <chr> <dbl>
## 1 FR      2011   7000
## 2 FR      2012   6900
## 3 FR      2013   7000
## 4 DE      2011   5800
## 5 DE      2012   6000
## 6 DE      2013   6200
## 7 US      2011  15000
## 8 US      2012  14000
## 9 US      2013  13000
```

Now these data are tidy! The variable `Year` is now the name of a column, and
its values appear in the cells.

Let's break down the key inputs to `pivot_longer`:

- `names_to` is what we're going to call the new column whose values will be the original column names
- `values_to` is what we're going to call the new column that will hold the values associated with the original columns
- `cols` is the set of columns in the original dataset that we're going to modify. This takes the same inputs as a call to `select`, so we can use functions like `starts_with, ends_with, contains`, etc., or a list of column names enclosed with `c()`
  - Note that in our case, we had to enclose each column name with ticks so that dplyr does not interpret the integer values as column positions (rather than column names)
  - For more details on selecting variables, see the [selection language](https://tidyselect.r-lib.org/reference/language.html) page

However, there's a problem with the `Year` column:


```r
## NOTE: No need to edit; execute
cases %>%
  pivot_longer(
    names_to = "Year",
    values_to = "n",
    c(`2011`, `2012`, `2013`)

  ) %>%
  summarize(Year = mean(Year))
```

```
## Warning in mean.default(Year): argument is not numeric or logical: returning NA
```

```
## # A tibble: 1 x 1
##    Year
##   <dbl>
## 1    NA
```

The summary failed! That's because the `Year` column is full of strings, rather
than integers. We can fix this via mutation:


```r
## NOTE: No need to edit; execute
cases %>%
  pivot_longer(
    names_to = "Year",
    values_to = "n",
    c(`2011`, `2012`, `2013`)

  ) %>%
  mutate(Year = as.integer(Year))
```

```
## # A tibble: 9 x 3
##   Country  Year     n
##   <chr>   <int> <dbl>
## 1 FR       2011  7000
## 2 FR       2012  6900
## 3 FR       2013  7000
## 4 DE       2011  5800
## 5 DE       2012  6000
## 6 DE       2013  6200
## 7 US       2011 15000
## 8 US       2012 14000
## 9 US       2013 13000
```

Now the data are tidy and of the proper type.

Let's look at a built-in dataset:


```r
## NOTE: No need to edit; execute
ansc <-
  tribble(
    ~`x-1`, ~`x-2`, ~`y-1`, ~`y-2`,
        10,     10,   8.04,   9.14,
         8,      8,   6.95,   8.14,
        13,     13,   7.58,   8.74,
         9,      9,   8.81,   8.77,
        11,     11,   8.33,   9.26,
        14,     14,   9.96,   8.10,
         6,      6,   7.24,   6.13,
         4,      4,   4.26,   3.10,
        12,     12,  10.84,   9.13,
         7,      7,   4.82,   7.26,
         5,      5,   5.68,   4.74
  )
ansc
```

```
## # A tibble: 11 x 4
##    `x-1` `x-2` `y-1` `y-2`
##    <dbl> <dbl> <dbl> <dbl>
##  1    10    10  8.04  9.14
##  2     8     8  6.95  8.14
##  3    13    13  7.58  8.74
##  4     9     9  8.81  8.77
##  5    11    11  8.33  9.26
##  6    14    14  9.96  8.1 
##  7     6     6  7.24  6.13
##  8     4     4  4.26  3.1 
##  9    12    12 10.8   9.13
## 10     7     7  4.82  7.26
## 11     5     5  5.68  4.74
```

This dataset is too wide; the digit after each `x` or `y` denotes a different
dataset. The case is tricky to pivot though: We need to separate the trailing
digits while preserving the `x, y` column names. We can use the special ".value"
entry in `names_to` in order to handle this:


```r
## NOTE: No need to edit; execute
ansc %>%
  pivot_longer(
    names_to = c(".value", "set"),
    names_sep = "-",
    cols = everything()
  )
```

```
## # A tibble: 22 x 3
##    set       x     y
##    <chr> <dbl> <dbl>
##  1 1        10  8.04
##  2 2        10  9.14
##  3 1         8  6.95
##  4 2         8  8.14
##  5 1        13  7.58
##  6 2        13  8.74
##  7 1         9  8.81
##  8 2         9  8.77
##  9 1        11  8.33
## 10 2        11  9.26
## # … with 12 more rows
```

Note that:
- With `.value` in `names_to`, we do *not* provide the `values_to` column names. We are instead signaling that the value names come from the column names
- `everything()` is a convenient way to select all columns

Let's look at one more use of `pivot_longer` on the `alloys` dataset.


```r
## NOTE: No need to edit; execute
alloys %>%
  pivot_longer(
    names_to = c("var", "angle"),
    names_sep = "_",
    values_to = "val",
    cols = c(-thick, -rep)
  )
```

```
## # A tibble: 16 x 5
##    thick   rep var   angle       val
##    <dbl> <dbl> <chr> <chr>     <dbl>
##  1 0.022     1 E     00    10600    
##  2 0.022     1 mu    00        0.321
##  3 0.022     1 E     45    10700    
##  4 0.022     1 mu    45        0.329
##  5 0.022     2 E     00    10600    
##  6 0.022     2 mu    00        0.323
##  7 0.022     2 E     45    10500    
##  8 0.022     2 mu    45        0.331
##  9 0.032     1 E     00    10400    
## 10 0.032     1 mu    00        0.329
## 11 0.032     1 E     45    10400    
## 12 0.032     1 mu    45        0.318
## 13 0.032     2 E     00    10300    
## 14 0.032     2 mu    00        0.319
## 15 0.032     2 E     45    10500    
## 16 0.032     2 mu    45        0.326
```

Note a few differences from the call of `pivot_longer` on the `cases` data:

- here `names_to` contains *two* names; this is to deal with the two components of the merged column names `E_00, mu_00, E_45,` etc.
- `names_sep` allows us to specify a character that separates the components of the merged column names. In our case, the column names are merged with an underscore `_`
- We use the `-column` syntax with `cols` to signal that we *don't* want the specified columns. This allows us to exclude `thick, rep`
  - As an alternative, we could have used the more verbose `cols = starts_with("E") | starts_with("mu")`, which means "starts with "E" OR starts with "mu""

This looks closer to tidy---we've taken care of the merged column names---but
now we have a different problem: The variables `E, mu` are now in cells, rather
than column names! This is an example of a dataset that is *too long*. For this,
we'll need to use `pivot_wider`.

### Pivot wider
<!-- ------------------------- -->

We'll continue tidying the `alloys` dataset with `pivot_wider`.


```r
## NOTE: No need to edit; execute
alloys %>%
  pivot_longer(
    names_to = c("var", "angle"),
    names_sep = "_",
    values_to = "val",
    starts_with("E") | starts_with("mu")
  ) %>%
  pivot_wider(
    names_from = var, # Cell entries to turn into new column names
    values_from = val # Values to associate with the new column(s)
  )
```

```
## # A tibble: 8 x 5
##   thick   rep angle     E    mu
##   <dbl> <dbl> <chr> <dbl> <dbl>
## 1 0.022     1 00    10600 0.321
## 2 0.022     1 45    10700 0.329
## 3 0.022     2 00    10600 0.323
## 4 0.022     2 45    10500 0.331
## 5 0.032     1 00    10400 0.329
## 6 0.032     1 45    10400 0.318
## 7 0.032     2 00    10300 0.319
## 8 0.032     2 45    10500 0.326
```

Note the differences between `pivot_longer` and `pivot_wider`:

- Rather than `names_to`, we specify `names_from`; this takes a tidyselect specification. We specify the column(s) of values to turn into new column names
- Rather than `values_to`, we specify `values_from`; this takes a tidyselect specification. We specify the column(s) of values to turn into new values

What we just saw above is a general strategy: If you see merged column names,
you can:

1. First, `pivot_longer` with `names_sep` or `names_pattern` to unmerge the column names.
2. Next, `pivot_wider` to tidy the data.

Both `pivot_longer` and `pivot_wider` have a *lot* of features; see their
documentation for more info.

## Pivoting: Exercises
<!-- -------------------------------------------------- -->

To practice using `pivot_longer` and `pivot_wider`, we're going to work with the
following small dataset:


```r
## NOTE: No need to edit; this is setup for the exercises
df_base <-
  tribble(
    ~`X-0`, ~`X-1`, ~key,
         1,      9,  "A",
         2,      8,  "B",
         3,      7,  "C"
  )
```

We're going to play a game: I'm going to modify the data, and your job is to
pivot it back to equal `df_base`.

### __q3__ Recover `df_base` from `df_q3` by using a *single* pivot and no other functions.


```r
## NOTE: No need to edit; this is setup for the exercise
df_q3 <-
  df_base %>%
  pivot_longer(
    names_to = "id",
    names_pattern = "(\\d)",
    names_transform = list(id = as.integer),
    values_to = "value",
    cols = -key
  )
df_q3
```

```
## # A tibble: 6 x 3
##   key      id value
##   <chr> <int> <dbl>
## 1 A         0     1
## 2 A         1     9
## 3 B         0     2
## 4 B         1     8
## 5 C         0     3
## 6 C         1     7
```

Undo the modification using a single pivot. Don't worry about column order.


```r
df_q3_res <-
  df_q3 %>%
  pivot_wider(
    names_from = id,
    names_prefix = "X-",
    values_from = value
  )

df_q3_res
```

```
## # A tibble: 3 x 3
##   key   `X-0` `X-1`
##   <chr> <dbl> <dbl>
## 1 A         1     9
## 2 B         2     8
## 3 C         3     7
```

```r
all_equal(df_base, df_q3_res) # Checks equality; returns TRUE if equal
```

```
## New names:
## * `X-0` -> X.0
## * `X-1` -> X.1
## New names:
## * `X-0` -> X.0
## * `X-1` -> X.1
```

```
## [1] TRUE
```

### __q4__ Recover `df_base` from `df_q4` by using a *single* pivot and no other functions.


```r
## NOTE: No need to edit; this is setup for the exercise
df_q4 <-
  df_base %>%
  pivot_wider(
    names_from = key,
    values_from = `X-0`
  )
df_q4
```

```
## # A tibble: 3 x 4
##   `X-1`     A     B     C
##   <dbl> <dbl> <dbl> <dbl>
## 1     9     1    NA    NA
## 2     8    NA     2    NA
## 3     7    NA    NA     3
```

Undo the modification using a single pivot. Don't worry about column order.

*Hint*: You'll need a way to drop `NA` values in the pivot (without filtering).
Check the documentation for `pivot_longer`.


```r
df_q4_res <-
  df_q4 %>%
  pivot_longer(
    names_to = "key",
    values_to = "X-0",
    values_drop_na = TRUE,
    cols = c(A, B, C)
  )

df_q4_res
```

```
## # A tibble: 3 x 3
##   `X-1` key   `X-0`
##   <dbl> <chr> <dbl>
## 1     9 A         1
## 2     8 B         2
## 3     7 C         3
```

```r
all_equal(df_base, df_q4_res) # Checks equality; returns TRUE if equal
```

```
## New names:
## * `X-0` -> X.0
## * `X-1` -> X.1
```

```
## New names:
## * `X-1` -> X.1
## * `X-0` -> X.0
```

```
## [1] TRUE
```

### __q5__ Recover `df_base` from `df_q5` by using a *single* pivot and no other functions.


```r
## NOTE: No need to edit; this is setup for the exercise
df_q5 <-
  df_base %>%
  pivot_wider(
    names_from = key,
    values_from = -key
  )
df_q5
```

```
## # A tibble: 1 x 6
##   `X-0_A` `X-0_B` `X-0_C` `X-1_A` `X-1_B` `X-1_C`
##     <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
## 1       1       2       3       9       8       7
```

Undo the modification using a single pivot. Don't worry about column order.

*Hint*: For this one, you'll need to use the special `.value` entry in `names_to`.


```r
df_q5_res <-
  df_q5 %>%
  pivot_longer(
    names_to = c(".value", "key"),
    names_sep = "_",
    cols = everything()
  )

df_q5_res
```

```
## # A tibble: 3 x 3
##   key   `X-0` `X-1`
##   <chr> <dbl> <dbl>
## 1 A         1     9
## 2 B         2     8
## 3 C         3     7
```

```r
all_equal(df_base, df_q5_res) # Checks equality; returns TRUE if equal
```

```
## New names:
## * `X-0` -> X.0
## * `X-1` -> X.1
## New names:
## * `X-0` -> X.0
## * `X-1` -> X.1
```

```
## [1] TRUE
```

### __q6__ Make your own!

Using a single pivot on `df_base` create your own *challenge* dataframe. You will share this with the rest of the class as a puzzle, so make sure to solve your own challenge so you have a solution!


```r
## NOTE: No need to edit; this is setup for the exercise
df_q6 <-
  df_base %>%
  glimpse()
```

```
## Rows: 3
## Columns: 3
## $ `X-0` <dbl> 1, 2, 3
## $ `X-1` <dbl> 9, 8, 7
## $ key   <chr> "A", "B", "C"
```

```r
df_q6
```

```
## # A tibble: 3 x 3
##   `X-0` `X-1` key  
##   <dbl> <dbl> <chr>
## 1     1     9 A    
## 2     2     8 B    
## 3     3     7 C
```

Don't forget to create a solution!


```r
df_q6_res <-
  df_q6 %>%
  glimpse()
```

```
## Rows: 3
## Columns: 3
## $ `X-0` <dbl> 1, 2, 3
## $ `X-1` <dbl> 9, 8, 7
## $ key   <chr> "A", "B", "C"
```

```r
df_q6_res
```

```
## # A tibble: 3 x 3
##   `X-0` `X-1` key  
##   <dbl> <dbl> <chr>
## 1     1     9 A    
## 2     2     8 B    
## 3     3     7 C
```

```r
all_equal(df_base, df_q6_res) # Checks equality; returns TRUE if equal
```

```
## New names:
## * `X-0` -> X.0
## * `X-1` -> X.1
## New names:
## * `X-0` -> X.0
## * `X-1` -> X.1
```

```
## [1] TRUE
```

<!-- include-exit-ticket -->
