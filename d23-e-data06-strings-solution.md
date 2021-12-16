
# Data: Working with strings

*Purpose*: Strings show up in data science all the time. Even when all our variables are numeric, our *column names* are generally strings. To strengthen our ability to work with strings, we'll learn how to use *regular expressions* and apply them to wrangling and tidying data.

*Reading*: [RegexOne](https://regexone.com/); All lessons in the Interactive Tutorial, Additional Practice Problems are optional

*Topics*: Regular expressions, `stringr` package functions, pivoting

*Note*: The [stringr cheatsheet](https://github.com/rstudio/cheatsheets/raw/master/strings.pdf) is a helpful reference for this exercise!




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

## Intro to Stringr
<!-- -------------------------------------------------- -->

Within the Tidyverse, the package `stringr` contains a large number of functions for helping us with strings. We're going to learn a number of useful functions for working with strings using regular expressions.

### Detect
<!-- ------------------------- -->

The function `str_detect()` allows us to *detect* the presence of a particular pattern. For instance, we can give it a fixed pattern such as:


```r
## NOTE: No need to edit
strings <- c(
  "Team Alpha",
  "Team Beta",
  "Group 1",
  "Group 2"
)

str_detect(
  string = strings,
  pattern = "Team"
)
```

```
## [1]  TRUE  TRUE FALSE FALSE
```

`str_detect()` checks whether the given `pattern` is within the given `string`. This function returns a *boolean*---a `TRUE` or `FALSE` value---and furthermore it is *vectorized*---it returns a boolean vector of `T/F` values corresponding to each original entry.

Since `str_detect()` returns boolean values, we can use it as a helper in
`filter()` calls. For instance, in the `mpg` dataset there are automobiles with
`trans` that are automatic or manual.


```r
## NOTE: No need to change this!
mpg %>%
  select(trans) %>%
  glimpse()
```

```
## Rows: 234
## Columns: 1
## $ trans <chr> "auto(l5)", "manual(m5)", "manual(m6)", "auto(av)", "auto(l5)", …
```

We can't simply check whether `trans == "auto"`, because no string will *exactly* match that fixed pattern. But we can instead check for a substring.


```r
## NOTE: No need to change this!
mpg %>%
  filter(str_detect(trans, "auto"))
```

```
## # A tibble: 157 x 11
##    manufacturer model    displ  year   cyl trans  drv     cty   hwy fl    class 
##    <chr>        <chr>    <dbl> <int> <int> <chr>  <chr> <int> <int> <chr> <chr> 
##  1 audi         a4         1.8  1999     4 auto(… f        18    29 p     compa…
##  2 audi         a4         2    2008     4 auto(… f        21    30 p     compa…
##  3 audi         a4         2.8  1999     6 auto(… f        16    26 p     compa…
##  4 audi         a4         3.1  2008     6 auto(… f        18    27 p     compa…
##  5 audi         a4 quat…   1.8  1999     4 auto(… 4        16    25 p     compa…
##  6 audi         a4 quat…   2    2008     4 auto(… 4        19    27 p     compa…
##  7 audi         a4 quat…   2.8  1999     6 auto(… 4        15    25 p     compa…
##  8 audi         a4 quat…   3.1  2008     6 auto(… 4        17    25 p     compa…
##  9 audi         a6 quat…   2.8  1999     6 auto(… 4        15    24 p     midsi…
## 10 audi         a6 quat…   3.1  2008     6 auto(… 4        17    25 p     midsi…
## # … with 147 more rows
```

### __q1__ Filter the `mpg` dataset down to `manual` vehicles using `str_detect()`.


```r
df_q1 <-
  mpg %>%
  filter(str_detect(trans, "manual"))
df_q1 %>% glimpse()
```

```
## Rows: 77
## Columns: 11
## $ manufacturer <chr> "audi", "audi", "audi", "audi", "audi", "audi", "audi", "…
## $ model        <chr> "a4", "a4", "a4", "a4 quattro", "a4 quattro", "a4 quattro…
## $ displ        <dbl> 1.8, 2.0, 2.8, 1.8, 2.0, 2.8, 3.1, 5.7, 6.2, 7.0, 3.7, 3.…
## $ year         <int> 1999, 2008, 1999, 1999, 2008, 1999, 2008, 1999, 2008, 200…
## $ cyl          <int> 4, 4, 6, 4, 4, 6, 6, 8, 8, 8, 6, 6, 8, 8, 8, 8, 8, 6, 6, …
## $ trans        <chr> "manual(m5)", "manual(m6)", "manual(m5)", "manual(m5)", "…
## $ drv          <chr> "f", "f", "f", "4", "4", "4", "4", "r", "r", "r", "4", "4…
## $ cty          <int> 21, 20, 18, 18, 20, 17, 15, 16, 16, 15, 15, 14, 11, 12, 1…
## $ hwy          <int> 29, 31, 26, 26, 28, 25, 25, 26, 26, 24, 19, 17, 17, 16, 1…
## $ fl           <chr> "p", "p", "p", "p", "p", "p", "p", "p", "p", "p", "r", "r…
## $ class        <chr> "compact", "compact", "compact", "compact", "compact", "c…
```

Use the following test to check your work.


```r
## NOTE: No need to change this!
assertthat::assert_that(
              all(
                df_q1 %>%
                pull(trans) %>%
                str_detect(., "manual")
              )
)
```

```
## [1] TRUE
```

```r
print("Great job!")
```

```
## [1] "Great job!"
```

Part of the power of learning *regular expressions* is that we can write *patterns*, rather than exact matches. Notice that the `drv` variable in `mpg` takes either character or digit values. What if we wanted to filter out all the cases that had digits?


```r
mpg %>%
  filter(
    !str_detect(drv, "\\d")
  ) %>%
  glimpse()
```

```
## Rows: 131
## Columns: 11
## $ manufacturer <chr> "audi", "audi", "audi", "audi", "audi", "audi", "audi", "…
## $ model        <chr> "a4", "a4", "a4", "a4", "a4", "a4", "a4", "c1500 suburban…
## $ displ        <dbl> 1.8, 1.8, 2.0, 2.0, 2.8, 2.8, 3.1, 5.3, 5.3, 5.3, 5.7, 6.…
## $ year         <int> 1999, 1999, 2008, 2008, 1999, 1999, 2008, 2008, 2008, 200…
## $ cyl          <int> 4, 4, 4, 4, 6, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 4, 4, …
## $ trans        <chr> "auto(l5)", "manual(m5)", "manual(m6)", "auto(av)", "auto…
## $ drv          <chr> "f", "f", "f", "f", "f", "f", "f", "r", "r", "r", "r", "r…
## $ cty          <int> 18, 21, 20, 21, 16, 18, 18, 14, 11, 14, 13, 12, 16, 15, 1…
## $ hwy          <int> 29, 29, 31, 30, 26, 26, 27, 20, 15, 20, 17, 17, 26, 23, 2…
## $ fl           <chr> "p", "p", "p", "p", "p", "p", "p", "r", "e", "r", "r", "r…
## $ class        <chr> "compact", "compact", "compact", "compact", "compact", "c…
```

Recall (from the reading) that `\d` is a regular expression referring to a single digit. However, a trick thing about R is that we have to *double* the slash `\\` in order to get the correct behavior [1].

### __q2__ Use `str_detect()` and an appropriate regular expression to filter `mpg` for *only* those values of `trans` that have a digit.


```r
df_q2 <-
  mpg %>%
  filter(str_detect(trans, "\\d"))
df_q2 %>% glimpse()
```

```
## Rows: 229
## Columns: 11
## $ manufacturer <chr> "audi", "audi", "audi", "audi", "audi", "audi", "audi", "…
## $ model        <chr> "a4", "a4", "a4", "a4", "a4", "a4 quattro", "a4 quattro",…
## $ displ        <dbl> 1.8, 1.8, 2.0, 2.8, 2.8, 1.8, 1.8, 2.0, 2.0, 2.8, 2.8, 3.…
## $ year         <int> 1999, 1999, 2008, 1999, 1999, 1999, 1999, 2008, 2008, 199…
## $ cyl          <int> 4, 4, 4, 6, 6, 4, 4, 4, 4, 6, 6, 6, 6, 6, 6, 8, 8, 8, 8, …
## $ trans        <chr> "auto(l5)", "manual(m5)", "manual(m6)", "auto(l5)", "manu…
## $ drv          <chr> "f", "f", "f", "f", "f", "4", "4", "4", "4", "4", "4", "4…
## $ cty          <int> 18, 21, 20, 16, 18, 18, 16, 20, 19, 15, 17, 17, 15, 15, 1…
## $ hwy          <int> 29, 29, 31, 26, 26, 26, 25, 28, 27, 25, 25, 25, 25, 24, 2…
## $ fl           <chr> "p", "p", "p", "p", "p", "p", "p", "p", "p", "p", "p", "p…
## $ class        <chr> "compact", "compact", "compact", "compact", "compact", "c…
```

Use the following test to check your work.


```r
## NOTE: No need to change this!
assertthat::assert_that(
              all(
                df_q2 %>%
                pull(trans) %>%
                str_detect(., "\\d")
              )
)
```

```
## [1] TRUE
```

```r
print("Nice!")
```

```
## [1] "Nice!"
```

### Extract
<!-- ------------------------- -->

While `str_detect()` is useful for filtering, `str_extract()` is useful with `mutate()`. This function returns the *first extracted substring*, as demonstrated below.


```r
## NOTE: No need to change this!
str_extract(
  string = c("abc", "xyz", "123"),
  pattern = "\\d{3}"
)
```

```
## [1] NA    NA    "123"
```

Note that if `str_extract()` doesn't find a extract, it will return `NA`. Also, here that I'm using a *quantifier*; as we saw in the reading, `{}` notation will allow us to specify the number of repetitions to seek.


```r
## NOTE: No need to change this!
str_extract(
  string = c("abc", "xyz", "123"),
  pattern = "\\d{2}"
)
```

```
## [1] NA   NA   "12"
```

Notice that this only returns the first two digits in the extract, and neglects the third. If we don't know the specific number we're looking for, we can use `+` to select one or more characters:


```r
## NOTE: No need to change this!
str_extract(
  string = c("abc", "xyz", "123"),
  pattern = "\\d+"
)
```

```
## [1] NA    NA    "123"
```

We can also use the `[[:alpha:]]` special symbol to select alphabetic characters only:


```r
## NOTE: No need to change this!
str_extract(
  string = c("abc", "xyz", "123"),
  pattern = "[[:alpha:]]+"
)
```

```
## [1] "abc" "xyz" NA
```

And finally the wildcard `.` allows us to match any character:


```r
## NOTE: No need to change this!
str_extract(
  string = c("abc", "xyz", "123"),
  pattern = ".+"
)
```

```
## [1] "abc" "xyz" "123"
```

### __q3__ Match alphabet characters

Notice that the `trans` column of `mpg` has many entries of the form `auto|manual\\([[:alpha:]]\\d\\)`; use `str_mutate()` to create a new column `tmp` with just the code inside the parentheses extracting `[[:alpha:]]\\d`.


```r
## TASK: Mutate `trans` to extract
df_q3 <-
  mpg %>%
  mutate(tmp = str_extract(trans, "[[:alpha:]]\\d"))
df_q3 %>%
  select(tmp)
```

```
## # A tibble: 234 x 1
##    tmp  
##    <chr>
##  1 l5   
##  2 m5   
##  3 m6   
##  4 <NA> 
##  5 l5   
##  6 m5   
##  7 <NA> 
##  8 m5   
##  9 l5   
## 10 m6   
## # … with 224 more rows
```

Use the following test to check your work.


```r
## NOTE: No need to change this!
assertthat::assert_that(
              (df_q3 %>% filter(is.na(tmp)) %>% dim(.) %>% .[[1]]) == 5
)
```

```
## [1] TRUE
```

```r
print("Well done!")
```

```
## [1] "Well done!"
```

### Match and Capture Groups
<!-- ------------------------- -->

The `str_match()` function is similar to `str_extract()`, but it allows us to specify multiple "pieces" of a string to match with *capture groups*. A capture group is a pattern within parentheses; for instance, imagine we were trying to parse phone numbers, all with different formatting. We could use three capture groups for the three pieces of the phone number:


```r
## NOTE: No need to edit; execute
phone_numbers <- c(
  "(814) 555 1234",
  "650-555-1234",
  "8005551234"
)

str_match(
  phone_numbers,
  "(\\d{3}).*(\\d{3}).*(\\d{4})"
)
```

```
##      [,1]            [,2]  [,3]  [,4]  
## [1,] "814) 555 1234" "814" "555" "1234"
## [2,] "650-555-1234"  "650" "555" "1234"
## [3,] "8005551234"    "800" "555" "1234"
```

Remember that the `.` character is a wildcard. Here I use the `*` quantifier for *zero or more* instances; this takes care of cases where there is no gap between characters, or when there are spaces or dashes between.

### __q4__ Modify the pattern below to extract the x, y pairs separately.


```r
## NOTE: No need to edit this setup
points <- c(
  "x=1, y=2",
  "x=3, y=2",
  "x=10, y=4"
)

q4 <-
  str_match(
    points,
    pattern = "x=(\\d+), y=(\\d+)"
  )

q4
```

```
##      [,1]        [,2] [,3]
## [1,] "x=1, y=2"  "1"  "2" 
## [2,] "x=3, y=2"  "3"  "2" 
## [3,] "x=10, y=4" "10" "4"
```

Use the following test to check your work.


```r
## NOTE: No need to change this!
assertthat::assert_that(
              all(
                q4[, -1] ==
                t(matrix(as.character(c(1, 2, 3, 2, 10, 4)), nrow = 2))
              )
)
```

```
## [1] TRUE
```

```r
print("Excellent!")
```

```
## [1] "Excellent!"
```

## Removal
<!-- ------------------------- -->

One last `stringr` function that's helpful to know: `str_remove()` will simply remove the *first* matched pattern in a string. This is particularly helpful for dealing with prefixes and suffixes.


```r
## NOTE: No need to edit; execute
string_quantiles <- c(
  "q0.01",
  "q0.5",
  "q0.999"
)

string_quantiles %>%
  str_remove(., "q") %>%
  as.numeric()
```

```
## [1] 0.010 0.500 0.999
```

### __q5__ Use `str_remove()` to get mutate `trans` to remove the parentheses and all characters between.

*Hint*: Note that parentheses are *special characters*, so you'll need to *escape* them as you did above.


```r
df_q5 <-
  mpg %>%
  mutate(trans = str_remove(trans, "\\(.*\\)"))
df_q5
```

```
## # A tibble: 234 x 11
##    manufacturer model     displ  year   cyl trans drv     cty   hwy fl    class 
##    <chr>        <chr>     <dbl> <int> <int> <chr> <chr> <int> <int> <chr> <chr> 
##  1 audi         a4          1.8  1999     4 auto  f        18    29 p     compa…
##  2 audi         a4          1.8  1999     4 manu… f        21    29 p     compa…
##  3 audi         a4          2    2008     4 manu… f        20    31 p     compa…
##  4 audi         a4          2    2008     4 auto  f        21    30 p     compa…
##  5 audi         a4          2.8  1999     6 auto  f        16    26 p     compa…
##  6 audi         a4          2.8  1999     6 manu… f        18    26 p     compa…
##  7 audi         a4          3.1  2008     6 auto  f        18    27 p     compa…
##  8 audi         a4 quatt…   1.8  1999     4 manu… 4        18    26 p     compa…
##  9 audi         a4 quatt…   1.8  1999     4 auto  4        16    25 p     compa…
## 10 audi         a4 quatt…   2    2008     4 manu… 4        20    28 p     compa…
## # … with 224 more rows
```

Use the following test to check your work.


```r
## NOTE: No need to change this!
assertthat::assert_that(
              all(
                df_q5 %>%
                pull(trans) %>%
                str_detect(., "\\(.*\\)") %>%
                !.
              )
)
```

```
## [1] TRUE
```

```r
print("Well done!")
```

```
## [1] "Well done!"
```

## Regex in Other Functions
<!-- -------------------------------------------------- -->

Now we're going to put all these ideas together---special characters, quantifiers, and capture groups---in order to solve a data tidying issue.

Other functions like `pivot_longer` and `pivot_wider` also take regex patterns. We can use these to help solve data tidying problems. Let's return to the alloy data from `e-data03-pivot-basics`; the version of the data below do not have the convenient `_` separators in the column names.


```r
## NOTE: No need to edit; execute
alloys <- tribble(
  ~thick,  ~E00,  ~mu00,  ~E45,  ~mu45, ~rep,
   0.022, 10600,  0.321, 10700,  0.329,    1,
   0.022, 10600,  0.323, 10500,  0.331,    2,
   0.032, 10400,  0.329, 10400,  0.318,    1,
   0.032, 10300,  0.319, 10500,  0.326,    2
)
alloys
```

```
## # A tibble: 4 x 6
##   thick   E00  mu00   E45  mu45   rep
##   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 0.022 10600 0.321 10700 0.329     1
## 2 0.022 10600 0.323 10500 0.331     2
## 3 0.032 10400 0.329 10400 0.318     1
## 4 0.032 10300 0.319 10500 0.326     2
```

As described in the RegexOne tutorial, you can use *capture groups* in parentheses `(...)` to define different groups in your regex pattern. These can be used along with the `pivot_` functions, for instance when you want to break apart column names into multiple groups.

### __q6__ Use your knowledge of regular expressions along with the `names_pattern` argument to successfully tidy the `alloys` data.


```r
## TASK: Tidy `alloys`
df_q6 <-
  alloys %>%
  pivot_longer(
    names_to = c("property", "angle"),
    names_pattern = "([[:alpha:]]+)(\\d+)",
    values_to = "value",
    cols = matches("\\d")
  ) %>%
  mutate(angle = as.integer(angle))
df_q6
```

```
## # A tibble: 16 x 5
##    thick   rep property angle     value
##    <dbl> <dbl> <chr>    <int>     <dbl>
##  1 0.022     1 E            0 10600    
##  2 0.022     1 mu           0     0.321
##  3 0.022     1 E           45 10700    
##  4 0.022     1 mu          45     0.329
##  5 0.022     2 E            0 10600    
##  6 0.022     2 mu           0     0.323
##  7 0.022     2 E           45 10500    
##  8 0.022     2 mu          45     0.331
##  9 0.032     1 E            0 10400    
## 10 0.032     1 mu           0     0.329
## 11 0.032     1 E           45 10400    
## 12 0.032     1 mu          45     0.318
## 13 0.032     2 E            0 10300    
## 14 0.032     2 mu           0     0.319
## 15 0.032     2 E           45 10500    
## 16 0.032     2 mu          45     0.326
```

Use the following test to check your work.


```r
## NOTE: No need to change this!
assertthat::assert_that(dim(df_q6)[1] == 16)
```

```
## [1] TRUE
```

```r
assertthat::assert_that(dim(df_q6)[2] == 5)
```

```
## [1] TRUE
```

```r
print("Awesome!")
```

```
## [1] "Awesome!"
```

<!-- include-exit-ticket -->

## Notes
<!-- -------------------------------------------------- -->

[1] This is because `\` has a special meaning in R, and we need to "escape" the slash by doubling it `\\`.
