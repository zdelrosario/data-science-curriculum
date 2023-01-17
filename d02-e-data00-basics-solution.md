
# Data: Basics

*Purpose*: When first studying a new dataset, there are very simple checks we
should perform first. These are those checks.

Additionally, we'll have our first look at the *pipe operator*, which will be
super useful for writing code that's readable.

*Reading*: (None)


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



## First Checks
<!-- -------------------------------------------------- -->

### __q0__ Run the following chunk:

*Hint*: You can do this either by clicking the green arrow at the top-right of
the chunk, or by using the keybaord shortcut `Shift` + `Cmd/Ctrl` + `Enter`.


```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

This is a *dataset*; the fundamental object we'll study throughout this course.
Some nomenclature:

- The `1, 2, 3, ...` on the left enumerate the **rows** of the dataset
- The names `Sepal.Length`, `Sepal.Width`, `...` name the **columns** of the dataset
- The column `Sepal.Length` takes **numeric** values
- The column `Species` takes **string** values

### __q1__ Load the `tidyverse` and inspect the `diamonds` dataset. What do the
`cut`, `color`, and `clarity` variables mean?

*Hint*: You can run `?diamonds` to get information on a built-in dataset.


```r
?diamonds
```

### __q2__ Run `glimpse(diamonds)`; what variables does `diamonds` have?


```r
glimpse(diamonds)
```

```
## Rows: 53,940
## Columns: 10
## $ carat   <dbl> 0.23, 0.21, 0.23, 0.29, 0.31, 0.24, 0.24, 0.26, 0.22, 0.23, 0.…
## $ cut     <ord> Ideal, Premium, Good, Premium, Good, Very Good, Very Good, Ver…
## $ color   <ord> E, E, E, I, J, J, I, H, E, H, J, J, F, J, E, E, I, J, J, J, I,…
## $ clarity <ord> SI2, SI1, VS1, VS2, SI2, VVS2, VVS1, SI1, VS2, VS1, SI1, VS1, …
## $ depth   <dbl> 61.5, 59.8, 56.9, 62.4, 63.3, 62.8, 62.3, 61.9, 65.1, 59.4, 64…
## $ table   <dbl> 55, 61, 65, 58, 58, 57, 57, 55, 61, 61, 55, 56, 61, 54, 62, 58…
## $ price   <int> 326, 326, 327, 334, 335, 336, 336, 337, 337, 338, 339, 340, 34…
## $ x       <dbl> 3.95, 3.89, 4.05, 4.20, 4.34, 3.94, 3.95, 4.07, 3.87, 4.00, 4.…
## $ y       <dbl> 3.98, 3.84, 4.07, 4.23, 4.35, 3.96, 3.98, 4.11, 3.78, 4.05, 4.…
## $ z       <dbl> 2.43, 2.31, 2.31, 2.63, 2.75, 2.48, 2.47, 2.53, 2.49, 2.39, 2.…
```

The `diamonds` dataset has variables `carat, cut, color, clarity, depth, table,
price, x, y, z`.

### __q3__ Run `summary(diamonds)`; what are the common values for each of the
variables? How widely do each of the variables vary?

*Hint*: The `Median` and `Mean` are common values, while `Min` and `Max` give us
a sense of variation.



**Observations**:

- `carat` seems to be bounded between `0` and `5`
- The highest-priced diamond in this set is $18,823!
- Some of the variables do not have `min, max` etc. values. These are *factors*; variables that take one of a finite set of possible values.

You should always analyze your dataset in the simplest way possible, build
hypotheses, and devise more specific analyses to probe those hypotheses. The
`glimpse()` and `summary()` functions are two of the simplest tools we have.

## The Pipe Operator
<!-- -------------------------------------------------- -->

Throughout this class we're going to make heavy use of the *pipe operator*
`%>%`. This handy little function will help us make our code more readable.
Whenever you see `%>%`, you can translate that into the word "then". For
instance


```r
diamonds %>%
  group_by(cut) %>%
  summarize(carat_mean = mean(carat))
```

```
## # A tibble: 5 × 2
##   cut       carat_mean
##   <ord>          <dbl>
## 1 Fair           1.05 
## 2 Good           0.849
## 3 Very Good      0.806
## 4 Premium        0.892
## 5 Ideal          0.703
```

Would translate into the tiny "story"

- Take the `diamonds` dataset, *then*
- Group it by the variable `cut`, *then*
- summarize it by computing the `mean` of `carat`

*What the pipe actually does*. The pipe operator `LHS %>% RHS` takes its
left-hand side (LHS) and inserts it as an the first argument to the function on
its right-hand side (RHS). So the pipe will let us take `glimpse(diamonds)` and
turn it into `diamonds %>% glimpse()`.

### __q4__ Use the pipe operator to re-write `summary(diamonds)`.


```r
diamonds %>% summary()
```

```
##      carat               cut        color        clarity          depth      
##  Min.   :0.2000   Fair     : 1610   D: 6775   SI1    :13065   Min.   :43.00  
##  1st Qu.:0.4000   Good     : 4906   E: 9797   VS2    :12258   1st Qu.:61.00  
##  Median :0.7000   Very Good:12082   F: 9542   SI2    : 9194   Median :61.80  
##  Mean   :0.7979   Premium  :13791   G:11292   VS1    : 8171   Mean   :61.75  
##  3rd Qu.:1.0400   Ideal    :21551   H: 8304   VVS2   : 5066   3rd Qu.:62.50  
##  Max.   :5.0100                     I: 5422   VVS1   : 3655   Max.   :79.00  
##                                     J: 2808   (Other): 2531                  
##      table           price             x                y         
##  Min.   :43.00   Min.   :  326   Min.   : 0.000   Min.   : 0.000  
##  1st Qu.:56.00   1st Qu.:  950   1st Qu.: 4.710   1st Qu.: 4.720  
##  Median :57.00   Median : 2401   Median : 5.700   Median : 5.710  
##  Mean   :57.46   Mean   : 3933   Mean   : 5.731   Mean   : 5.735  
##  3rd Qu.:59.00   3rd Qu.: 5324   3rd Qu.: 6.540   3rd Qu.: 6.540  
##  Max.   :95.00   Max.   :18823   Max.   :10.740   Max.   :58.900  
##                                                                   
##        z         
##  Min.   : 0.000  
##  1st Qu.: 2.910  
##  Median : 3.530  
##  Mean   : 3.539  
##  3rd Qu.: 4.040  
##  Max.   :31.800  
## 
```

## Reading Data
<!-- -------------------------------------------------- -->

So far we've only been looking at built-in datasets. Ultimately, we'll want to read in our own data. We'll get to the art of loading and *wrangling* data later, but for now, know that the `readr` package provides us tools to read data. Let's quickly practice loading data below.

### __q5__ Use the function `read_csv()` to load the file `"./data/tiny.csv"`.


```r
df_q5 <-
  read_csv("./data/tiny.csv")
```

```
## Rows: 2 Columns: 2
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## dbl (2): x, y
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
df_q5
```

```
## # A tibble: 2 × 2
##       x     y
##   <dbl> <dbl>
## 1     1     2
## 2     3     4
```

<!-- include-exit-ticket -->
