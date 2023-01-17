
# Data: Map Basics

*Purpose*: The `map()` function and its variants are extremely useful for automating iterative tasks. We'll learn the basics through this short exercise.

*Reading*: [Introduction to Iteration](https://rstudio.cloud/learn/primers/5.1) and [Map](https://rstudio.cloud/learn/primers/5.2) (you can skip the Case Study).


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

## Formulas
<!-- ------------------------- -->

The primer introduced `map()` as a way to apply a function to a list.


```r
# NOTE: No need to change this example
map_dbl(c(1, 2, 3), log)
```

```
## [1] 0.0000000 0.6931472 1.0986123
```

This is very helpful when we have a builtin or otherwise defined function, but what about when we need a more special-purpose function for a specific case? In this instance we can use R's *formula notation*. For example, to compute powers of `10`, we could do:


```r
# NOTE: No need to change this example
map_dbl(c(1, 2, 3), ~ 10 ^ .x)
```

```
## [1]   10  100 1000
```

The tilde `~` operator signals to R that we're doing something special: defining a formula. The `.x` symbol is the argument for this new function. Basically, we are taking a formal function definition, such as


```r
# NOTE: No need to change this example
pow10 <- function(x) {10 ^ x}
```

And defining a more compact version with `~ 10 ^ x.`. We've actually already seen this formula notation when we use `facet_grid()` and `facet_wrap()`, though it's used in a very different way in that context.

### __q1__ Use `map_chr()` to prepend the string `"N: "` to the numbers in `v_nums`. Use formula notation with `str_c()` as your map function.

*Hint*: The function `str_c()` combines two or more objects into one string.


```r
v_nums <- c(1, 2, 3)
v_q1 <- map_chr(v_nums, ~ str_c("N: ", .x))

v_q1
```

```
## [1] "N: 1" "N: 2" "N: 3"
```

Use the following test to check your work.


```r
## NOTE: No need to change this!
assertthat::assert_that(setequal(v_q1, c("N: 1", "N: 2", "N: 3")))
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

Formula notation is another way to pass arguments to functions; I find this a little more readable than passing arguments to `map()`.

### __q2__ Use `map_dbl()` to compute the `log` with `base = 2` of the numbers in `v_nums`. Use formula notation with `log()` as your map function.


```r
v_q2 <- map_dbl(v_nums, ~ log(.x, base = 2))

v_q2
```

```
## [1] 0.000000 1.000000 1.584963
```


```r
## NOTE: No need to change this!
assertthat::assert_that(setequal(v_q2, log(v_nums, base = 2)))
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
