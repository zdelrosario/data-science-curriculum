
# Data: Isolating Data

*Purpose*: One of the keys to a successful analysis is the ability to *focus* on particular topics. When analyzing a dataset, our ability to focus is tied to our facility at *isolating data*. In this exercise, you will practice isolating columns with `select()`, picking specific rows with `filter()`, and sorting your data with `arrange()` to see what rises to the top.

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

``` r
library(nycflights13) # For `flights` data
```

We'll use the `nycflights13` dataset for this exercise; upon loading the package, the data are stored in the variable name `flights`. For instance:


``` r
flights %>% glimpse()
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

## `select()` columns

Sometimes, our data has so many columns that it's just *overwhelming*. The `flights` dataset only has 19 columns, but that's already quite a bit to deal with. Thankfully, we can `select()` a subset of columns to focus on a few at a time. To select a column, we simply provide its name:


``` r
## NOTE: No need to edit
flights %>% 
  select(flight, carrier, dep_time)
```

```
## # A tibble: 336,776 × 3
##    flight carrier dep_time
##     <int> <chr>      <int>
##  1   1545 UA           517
##  2   1714 UA           533
##  3   1141 AA           542
##  4    725 B6           544
##  5    461 DL           554
##  6   1696 UA           554
##  7    507 B6           555
##  8   5708 EV           557
##  9     79 B6           557
## 10    301 AA           558
## # ℹ 336,766 more rows
```

This is fine when we know exactly what we're looking for. But `select()` is even more powerful when combined with *selection helpers*.

### Matching selection helpers

The following helpers perform different kinds of column matching:

- `starts_with(str)`: all columns that start with the prefix `str`
- `ends_with(str)`: all columns that end with the suffix `str`
- `contains(str)`: all columns that contain the substring `str`
- `matches(expr)`: matches a regular expression `expr`*
- `numrange()`: builds ranges of variables, like `"x0", "x1", "x2", ...`

*We'll learn more about regular expressions in `e-data06-strings`

We use selection helpers inside `select()`, just like we'd provide a column name.


``` r
flights %>% 
  select(starts_with("dep_"))
```

```
## # A tibble: 336,776 × 2
##    dep_time dep_delay
##       <int>     <dbl>
##  1      517         2
##  2      533         4
##  3      542         2
##  4      544        -1
##  5      554        -6
##  6      554        -4
##  7      555        -5
##  8      557        -3
##  9      557        -3
## 10      558        -2
## # ℹ 336,766 more rows
```


### __q1__ Select matches

Select all the variables whose name ends with `_time`.


``` r
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
## # ℹ 336,766 more rows
```

The following is a *unit test* of your code; if you managed to solve task __q1__ correctly, the following code will execute without error.


``` r
## NOTE: No need to change this
assertthat::assert_that(
  all(names(df_q1) %>% str_detect(., "_time$"))
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

### The `everything()` helper

There's another *strange* helper: `everything()`. This seems useless at first, until we realize that we can first *re-arrange* the other columns, then put `everything()` else at the end!


``` r
flights %>% 
  select(year, month, day, sched_dep_time, everything())
```

```
## # A tibble: 336,776 × 19
##     year month   day sched_dep_time dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>          <int>    <int>     <dbl>    <int>          <int>
##  1  2013     1     1            515      517         2      830            819
##  2  2013     1     1            529      533         4      850            830
##  3  2013     1     1            540      542         2      923            850
##  4  2013     1     1            545      544        -1     1004           1022
##  5  2013     1     1            600      554        -6      812            837
##  6  2013     1     1            558      554        -4      740            728
##  7  2013     1     1            600      555        -5      913            854
##  8  2013     1     1            600      557        -3      709            723
##  9  2013     1     1            600      557        -3      838            846
## 10  2013     1     1            600      558        -2      753            745
## # ℹ 336,766 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```


### __q2__ Re-arrange the columns

Re-arrange the columns to place `dest, origin, carrier` at the front, but retain all other columns.

*Hint*: The function `everything()` will be useful!


``` r
df_q2 <- flights %>% select(dest, origin, carrier, everything())
df_q2
```

```
## # A tibble: 336,776 × 19
##    dest  origin carrier  year month   day dep_time sched_dep_time dep_delay
##    <chr> <chr>  <chr>   <int> <int> <int>    <int>          <int>     <dbl>
##  1 IAH   EWR    UA       2013     1     1      517            515         2
##  2 IAH   LGA    UA       2013     1     1      533            529         4
##  3 MIA   JFK    AA       2013     1     1      542            540         2
##  4 BQN   JFK    B6       2013     1     1      544            545        -1
##  5 ATL   LGA    DL       2013     1     1      554            600        -6
##  6 ORD   EWR    UA       2013     1     1      554            558        -4
##  7 FLL   EWR    B6       2013     1     1      555            600        -5
##  8 IAD   LGA    EV       2013     1     1      557            600        -3
##  9 MCO   JFK    B6       2013     1     1      557            600        -3
## 10 ORD   LGA    AA       2013     1     1      558            600        -2
## # ℹ 336,766 more rows
## # ℹ 10 more variables: arr_time <int>, sched_arr_time <int>, arr_delay <dbl>,
## #   flight <int>, tailnum <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
## #   minute <dbl>, time_hour <dttm>
```

Use the following to check your code.


``` r
## NOTE: No need to change this
assertthat::assert_that(
  assertthat::are_equal(names(df_q2)[1:5], c("dest", "origin", "carrier", "year", "month"))
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

Since R will only show the first few columns of a tibble, using `select()` in this fashion will help us see the values of particular columns.

## `filter()` rows

With analyzing data, we're often looking for rows that match particular criteria. To find rows, we can use `filter()` along with logical statements. For instance, we could select only those rows where the flight was in February (`month == 2`).


``` r
flights %>% 
  filter(month == 2)
```

```
## # A tibble: 24,951 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     2     1      456            500        -4      652            648
##  2  2013     2     1      520            525        -5      816            820
##  3  2013     2     1      527            530        -3      837            829
##  4  2013     2     1      532            540        -8     1007           1017
##  5  2013     2     1      540            540         0      859            850
##  6  2013     2     1      552            600        -8      714            715
##  7  2013     2     1      552            600        -8      919            910
##  8  2013     2     1      552            600        -8      655            709
##  9  2013     2     1      553            600        -7      833            815
## 10  2013     2     1      553            600        -7      821            825
## # ℹ 24,941 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

*Important note*: Keep in mind that you have to use `==` to check equality. Using `=` inside a `filter()` will raise a helpful error message telling you to use `==` instead.


``` r
## NOTE: Uncomment and run to see the error
# flights %>% 
#   filter(month = 2)
```

### Filter conditions

We can use a variety of conditions with `filter()`:

- `==`: strict equality
- `!=`: not equal
- `>`, `>=`: greater than (or equal)
- `<`, "<=`: less than (or equal)
- Logical operations:
  - `&`: and
  - `|`: or
  - `!`: not
  - `xor`: and/or
  
### Filter helpers

There are also some useful helper functions we can use with `filter()`:

- `is.na(x)`: Returns rows that contain `NaN` values
  - Note that we can use `!is.na(x)` to return non-`NaN` values
- `between(x, l, r)`: Returns rows with `l < x < r`
- `near(x, y)`: Returns rows where `x` is "close" to `y`; we can optionally set the tolerance with `tol = ???`

### __q3__ Find near-arrivals

Find all the flights where the plane arrived within 10 minutes of its planned arrival time, but was not *exactly* on time.

*Hint*: You can use `?flights` to look up the units for each column.


``` r
## TASK:
df_q3 <- 
  flights %>% 
  filter(
    arr_time != sched_arr_time,
    near(arr_time, sched_arr_time, tol = 10),
  )

df_q3
```

```
## # A tibble: 86,700 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     1      557            600        -3      838            846
##  2  2013     1     1      558            600        -2      753            745
##  3  2013     1     1      558            600        -2      849            851
##  4  2013     1     1      558            600        -2      853            856
##  5  2013     1     1      558            600        -2      924            917
##  6  2013     1     1      559            559         0      702            706
##  7  2013     1     1      600            600         0      851            858
##  8  2013     1     1      601            600         1      844            850
##  9  2013     1     1      602            610        -8      812            820
## 10  2013     1     1      606            610        -4      837            845
## # ℹ 86,690 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```


``` r
## NOTE: No need to change this!
assertthat::assert_that(
  (
    df_q3 %>%
      summarize(diff = max(arr_time - sched_arr_time)) %>% 
      pull(diff) %>% 
      .[[1]] <= 10
  ) |
  (
    df_q3 %>%
      summarize(diff = max(abs(arr_delay))) %>% 
      pull(diff) %>% 
      .[[1]] <= 10
  )
)
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(
  df_q3 %>%
    summarize(diff = max(arr_time - sched_arr_time)) %>% 
    pull(diff) %>% 
    .[[1]] > 0
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

## Tidyverse quirks

Note that in Tidyverse functions like `select()` and `filter()`, we can refer to column names directly---we don't have to quote them. However, the same doesn't hold if we're trying to compare string values. Make sure to quote a string if you're using it in a `filter()` comparison!

### __q4__ Fix a bug

Fix the following code. What is the mistake here? What is the code trying to accomplish?


``` r
flights %>% filter(dest == "LAX")
```

```
## # A tibble: 16,174 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     1      558            600        -2      924            917
##  2  2013     1     1      628            630        -2     1016            947
##  3  2013     1     1      658            700        -2     1027           1025
##  4  2013     1     1      702            700         2     1058           1014
##  5  2013     1     1      743            730        13     1107           1100
##  6  2013     1     1      828            823         5     1150           1143
##  7  2013     1     1      829            830        -1     1152           1200
##  8  2013     1     1      856            900        -4     1226           1220
##  9  2013     1     1      859            900        -1     1223           1225
## 10  2013     1     1      921            900        21     1237           1227
## # ℹ 16,164 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

The next error is *far more insidious*....

### __q5__ Fix a bug

This code doesn't quite what the user intended---they were trying to filter for only those flights where the desination was Boston airport. What went wrong?


``` r
## It's more likely the user is trying to find flights to Boston;
## they just did something a bit misguided by storing LaGuardia
## in a variable named BOS
flights %>% filter(dest == "BOS")
```

```
## # A tibble: 15,508 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     1      559            559         0      702            706
##  2  2013     1     1      639            640        -1      739            749
##  3  2013     1     1      801            805        -4      900            919
##  4  2013     1     1      803            810        -7      903            925
##  5  2013     1     1      820            830       -10      940            954
##  6  2013     1     1      923            919         4     1026           1030
##  7  2013     1     1      957            733       144     1056            853
##  8  2013     1     1     1033           1017        16     1130           1136
##  9  2013     1     1     1154           1200        -6     1253           1306
## 10  2013     1     1     1237           1245        -8     1340           1350
## # ℹ 15,498 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

It will take practice to get used to when and when not to use quotations. Don't worry---we'll get lots of practice!

The `filter()` tool is very simple, but already allows us to do a lot: This dataset is called `nycflights`; in what sense is it focused on New York city? Let's do a quick check to get an idea:

### __q6__ Understand the data

Perform **two** filters; first filter for flights where the *destination* was a New York airport (`JFK, LGA, or EWR`), then for flights where the *origin* was a New York airport (the same three). Answer the questions below.


``` r
df_q6a <-
  flights %>%
  filter(
    dest == "JFK" | dest == "LGA" | dest == "EWR"
  )

df_q6b <-
  flights %>%
  filter(
    origin == "JFK" | origin == "LGA" | origin == "EWR"
  )
```

Use the following code to check your answer.


``` r
## NOTE: No need to change this!
assertthat::assert_that(
  df_q6a %>%
  mutate(flag = dest %in% c("JFK", "LGA", "EWR")) %>%
  summarize(flag = all(flag)) %>%
  pull(flag)
)
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(
  df_q6b %>%
  mutate(flag = origin %in% c("JFK", "LGA", "EWR")) %>%
  summarize(flag = all(flag)) %>%
  pull(flag)
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

**Observations**
- Was this dataset assembled to study flights *out of* NYC, or *into* NYC? How do you know?
  - The fact that **all** observations have their origin in NYC highlights (but does not itself prove!) that these data were collected to study flights *departing* from the NYC area.

*Aside*: Data are not just numbers. Data are *numbers with context*. Every dataset is put together for some reason. This reason will inform what observations (rows) and variables (columns) are *in the data*, and which are *not in the data*. Conversely, thinking carefully about what data a person or organization bothered to collect---and what they ignored---can tell you something about the *perspective* of those who collected the data. Thinking about these issues is partly what separates __data science__ from programming or machine learning.

## `arrange()` rows

One more simple tool; rather than remove rows, we can re-arrange rows with `arrange()` to see what comes to the top. `arrange()` takes a set of columns by which to sort the data. For instance, we can find the earliest-departing flights with `arrange(dep_delay)`.


``` r
## NOTE: No need to edit
flights %>% 
  arrange(dep_delay)
```

```
## # A tibble: 336,776 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013    12     7     2040           2123       -43       40           2352
##  2  2013     2     3     2022           2055       -33     2240           2338
##  3  2013    11    10     1408           1440       -32     1549           1559
##  4  2013     1    11     1900           1930       -30     2233           2243
##  5  2013     1    29     1703           1730       -27     1947           1957
##  6  2013     8     9      729            755       -26     1002            955
##  7  2013    10    23     1907           1932       -25     2143           2143
##  8  2013     3    30     2030           2055       -25     2213           2250
##  9  2013     3     2     1431           1455       -24     1601           1631
## 10  2013     5     5      934            958       -24     1225           1309
## # ℹ 336,766 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

*Aside*: What flight leaves `43` minutes early? That's crazy!!

We can also use `arrange(desc(x))` to reverse the sort.


``` r
## NOTE: No need to edit
flights %>% 
  arrange(desc(dep_delay))
```

```
## # A tibble: 336,776 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     1     9      641            900      1301     1242           1530
##  2  2013     6    15     1432           1935      1137     1607           2120
##  3  2013     1    10     1121           1635      1126     1239           1810
##  4  2013     9    20     1139           1845      1014     1457           2210
##  5  2013     7    22      845           1600      1005     1044           1815
##  6  2013     4    10     1100           1900       960     1342           2211
##  7  2013     3    17     2321            810       911      135           1020
##  8  2013     6    27      959           1900       899     1236           2226
##  9  2013     7    22     2257            759       898      121           1026
## 10  2013    12     5      756           1700       896     1058           2020
## # ℹ 336,766 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

*Aside*: A 21.6 hour delay sounds like hell.

Now I know what you're thinking: "`desc()` seems silly; why not just `arrange(-x)`?"

Ah, but what about using `arrange(s)` with string data? How will you take a negative string? You can't! But you can use `arrange(desc(s))` to sort in reverse alphabetical order:


``` r
## NOTE: No need to edit
flights %>% 
  arrange(desc(carrier)) %>% 
  select(carrier, everything())
```

```
## # A tibble: 336,776 × 19
##    carrier  year month   day dep_time sched_dep_time dep_delay arr_time
##    <chr>   <int> <int> <int>    <int>          <int>     <dbl>    <int>
##  1 YV       2013     1     3     1428           1435        -7     1539
##  2 YV       2013     1     3     1551           1602       -11     1659
##  3 YV       2013     1     4     1430           1435        -5     1546
##  4 YV       2013     1     4     1731           1602        89     1837
##  5 YV       2013     1     6     1557           1605        -8     1714
##  6 YV       2013     1     7     1430           1435        -5     1541
##  7 YV       2013     1     7     1556           1602        -6     1721
##  8 YV       2013     1     8     1432           1435        -3     1537
##  9 YV       2013     1     8     1555           1602        -7     1727
## 10 YV       2013     1     9     1432           1435        -3     1543
## # ℹ 336,766 more rows
## # ℹ 11 more variables: sched_arr_time <int>, arr_delay <dbl>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

### __q7__ Sort to find

Sort the flights in *descending* order by their `air_time`. Bring `air_time, dest` to the front. What can you tell about the longest flights?


``` r
df_q7 <-
  flights %>%
  select(air_time, dest, everything()) %>%
  arrange(desc(air_time))
df_q7
```

```
## # A tibble: 336,776 × 19
##    air_time dest   year month   day dep_time sched_dep_time dep_delay arr_time
##       <dbl> <chr> <int> <int> <int>    <int>          <int>     <dbl>    <int>
##  1      695 HNL    2013     3    17     1337           1335         2     1937
##  2      691 HNL    2013     2     6      853            900        -7     1542
##  3      686 HNL    2013     3    15     1001           1000         1     1551
##  4      686 HNL    2013     3    17     1006           1000         6     1607
##  5      683 HNL    2013     3    16     1001           1000         1     1544
##  6      679 HNL    2013     2     5      900            900         0     1555
##  7      676 HNL    2013    11    12      936            930         6     1630
##  8      676 HNL    2013     3    14      958           1000        -2     1542
##  9      675 HNL    2013    11    20     1006           1000         6     1639
## 10      671 HNL    2013     3    15     1342           1335         7     1924
## # ℹ 336,766 more rows
## # ℹ 10 more variables: sched_arr_time <int>, arr_delay <dbl>, carrier <chr>,
## #   flight <int>, tailnum <chr>, origin <chr>, distance <dbl>, hour <dbl>,
## #   minute <dbl>, time_hour <dttm>
```

Use the following to check your work


``` r
## NOTE: No need to change this!
assertthat::assert_that(
  assertthat::are_equal(
    df_q7 %>% head(1) %>% pull(air_time),
    flights %>% pull(air_time) %>% max(na.rm = TRUE)
  )
)
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(
  assertthat::are_equal(
    df_q7 %>% filter(!is.na(air_time)) %>% tail(1) %>% pull(air_time),
    flights %>% pull(air_time) %>% min(na.rm = TRUE)
  )
)
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(
  assertthat::are_equal(
    names(df_q7)[1:2],
    c("air_time", "dest")
  )
)
```

```
## [1] TRUE
```

``` r
print("Great job!")
```

```
## [1] "Great job!"
```

The longest flights are to "HNL"; this makes sense---Honolulu is quite far from NYC!

<!-- include-exit-ticket -->
