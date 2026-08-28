
# Setup: Vector Basics

*Purpose*: *Vectors* are the most important object we'll work with when doing
data science. To that end, let's learn some basics about vectors.

*Reading*: (None, this is the reading)




``` r
library(tidyverse)
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.2.1     ✔ readr     2.2.0
## ✔ forcats   1.0.1     ✔ stringr   1.6.0
## ✔ ggplot2   4.0.3     ✔ tibble    3.3.1
## ✔ lubridate 1.9.5     ✔ tidyr     1.3.2
## ✔ purrr     1.2.2     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

Remember the `c()` function? Let's use it to work with vectors!

### __q1__ Create a vector

Create a vector with the numbers `1, 2, 3` below.


``` r
vec_q1 <- c(1, 2, 3)

vec_q1
```

```
## [1] 1 2 3
```

Use the following tests to check your work:


``` r
## NOTE: No need to change this
assertthat::assert_that(length(vec_q1) == 3)
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(mean(vec_q1) == 2)
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

### __q2__ Extend a vector

Did you know that you can use `c()` to *extend* a vector as well? Use this to add the extra entry `4` to `vec_q1`.


``` r
vec_q2 <- c(vec_q1, 4)

vec_q2
```

```
## [1] 1 2 3 4
```

Use the following tests to check your work:


``` r
## NOTE: No need to change this
assertthat::assert_that(length(vec_q2) == 4)
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(mean(vec_q2) == 2.5)
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

<!-- include-exit-ticket -->
