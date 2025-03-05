
# Data: Map Basics

*Purpose*: The `map()` function and its variants are extremely useful for automating iterative tasks. We'll learn the basics through this short exercise.

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

## Loops vs mapping

The core idea of `map()` is that it's an alternative to writing a `for` loop. In a lot of `for` loops, we're computing


``` r
## NOTE: No need to edit
v <- seq(1, 10)
v ^ 2 # Vectorized operation
```

```
##  [1]   1   4   9  16  25  36  49  64  81 100
```

However, if we have a non-vectorized function, we can still use `map()` to apply it to a vector:


``` r
## NOTE: No need to edit
f <- function(x) {x ^ 2}
map(v, f)
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 4
## 
## [[3]]
## [1] 9
## 
## [[4]]
## [1] 16
## 
## [[5]]
## [1] 25
## 
## [[6]]
## [1] 36
## 
## [[7]]
## [1] 49
## 
## [[8]]
## [1] 64
## 
## [[9]]
## [1] 81
## 
## [[10]]
## [1] 100
```

The result prints in a weird way; that's because we've made a list, rather than a vector. To specify that we want our output to be a vector of floating point values, we can use `map_dbl()`:


``` r
## NOTE: No need to edit
f <- function(x) {x ^ 2}
map_dbl(v, f)
```

```
##  [1]   1   4   9  16  25  36  49  64  81 100
```

Function notation in R is a little weird; we don't need to explicitly `return` our resulting value. Instead, the last line of the function will automatically be the return value:


``` r
f2 <- function(x) {
  x2 <- x * 2 # Do an intermediate calculation
  x2 ^ 2      # The last value of the function is automatically returned as the output
}
```

## Formula notation

Rather than define a `function()`, we can use R's *formula notation*. For example, to compute powers of `10`, we could do:


``` r
# NOTE: No need to change this example
map_dbl(c(1, 2, 3), ~ 10 ^ .x)
```

```
## [1]   10  100 1000
```

The tilde `~` operator signals to R that we're doing something special: defining a formula. The `.x` symbol is the argument for this new function. Basically, we are taking a formal function definition, such as


``` r
# NOTE: No need to change this example
pow10 <- function(x) {10 ^ x}
```

And defining a more compact version with `~ 10 ^ x.`. We've actually already seen this formula notation when we use `facet_grid()` and `facet_wrap()`, though it's used in a very different way in that context.

### __q1__ Add a prefix

Use `map_chr()` to prepend the string `"N: "` to the numbers in `v_nums`. Use formula notation with `str_c()` as your map function.

*Hint*: The function `str_c()` combines two or more objects into one string.


``` r
v_nums <- c(1, 2, 3)
v_q1 <- map_chr(v_nums, ~ str_c("N: ", .x))

v_q1
```

```
## [1] "N: 1" "N: 2" "N: 3"
```

Use the following test to check your work.


``` r
## NOTE: No need to change this!
assertthat::assert_that(setequal(v_q1, c("N: 1", "N: 2", "N: 3")))
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

Formula notation is another way to pass arguments to functions; I find this a little more readable than passing arguments to `map()`.

### __q2__ Compute a log

Use `map_dbl()` to compute the `log` with `base = 2` of the numbers in `v_nums`. Use formula notation with `log()` as your map function.


``` r
v_q2 <- map_dbl(v_nums, ~ log(.x, base = 2))

v_q2
```

```
## [1] 0.000000 1.000000 1.584963
```


``` r
## NOTE: No need to change this!
assertthat::assert_that(setequal(v_q2, log(v_nums, base = 2)))
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
