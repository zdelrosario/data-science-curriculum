
# Data: Isolating Data

*Purpose*: One of the keys to a successful analysis is the ability to *focus* on
particular topics. When analyzing a dataset, our ability to focus is tied to our
facility at *isolating data*. In this exercise, you will practice isolating
columns with `select()`, picking specific rows with `filter()`, and sorting your
data with `arrange()` to see what rises to the top.

*Reading*: [Isolating Data with dplyr](https://rstudio.cloud/learn/primers/2.2) (All topics)


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
library(nycflights13) # For `flights` data
```

We'll use the `nycflights13` dataset for this exercise; upon loading the
package, the data are stored in the variable name `flights`. For instance:


```r
flights %>% glimpse
```

```
## Rows: 336,776
## Columns: 19
## $ year           <int> 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2…
## $ month          <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
## $ day            <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
## $ dep_time       <int> 517, 533, 542, 544, 554, 554, 555, 557, 557, 558, 558, …
## $ sched_dep_time <int> 515, 529, 540, 545, 600, 558, 600, 600, 600, 600, 600, …
## $ dep_delay      <dbl> 2, 4, 2, -1, -6, -4, -5, -3, -3, -2, -2, -2, -2, -2, -1…
## $ arr_time       <int> 830, 850, 923, 1004, 812, 740, 913, 709, 838, 753, 849,…
## $ sched_arr_time <int> 819, 830, 850, 1022, 837, 728, 854, 723, 846, 745, 851,…
## $ arr_delay      <dbl> 11, 20, 33, -18, -25, 12, 19, -14, -8, 8, -2, -3, 7, -1…
## $ carrier        <chr> "UA", "UA", "AA", "B6", "DL", "UA", "B6", "EV", "B6", "…
## $ flight         <int> 1545, 1714, 1141, 725, 461, 1696, 507, 5708, 79, 301, 4…
## $ tailnum        <chr> "N14228", "N24211", "N619AA", "N804JB", "N668DN", "N394…
## $ origin         <chr> "EWR", "LGA", "JFK", "JFK", "LGA", "EWR", "EWR", "LGA",…
## $ dest           <chr> "IAH", "IAH", "MIA", "BQN", "ATL", "ORD", "FLL", "IAD",…
## $ air_time       <dbl> 227, 227, 160, 183, 116, 150, 158, 53, 140, 138, 149, 1…
## $ distance       <dbl> 1400, 1416, 1089, 1576, 762, 719, 1065, 229, 944, 733, …
## $ hour           <dbl> 5, 5, 5, 5, 6, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 6, 6, 6…
## $ minute         <dbl> 15, 29, 40, 45, 0, 58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 59, 0…
## $ time_hour      <dttm> 2013-01-01 05:00:00, 2013-01-01 05:00:00, 2013-01-01 0…
```

### __q1__ Select all the variables whose name ends with `_time`.


```r
df_q1 <- flights %>% select(ends_with("_time"))
df_q1
```

```
## # A tibble: 336,776 × 5
##    dep_time sched_dep_time arr_time sched_arr_time air_time
##       <int>          <int>    <int>          <int>    <dbl>
##  1      517            515      830            819      227
##  2      533            529      850            830      227
##  3      542            540      923            850      160
##  4      544            545     1004           1022      183
##  5      554            600      812            837      116
##  6      554            558      740            728      150
##  7      555            600      913            854      158
##  8      557            600      709            723       53
##  9      557            600      838            846      140
## 10      558            600      753            745      138
## # … with 336,766 more rows
```

The following is a *unit test* of your code; if you managed to solve task __q2__
correctly, the following code will execute without error.


```r
## NOTE: No need to change this
assertthat::assert_that(
  all(names(df_q1) %>% str_detect(., "_time$"))
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

### __q2__ Re-arrange the columns to place `dest, origin, carrier` at the front, but retain all other columns.

*Hint*: The function `everything()` will be useful!


```r
df_q2 <- flights %>% select(dest, origin, carrier, everything())
df_q2
```

```
## # A tibble: 336,776 × 19
##    dest  origin carrier  year month   day dep_time sched_dep_t…¹ dep_d…² arr_t…³
##    <chr> <chr>  <chr>   <int> <int> <int>    <int>         <int>   <dbl>   <int>
##  1 IAH   EWR    UA       2013     1     1      517           515       2     830
##  2 IAH   LGA    UA       2013     1     1      533           529       4     850
##  3 MIA   JFK    AA       2013     1     1      542           540       2     923
##  4 BQN   JFK    B6       2013     1     1      544           545      -1    1004
##  5 ATL   LGA    DL       2013     1     1      554           600      -6     812
##  6 ORD   EWR    UA       2013     1     1      554           558      -4     740
##  7 FLL   EWR    B6       2013     1     1      555           600      -5     913
##  8 IAD   LGA    EV       2013     1     1      557           600      -3     709
##  9 MCO   JFK    B6       2013     1     1      557           600      -3     838
## 10 ORD   LGA    AA       2013     1     1      558           600      -2     753
## # … with 336,766 more rows, 9 more variables: sched_arr_time <int>,
## #   arr_delay <dbl>, flight <int>, tailnum <chr>, air_time <dbl>,
## #   distance <dbl>, hour <dbl>, minute <dbl>, time_hour <dttm>, and abbreviated
## #   variable names ¹​sched_dep_time, ²​dep_delay, ³​arr_time
```

Use the following to check your code.


```r
## NOTE: No need to change this
assertthat::assert_that(
  assertthat::are_equal(names(df_q2)[1:5], c("dest", "origin", "carrier", "year", "month"))
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

Since R will only show the first few columns of a tibble, using `select()` in
this fashion will help us see the values of particular columns.

### __q3__ Fix the following code. What is the mistake here? What is the code trying to accomplish?


```r
flights %>% filter(dest == "LAX")
```

```
## # A tibble: 16,174 × 19
##     year month   day dep_time sched_de…¹ dep_d…² arr_t…³ sched…⁴ arr_d…⁵ carrier
##    <int> <int> <int>    <int>      <int>   <dbl>   <int>   <int>   <dbl> <chr>  
##  1  2013     1     1      558        600      -2     924     917       7 UA     
##  2  2013     1     1      628        630      -2    1016     947      29 UA     
##  3  2013     1     1      658        700      -2    1027    1025       2 VX     
##  4  2013     1     1      702        700       2    1058    1014      44 B6     
##  5  2013     1     1      743        730      13    1107    1100       7 AA     
##  6  2013     1     1      828        823       5    1150    1143       7 UA     
##  7  2013     1     1      829        830      -1    1152    1200      -8 UA     
##  8  2013     1     1      856        900      -4    1226    1220       6 AA     
##  9  2013     1     1      859        900      -1    1223    1225      -2 VX     
## 10  2013     1     1      921        900      21    1237    1227      10 DL     
## # … with 16,164 more rows, 9 more variables: flight <int>, tailnum <chr>,
## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
## #   minute <dbl>, time_hour <dttm>, and abbreviated variable names
## #   ¹​sched_dep_time, ²​dep_delay, ³​arr_time, ⁴​sched_arr_time, ⁵​arr_delay
```

The next error is *far more insidious*....

### __q4__ This code doesn't quite what the user intended. What went wrong?


```r
flights %>% filter(dest == "BOS")
```

```
## # A tibble: 15,508 × 19
##     year month   day dep_time sched_de…¹ dep_d…² arr_t…³ sched…⁴ arr_d…⁵ carrier
##    <int> <int> <int>    <int>      <int>   <dbl>   <int>   <int>   <dbl> <chr>  
##  1  2013     1     1      559        559       0     702     706      -4 B6     
##  2  2013     1     1      639        640      -1     739     749     -10 B6     
##  3  2013     1     1      801        805      -4     900     919     -19 B6     
##  4  2013     1     1      803        810      -7     903     925     -22 AA     
##  5  2013     1     1      820        830     -10     940     954     -14 DL     
##  6  2013     1     1      923        919       4    1026    1030      -4 B6     
##  7  2013     1     1      957        733     144    1056     853     123 UA     
##  8  2013     1     1     1033       1017      16    1130    1136      -6 UA     
##  9  2013     1     1     1154       1200      -6    1253    1306     -13 B6     
## 10  2013     1     1     1237       1245      -8    1340    1350     -10 AA     
## # … with 15,498 more rows, 9 more variables: flight <int>, tailnum <chr>,
## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
## #   minute <dbl>, time_hour <dttm>, and abbreviated variable names
## #   ¹​sched_dep_time, ²​dep_delay, ³​arr_time, ⁴​sched_arr_time, ⁵​arr_delay
```

It will take practice to get used to when and when not to use quotations. Don't
worry---we'll get lots of practice!

This dataset is called `nycflights`; in what sense is it focused on New York
city? Let's do a quick check to get an idea:

### __q5__ Perform **two** filters; first


```r
df_q5a <-
  flights %>%
  filter(
    dest == "JFK" | dest == "LGA" | dest == "EWR"
  )

df_q5b <-
  flights %>%
  filter(
    origin == "JFK" | origin == "LGA" | origin == "EWR"
  )
```

Use the following code to check your answer.


```r
## NOTE: No need to change this!
assertthat::assert_that(
  df_q5a %>%
  mutate(flag = dest %in% c("JFK", "LGA", "EWR")) %>%
  summarize(flag = all(flag)) %>%
  pull(flag)
)
```

```
## [1] TRUE
```

```r
assertthat::assert_that(
  df_q5b %>%
  mutate(flag = origin %in% c("JFK", "LGA", "EWR")) %>%
  summarize(flag = all(flag)) %>%
  pull(flag)
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

The fact that **all** observations have their origin in NYC highlights (but
does not itself prove!) that these data were collected to study flights
departing from the NYC area.

*Aside*: Data are not just numbers. Data are *numbers with context*. Every
dataset is put together for some reason. This reason will inform what
observations (rows) and variables (columns) are *in the data*, and which are
*not in the data*. Conversely, thinking carefully about what data a person or
organization bothered to collect---and what they ignored---can tell you
something about the *perspective* of those who collected the data. Thinking
about these issues is partly what separates __data science__ from programming or
machine learning. (`end-rant`)

### __q6__ Sort the flights in *descending* order by their `air_time`. Bring `air_time, dest` to the front. What can you tell about the longest flights?


```r
df_q6 <-
  flights %>%
  select(air_time, dest, everything()) %>%
  arrange(desc(air_time))
df_q6
```

```
## # A tibble: 336,776 × 19
##    air_time dest   year month   day dep_time sched_dep…¹ dep_d…² arr_t…³ sched…⁴
##       <dbl> <chr> <int> <int> <int>    <int>       <int>   <dbl>   <int>   <int>
##  1      695 HNL    2013     3    17     1337        1335       2    1937    1836
##  2      691 HNL    2013     2     6      853         900      -7    1542    1540
##  3      686 HNL    2013     3    15     1001        1000       1    1551    1530
##  4      686 HNL    2013     3    17     1006        1000       6    1607    1530
##  5      683 HNL    2013     3    16     1001        1000       1    1544    1530
##  6      679 HNL    2013     2     5      900         900       0    1555    1540
##  7      676 HNL    2013    11    12      936         930       6    1630    1530
##  8      676 HNL    2013     3    14      958        1000      -2    1542    1530
##  9      675 HNL    2013    11    20     1006        1000       6    1639    1555
## 10      671 HNL    2013     3    15     1342        1335       7    1924    1836
## # … with 336,766 more rows, 9 more variables: arr_delay <dbl>, carrier <chr>,
## #   flight <int>, tailnum <chr>, origin <chr>, distance <dbl>, hour <dbl>,
## #   minute <dbl>, time_hour <dttm>, and abbreviated variable names
## #   ¹​sched_dep_time, ²​dep_delay, ³​arr_time, ⁴​sched_arr_time
```


```r
## NOTE: No need to change this!
assertthat::assert_that(
  assertthat::are_equal(
    df_q6 %>% head(1) %>% pull(air_time),
    flights %>% pull(air_time) %>% max(na.rm = TRUE)
  )
)
```

```
## [1] TRUE
```

```r
assertthat::assert_that(
  assertthat::are_equal(
    df_q6 %>% filter(!is.na(air_time)) %>% tail(1) %>% pull(air_time),
    flights %>% pull(air_time) %>% min(na.rm = TRUE)
  )
)
```

```
## [1] TRUE
```

```r
assertthat::assert_that(
  assertthat::are_equal(
    names(df_q6)[1:2],
    c("air_time", "dest")
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

The longest flights are to "HNL"; this makes sense---Honolulu is quite far
from NYC!

<!-- include-exit-ticket -->
