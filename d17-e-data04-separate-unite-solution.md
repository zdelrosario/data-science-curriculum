
# Data: Separate and Unite Columns

*Purpose*: Data is easiest to use when it is *tidy*. In fact, the tidyverse (including ggplot, dplyr, etc.) is specifically designed to use tidy data. Last time we learned how to pivot data, but data can be untidy in other ways. Pivoting helped us when data were locked up in the *column headers*: This time, we'll learn how to use *separate* and *unite* to deal with *cell values* that are untidy.

*Reading*: (None, this is the reading)




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

## Punnett Square
<!-- ------------------------- -->

Let's make a [Punnett square](https://en.wikipedia.org/wiki/Punnett_square) with `unite` and some pivoting. You don't need to remember any biology for this example: Your task is to take `genes` and turn the data into `punnett`.


``` r
punnett <-
  tribble(
    ~parent1,   ~a,   ~A,
         "a", "aa", "aA",
         "A", "Aa", "AA"
  )
punnett
```

```
## # A tibble: 2 × 3
##   parent1 a     A    
##   <chr>   <chr> <chr>
## 1 a       aa    aA   
## 2 A       Aa    AA
```

``` r
genes <-
  expand_grid(
    parent1 = c("a", "A"),
    parent2 = c("a", "A")
  )
genes
```

```
## # A tibble: 4 × 2
##   parent1 parent2
##   <chr>   <chr>  
## 1 a       a      
## 2 a       A      
## 3 A       a      
## 4 A       A
```

To do this, we'll use `separate` and `unite`.

## Separate

The `separate` helper takes a string column and *separates* it on a specified character. For instance, if we had a set of phone numbers with `-`'s, we could separate them into components:


``` r
tibble(digits = c(
  "814-255-1234",
  "650-123-4567",
  "617-867-5309"
)) %>% 
  separate(
    col = digits,
    into = c("area_code", "telephone_prefix", "line_number"),
    sep = "-",
  )
```

```
## # A tibble: 3 × 3
##   area_code telephone_prefix line_number
##   <chr>     <chr>            <chr>      
## 1 814       255              1234       
## 2 650       123              4567       
## 3 617       867              5309
```

The `sep` argument is quite versatile. We can also use the special argument `sep = ""` to separate every letter in the string. Note that we'll get funny behavior if the strings are different lengths:


``` r
tibble(s = c(
  "abc",
  "def",
  "yz"
)) %>% 
  separate(
    col = s,
    into = c("1", "2", "3"),
    sep = ""
  )
```

```
## Warning: Expected 3 pieces. Additional pieces discarded in 2 rows [1, 2].
```

```
## # A tibble: 3 × 3
##   `1`   `2`   `3`  
##   <chr> <chr> <chr>
## 1 ""    a     b    
## 2 ""    d     e    
## 3 ""    y     z
```

We can also specify `sep` as a string location. For instance, we could use this to "peel" off the leading characters of the strings:


``` r
tibble(s = c(
  "a1",
  "a5",
  "b11",
  "b23",
  "c300"
)) %>% 
  separate(
    s,
    into = c("letter", "number"),
    sep = 1
  ) %>% 
  mutate(number = as.integer(number))
```

```
## # A tibble: 5 × 2
##   letter number
##   <chr>   <int>
## 1 a           1
## 2 a           5
## 3 b          11
## 4 b          23
## 5 c         300
```

Note that `separte()` won't convert the strings for us! We'll need to `mutate()` if we've separated out numeric values.

## Unite

The `unite()` helper "undoes" a separation by *uniting* two or more string columns. We could use this build up a phone number from parts:


``` r
tribble(
  ~area_code, ~telephone_prefix, ~line_number,
       "814",	            "255",       "1234",
       "650",	            "123",       "4567",
       "617",	            "867",       "5309"
) %>% 
  unite(
    col = "number",
    area_code, telephone_prefix, line_number,
    sep = "-"
  )
```

```
## # A tibble: 3 × 1
##   number      
##   <chr>       
## 1 814-255-1234
## 2 650-123-4567
## 3 617-867-5309
```


### __q1__ Use a combination of `unite` and pivoting to turn `genes` into the same dataframe as `punnett`.


``` r
df_q1 <-
  genes %>%
  unite(col = "offspring", sep = "", remove = FALSE, parent1, parent2) %>%
  pivot_wider(
    names_from = parent2,
    values_from = offspring
  )

df_q1
```

```
## # A tibble: 2 × 3
##   parent1 a     A    
##   <chr>   <chr> <chr>
## 1 a       aa    aA   
## 2 A       Aa    AA
```

Use the following test to check your answer:


``` r
## NOTE: No need to change this
assertthat::assert_that(
              all_equal(df_q1, punnett)
)
```

```
## Warning: `all_equal()` was deprecated in dplyr 1.1.0.
## ℹ Please use `all.equal()` instead.
## ℹ And manually order the rows/cols as needed
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
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

## Alloys, Revisited
<!-- ------------------------- -->

In the previous data exercise, we studied an alloys dataset:


``` r
## NOTE: No need to edit; execute
alloys_mod <- tribble(
  ~thick,  ~E00,  ~mu00,  ~E45,  ~mu45, ~rep,
   0.022, 10600,  0.321, 10700,  0.329,    1,
   0.022, 10600,  0.323, 10500,  0.331,    2,
   0.032, 10400,  0.329, 10400,  0.318,    1,
   0.032, 10300,  0.319, 10500,  0.326,    2
)
alloys_mod
```

```
## # A tibble: 4 × 6
##   thick   E00  mu00   E45  mu45   rep
##   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 0.022 10600 0.321 10700 0.329     1
## 2 0.022 10600 0.323 10500 0.331     2
## 3 0.032 10400 0.329 10400 0.318     1
## 4 0.032 10300 0.319 10500 0.326     2
```

This *slightly modified* version of the data no longer has a convenient
separator to help with pivoting. We'll use a combination of pivoting and
separate to tidy these data.

### __q2__ Use a combination of `separate` and pivoting to tidy `alloys_mod`.


``` r
df_q2 <-
  alloys_mod %>%
  pivot_longer(
    names_to = "varang",
    values_to = "value",
    cols = c(-thick, -rep)
  ) %>%
  separate(
    col = varang,
    into = c("var", "ang"),
    sep = -2,
    convert = TRUE
  ) %>%
  pivot_wider(
    names_from = var,
    values_from = value
  )

df_q2
```

```
## # A tibble: 8 × 5
##   thick   rep   ang     E    mu
##   <dbl> <dbl> <int> <dbl> <dbl>
## 1 0.022     1     0 10600 0.321
## 2 0.022     1    45 10700 0.329
## 3 0.022     2     0 10600 0.323
## 4 0.022     2    45 10500 0.331
## 5 0.032     1     0 10400 0.329
## 6 0.032     1    45 10400 0.318
## 7 0.032     2     0 10300 0.319
## 8 0.032     2    45 10500 0.326
```

Use the following tests to check your work:


``` r
## NOTE: No need to change this
assertthat::assert_that(
              (dim(df_q2)[1] == 8) & (dim(df_q2)[2] == 5)
)
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

<!-- include-exit-ticket -->
