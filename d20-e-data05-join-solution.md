
# Data: Joining Datasets

*Purpose*: Often our data are scattered across multiple sets. In this case, we
need to be able to *join* data.

*Reading*: [Join Data Sets](https://rstudio.cloud/learn/primers/4.3)
*Topics*: Welcome, mutating joins, filtering joins, Binds and set operations
*Reading Time*: ~30 minutes




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
library(nycflights13)
```

## Dangers of Binding!
<!-- ------------------------- -->

In the reading we learned about `bind_cols` and `bind_rows`.


```r
## NOTE: No need to change this; setup
beatles1 <-
  tribble(
    ~band, ~name,
    "Beatles", "John",
    "Beatles", "Paul",
    "Beatles", "George",
    "Beatles", "Ringo"
  )

beatles2 <-
  tribble(
       ~surname, ~instrument,
    "McCartney",      "bass",
     "Harrison",    "guitar",
        "Starr",     "drums",
       "Lennon",    "guitar"
  )

bind_cols(beatles1, beatles2)
```

```
## # A tibble: 4 × 4
##   band    name   surname   instrument
##   <chr>   <chr>  <chr>     <chr>     
## 1 Beatles John   McCartney bass      
## 2 Beatles Paul   Harrison  guitar    
## 3 Beatles George Starr     drums     
## 4 Beatles Ringo  Lennon    guitar
```

### __q1__ Describe what is wrong with the result of `bind_cols` above and how it happened.

- The rows of `beatles1` and `beatles2` were not ordered identically; therefore the wrong names and surnames were combined

We'll use the following `beatles3` to *correctly* join the data.


```r
## NOTE: No need to change this; setup
beatles3 <-
  tribble(
    ~name, ~surname,
    "John", "Lennon",
    "Paul", "McCartney",
    "George", "Harrison",
    "Ringo", "Starr"
  )

beatles_joined <-
  tribble(
    ~band, ~name, ~surname, ~instrument,
    "Beatles", "John", "Lennon", "guitar",
    "Beatles", "Paul", "McCartney", "bass",
    "Beatles", "George", "Harrison", "guitar",
    "Beatles", "Ringo", "Starr", "drums"
  )
```

### __q2__ Use the following `beatles3` to *correctly* join `beatles1`


```r
df_q2 <-
  beatles1 %>%
  left_join(
    beatles3,
    by = "name"
  ) %>%
  left_join(
    beatles2,
    by = "surname"
  )

df_q2
```

```
## # A tibble: 4 × 4
##   band    name   surname   instrument
##   <chr>   <chr>  <chr>     <chr>     
## 1 Beatles John   Lennon    guitar    
## 2 Beatles Paul   McCartney bass      
## 3 Beatles George Harrison  guitar    
## 4 Beatles Ringo  Starr     drums
```

Use the following test to check your work:


```r
## NOTE: No need to change this
assertthat::assert_that(all_equal(df_q2, beatles_joined))
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

There's a **very important lesson** here: In general, don't trust `bind_cols`.
It's easy in the example above to tell there's a problem because the data are
*small*; when working with larger datasets, R will happily give you the wrong
answer if you give it the wrong instructions. Whenever possible, use some form
of join to combine datasets.

## Utility of Filtering Joins
<!-- ------------------------- -->

Filtering joins are an elegant way to produce complicated filters. They are
especially helpful because you can first inspect what *criteria* you'll filter
on, then perform the filter. We'll use the tidyr tool `expand_grid` to make such
a criteria dataframe, then apply it to filter the `flights` data.

### __q3__ Create a "grid" of values

Use `expand_grid` to create a `criteria` dataframe with the `month` equal to `8,
9` and the airport identifiers in `dest` for the San Francisco, San Jose, and
Oakland airports.

*Hint 1*: To find the airport identifiers, you can either use `str_detect` to
filter the `airports` dataset, or use Google!

*Hint 2*: Remember to look up the documentation for a function you don't yet know!


```r
criteria <-
  expand_grid(
    month = c(8, 9),
    dest = c("SJC", "SFO", "OAK")
  )

criteria
```

```
## # A tibble: 6 × 2
##   month dest 
##   <dbl> <chr>
## 1     8 SJC  
## 2     8 SFO  
## 3     8 OAK  
## 4     9 SJC  
## 5     9 SFO  
## 6     9 OAK
```

Use the following test to check your work:


```r
## NOTE: No need to change this
assertthat::assert_that(
              all_equal(
                criteria,
                criteria %>%
                semi_join(
                  airports %>%
                  filter(
                    str_detect(name, "San Jose") |
                    str_detect(name, "San Francisco") |
                    str_detect(name, "Metropolitan Oakland")
                ),
                by = c("dest" = "faa")
              )
            )
          )
```

```
## [1] TRUE
```

```r
assertthat::assert_that(
              all_equal(
                criteria,
                criteria %>% filter(month %in% c(8, 9))
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

### __q4__ Use the `criteria` dataframe you produced above to filter `flights` on `dest` and `month`.

*Hint*: Remember to use a *filtering join* to take advantage of the `criteria`
dataset we built above!


```r
df_q4 <-
  flights %>%
  semi_join(
    criteria,
    by = c("dest", "month")
  )

df_q4
```

```
## # A tibble: 2,584 × 19
##     year month   day dep_time sched_de…¹ dep_d…² arr_t…³ sched…⁴ arr_d…⁵ carrier
##    <int> <int> <int>    <int>      <int>   <dbl>   <int>   <int>   <dbl> <chr>  
##  1  2013     8     1      554        559      -5     909     902       7 UA     
##  2  2013     8     1      601        601       0     916     915       1 UA     
##  3  2013     8     1      657        700      -3    1016    1016       0 DL     
##  4  2013     8     1      723        730      -7    1040    1045      -5 VX     
##  5  2013     8     1      738        740      -2    1111    1055      16 VX     
##  6  2013     8     1      745        743       2    1117    1103      14 UA     
##  7  2013     8     1      810        755      15    1120    1115       5 AA     
##  8  2013     8     1      825        829      -4    1156    1143      13 UA     
##  9  2013     8     1      838        840      -2    1230    1143      47 UA     
## 10  2013     8     1      851        853      -2    1227    1212      15 B6     
## # … with 2,574 more rows, 9 more variables: flight <int>, tailnum <chr>,
## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
## #   minute <dbl>, time_hour <dttm>, and abbreviated variable names
## #   ¹​sched_dep_time, ²​dep_delay, ³​arr_time, ⁴​sched_arr_time, ⁵​arr_delay
```

Use the following test to check your work:


```r
## NOTE: No need to change this
assertthat::assert_that(
              all_equal(
                df_q4,
                df_q4 %>%
                filter(
                  month %in% c(8, 9),
                  dest %in% c("SJC", "SFO", "OAK")
                )
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

<!-- include-exit-ticket -->
