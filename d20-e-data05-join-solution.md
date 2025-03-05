
*Purpose*: Often our data are scattered across multiple sets. In this case, we need to be able to *join* data.

*Reading*: (None, this is the reading)
*Topics*: Welcome, mutating joins, filtering joins, Binds and set operations




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
library(nycflights13)
```

## Combining data

Frequently, the data we need for an analysis is scattered across multiple datasets. In that case, we need tools to *combine* data sets. In R there are two classes of data-combiners:

- *Binding* is a "dumb" way to combine datasets: When binding we have to be very careful to combine the right rows and columns.
- *Joining* is a smarter way to combine datasets. We provide certain shared variables (*join keys*) to join the correct rows.

### Dangers of Binding!

As noted above, binding is a "dumb" way to combine data. 

Let's look at an example using `bind_columns`. This will take two datasets and "glue" them together in whatever order the happened to be arranged in.


``` r
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

### __q1__ Diagnose an issue

Describe what is wrong with the result of `bind_cols` above and how it happened.

*Hint*: John Lennon played guitar in The Beatles. John McCartney is not a real person... (as far as I know).

- The rows of `beatles1` and `beatles2` were not ordered identically; therefore the wrong names and surnames were combined

## Joining data

Rather than do a dumb binding, we can use a set of columns to more intelligently *join* two datasets. Joins operate by combining only those rows of data that match on a selected set of *join keys*. For example, the following image illustrates how we would join two datasets on the columns `A` and `B`. Note that only those rows that match on both `A` and `B` are joined.

![](./images/inner-join.png)

Here's what the example would look like with R datasets:


``` r
## NOTE: No need to edit
df1 <- tibble(
  A = c(1, 1),
  B = c(1, 2),
  C = c(2, 2)
)
df2 <- tibble(
  A = c(1, 1),
  B = c(1, 3),
  D = c(4, 1)
)

inner_join(df1, df2, by = c("A", "B"))
```

```
## # A tibble: 1 × 4
##       A     B     C     D
##   <dbl> <dbl> <dbl> <dbl>
## 1     1     1     2     4
```

Note how the joined dataset includes columns from both `df1` and `df2`. This is "the point" of joining data---to bring together different sources of data.

Note that we can "chain" multiple joins to combine datasets. Sometimes this is necessary when we have different join keys between different pairs of datasets. As an example, we'll use the following `beatles3` to *correctly* join the data.


``` r
## NOTE: No need to change this; setup
# This is our source of join key information
beatles3 <-
  tribble(
    ~name, ~surname,
    "John", "Lennon",
    "Paul", "McCartney",
    "George", "Harrison",
    "Ringo", "Starr"
  )
```

### __q2__ Use the following `beatles3` to *correctly* join `beatles1`

*Hint*: You will need to use two join functions to complete this task.


``` r
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


``` r
## NOTE: No need to change this
# Reference dataset
beatles_joined <-
  tribble(
    ~band, ~name, ~surname, ~instrument,
    "Beatles", "John", "Lennon", "guitar",
    "Beatles", "Paul", "McCartney", "bass",
    "Beatles", "George", "Harrison", "guitar",
    "Beatles", "Ringo", "Starr", "drums"
  )
# Check for correctness
assertthat::assert_that(all_equal(df_q2, beatles_joined))
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
print("Nice!")
```

```
## [1] "Nice!"
```

There's a **very important lesson** here: In general, don't trust `bind_cols`. It's easy in the example above to tell there's a problem because the data are *small*; when working with larger datasets, R will happily give you the wrong answer if you give it the wrong instructions. Whenever possible, use some form of join to combine datasets.

## Different types of joins

There are two primary classes of joints: *mutating joins* and *filter joins*.

### Mutating joins

*Mutating joins* modify (or "mutate") the data. There are four primary mutating joins to consider:

- `left_join(df_A, df_B)`: This preserves all rows in `df_A`, and only those in `df_B` that have a match

![](./images/join_left.png)

- `right_join(df_A, df_B)`: This preserves all rows in `df_B`, and only those in `df_A` that have a match
- `inner_join(df_A, df_B)`: This preserves only those rows that have a match between `df_A` and `df_B`

![](./images/join_inner.png)

- `full_join(df_A, df_B)`: This preserves all rows in `df_A` and all rows in `df_B`, regardless of matches.

![](./images/join_outer.png)

*Note*: Much of the join terminology is based on [SQL](https://en.wikipedia.org/wiki/Join_(SQL)), which is a database access language.

Here are a few tips to help with selecting the appropriate join:

- *To preserve as many rows as possible*, use a `full_join()`
- *To ensure only valid matches*, use an `inner_join()`
- *To add information to a dataset `df_main`*, use `left_join(df_main, df_extra)`

### Keys with different names

So far in our examples, join keys have had the same column name. However, there is no guarantee that our join keys will have the same names across all datasets. Thankfully, the `*_join()` functions have a way to deal with non-matching names. We can use a *named vector* to specify the key names on both sides.

For instance, the `nycflights13` database has multiple tables, including one for the airpots:


``` r
airports
```

```
## # A tibble: 1,458 × 8
##    faa   name                             lat    lon   alt    tz dst   tzone    
##    <chr> <chr>                          <dbl>  <dbl> <dbl> <dbl> <chr> <chr>    
##  1 04G   Lansdowne Airport               41.1  -80.6  1044    -5 A     America/…
##  2 06A   Moton Field Municipal Airport   32.5  -85.7   264    -6 A     America/…
##  3 06C   Schaumburg Regional             42.0  -88.1   801    -6 A     America/…
##  4 06N   Randall Airport                 41.4  -74.4   523    -5 A     America/…
##  5 09J   Jekyll Island Airport           31.1  -81.4    11    -5 A     America/…
##  6 0A9   Elizabethton Municipal Airport  36.4  -82.2  1593    -5 A     America/…
##  7 0G6   Williams County Airport         41.5  -84.5   730    -5 A     America/…
##  8 0G7   Finger Lakes Regional Airport   42.9  -76.8   492    -5 A     America/…
##  9 0P2   Shoestring Aviation Airfield    39.8  -76.6  1000    -5 U     America/…
## 10 0S9   Jefferson County Intl           48.1 -123.    108    -8 A     America/…
## # ℹ 1,448 more rows
```

Note that the airport identifier in `airports` is `faa`. However, for flights, we have to specify an airport identifier for both the `origin` and `dest`. We can use a named vector to match up the join key:


``` r
## NOTE: No need to edit
flights %>% 
  select(flight, origin) %>% 
  left_join(
    airports %>% select(faa, name),
    #       name in `flights`   name in `airports`
    by = c( "origin"          = "faa"              )
  )
```

```
## # A tibble: 336,776 × 3
##    flight origin name               
##     <int> <chr>  <chr>              
##  1   1545 EWR    Newark Liberty Intl
##  2   1714 LGA    La Guardia         
##  3   1141 JFK    John F Kennedy Intl
##  4    725 JFK    John F Kennedy Intl
##  5    461 LGA    La Guardia         
##  6   1696 EWR    Newark Liberty Intl
##  7    507 EWR    Newark Liberty Intl
##  8   5708 LGA    La Guardia         
##  9     79 JFK    John F Kennedy Intl
## 10    301 LGA    La Guardia         
## # ℹ 336,766 more rows
```


### __q3__ Add the airport name

Complete the code below by using an appropriate join to add the airport name to the `flights` dataset.

*Aside*: While you're at it, try replacing `left_join()` with `inner_join()`. What happens to the resulting data?


``` r
## TASK: Add the airport name for the `dest` using a join
flights %>% 
  left_join(
    airports %>% select(faa, name),
    by = c("dest" = "faa")
  ) %>% 
  select(flight, dest, name, everything())
```

```
## # A tibble: 336,776 × 20
##    flight dest  name          year month   day dep_time sched_dep_time dep_delay
##     <int> <chr> <chr>        <int> <int> <int>    <int>          <int>     <dbl>
##  1   1545 IAH   George Bush…  2013     1     1      517            515         2
##  2   1714 IAH   George Bush…  2013     1     1      533            529         4
##  3   1141 MIA   Miami Intl    2013     1     1      542            540         2
##  4    725 BQN   <NA>          2013     1     1      544            545        -1
##  5    461 ATL   Hartsfield …  2013     1     1      554            600        -6
##  6   1696 ORD   Chicago Oha…  2013     1     1      554            558        -4
##  7    507 FLL   Fort Lauder…  2013     1     1      555            600        -5
##  8   5708 IAD   Washington …  2013     1     1      557            600        -3
##  9     79 MCO   Orlando Intl  2013     1     1      557            600        -3
## 10    301 ORD   Chicago Oha…  2013     1     1      558            600        -2
## # ℹ 336,766 more rows
## # ℹ 11 more variables: arr_time <int>, sched_arr_time <int>, arr_delay <dbl>,
## #   carrier <chr>, tailnum <chr>, origin <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```


### Filtering joins

Unlike a mutating join, a *filtering join* only filters rows---it doesn't modify values or add any new columns. There are two filter joins:

- `semi_join(df_main, df_criteria)`: Returns those rows in `df_main` that have a match in `df_criteria`
- `anti_join(df_main, df_criteria)`: Returns those rows in `df_main` that *do not* have a match in `df_criteria`

Filtering joins are an elegant way to produce complicated filters. They are especially helpful because you can first inspect what *criteria* you'll filter on, then perform the filter. We'll use the tidyr tool `expand_grid` to make such a criteria dataframe, then apply it to filter the `flights` data.

### __q4__ Create a "grid" of values

Use `expand_grid` to create a `criteria` dataframe with the `month` equal to `8, 9` and the airport identifiers in `dest` for the San Francisco, San Jose, and Oakland airports. We'll use this in q4 for a filter join.

*Hint 1*: To find the airport identifiers, you can either use `str_detect` to filter the `airports` dataset, or use Google!

*Hint 2*: Remember to look up the documentation for a function you don't yet know!


``` r
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


``` r
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

``` r
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

``` r
print("Well done!")
```

```
## [1] "Well done!"
```

### __q5__ Filter with your `criteria`

Use the `criteria` dataframe you produced above to filter `flights` on `dest` and `month`.

*Hint*: Remember to use a *filtering join* to take advantage of the `criteria` dataset we built above!


``` r
df_q5 <-
  flights %>%
  semi_join(
    criteria,
    by = c("dest", "month")
  )

df_q5
```

```
## # A tibble: 2,584 × 19
##     year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
##    <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
##  1  2013     8     1      554            559        -5      909            902
##  2  2013     8     1      601            601         0      916            915
##  3  2013     8     1      657            700        -3     1016           1016
##  4  2013     8     1      723            730        -7     1040           1045
##  5  2013     8     1      738            740        -2     1111           1055
##  6  2013     8     1      745            743         2     1117           1103
##  7  2013     8     1      810            755        15     1120           1115
##  8  2013     8     1      825            829        -4     1156           1143
##  9  2013     8     1      838            840        -2     1230           1143
## 10  2013     8     1      851            853        -2     1227           1212
## # ℹ 2,574 more rows
## # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>,
## #   tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>,
## #   hour <dbl>, minute <dbl>, time_hour <dttm>
```

Use the following test to check your work:


``` r
## NOTE: No need to change this
assertthat::assert_that(
              all_equal(
                df_q5,
                df_q5 %>%
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

``` r
print("Nice!")
```

```
## [1] "Nice!"
```

<!-- include-exit-ticket -->
