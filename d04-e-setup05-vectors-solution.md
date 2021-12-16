
# Setup: Vector Basics

*Purpose*: *Vectors* are the most important object we'll work with when doing
data science. To that end, let's learn some basics about vectors.

*Reading*: [Programming Basics](https://rstudio.cloud/learn/primers/1.2).
*Topics*: `vectors`
*Reading Time*: ~10 minutes




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

### __q1__ What single-letter `R` function do you use to create vectors with specific entries? Use that function to create a vector with the numbers `1, 2, 3` below.


```r
vec_q1 <- c(1, 2, 3)

vec_q1
```

```
## [1] 1 2 3
```

Use the following tests to check your work:


```r
## NOTE: No need to change this
assertthat::assert_that(length(vec_q1) == 3)
```

```
## [1] TRUE
```

```r
assertthat::assert_that(mean(vec_q1) == 2)
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

### __q2__ Did you know that you can use `c()` to *extend* a vector as well? Use this to add the extra entry `4` to `vec_q1`.


```r
vec_q2 <- c(vec_q1, 4)

vec_q2
```

```
## [1] 1 2 3 4
```

Use the following tests to check your work:


```r
## NOTE: No need to change this
assertthat::assert_that(length(vec_q2) == 4)
```

```
## [1] TRUE
```

```r
assertthat::assert_that(mean(vec_q2) == 2.5)
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

<!-- include-exit-ticket -->
