
# Stats: Fitting Distributions

*Purpose*: We use distributions to model random quantities. However, in order to model physical phenomena, we should *fit* the distributions using data. In this short exercise you'll learn some functions for fitting distributions to data.


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
library(MASS)
```

```
## 
## Attaching package: 'MASS'
```

```
## The following object is masked from 'package:dplyr':
## 
##     select
```

```r
library(broom)
```

## Aside: Masking

Note that when we load the `MASS` and `tidyverse` packages, we will find that their functions *conflict*. To deal with this, we'll need to learn how to specify a *namespace* when calling a function. To do this, use the `::` notation; i.e. `namespace::function`. For instance, to call `filter` from `dplyr`, we would write `dplyr::filter()`.

One of the specific conflicts between `MASS` and `tidyverse` is the `select` function. Try running the chunk below; it will throw an error:


```r
diamonds %>%
  select(carat, cut) %>%
  glimpse()
```

This error occurs because `MASS` *also* provides a `select` function.

### __q0__ Fix the following code!

Use the namespace `::` operator to use the correct `select()` function.


```r
diamonds %>%
  dplyr::select(carat, cut) %>%
  glimpse()
```

```
## Rows: 53,940
## Columns: 2
## $ carat <dbl> 0.23, 0.21, 0.23, 0.29, 0.31, 0.24, 0.24, 0.26, 0.22, 0.23, 0.30…
## $ cut   <ord> Ideal, Premium, Good, Premium, Good, Very Good, Very Good, Very …
```


## Distribution Parameters and Fitting

The function `rnorm()` requires values for `mean` and `sd`; while `rnorm()` has
defaults for these arguments, if we are trying to model a random event in the
real world, we should set `mean, sd` based on data. The process of estimating
parameters such as `mean, sd` for a distribution is called *fitting*. Fitting a
distribution is often accomplished through [*maximum likelihood
estimation*](https://en.wikipedia.org/wiki/Maximum_likelihood_estimation) (MLE);
rather than discuss the gory details of MLE, we will simply use MLE as a
technology to do useful work.

First, let's look at an example of MLE carried out with the function `MASS::fitdistr()`.


```r
## NOTE: No need to edit this setup
set.seed(101)
df_data_norm <- tibble(x = rnorm(50, mean = 2, sd = 1))

## NOTE: Example use of fitdistr()
df_est_norm <-
  df_data_norm %>%
  pull(x) %>%
  fitdistr(densfun = "normal") %>%
  tidy()

df_est_norm
```

```
## # A tibble: 2 × 3
##   term  estimate std.error
##   <chr>    <dbl>     <dbl>
## 1 mean     1.88     0.131 
## 2 sd       0.923    0.0923
```

*Notes*:

- `fitdistr()` takes a *vector*; I use the function `pull(x)` to pull the vector `x` out of the dataframe.
- `fitdistr()` returns a messy output; the function `broom::tidy()` automagically cleans up the output and provides a tibble.

### __q1__ Compute the sample mean and standard deviation of `x` in `df_data_norm`. Compare these values to those you computed with `fitdistr()`.


```r
## TASK: Compute the sample mean and sd of `df_data_norm %>% pull(x)`
mean_est <- df_data_norm %>% pull(x) %>% mean()
sd_est <- df_data_norm %>% pull(x) %>% sd()
mean_est
```

```
## [1] 1.876029
```

```r
sd_est
```

```
## [1] 0.9321467
```

**Observations**:

- The values are exactly the same!

Estimating parameters for a normal distribution is easy because it is parameterized in terms of the mean and standard deviation. The advantage of using `fitdistr()` is that it will allow us to work with a much wider selection of distribution models.

### __q2__ Use the function `fitdistr()` to fit a `"weibull"` distribution to the realizations `y` in `df_data_weibull`.

*Note*: The [weibull distribution](https://en.wikipedia.org/wiki/Weibull_distribution) is used to model many physical phenomena, including the strength of composite materials.


```r
## NOTE: No need to edit this setup
set.seed(101)
df_data_weibull <- tibble(y = rweibull(50, shape = 2, scale = 4))

## TASK: Use the `fitdistr()` function to estimate parameters
df_q2 <-
  df_data_weibull %>%
  pull(y) %>%
  fitdistr(densfun = "weibull") %>%
  tidy()
df_q2
```

```
## # A tibble: 2 × 3
##   term  estimate std.error
##   <chr>    <dbl>     <dbl>
## 1 shape     2.18     0.239
## 2 scale     4.00     0.274
```

Once we've fit a distribution, we can use the estimated parameters to approximate quantities like probabilities. If we were using the distribution for `y` to model a material strength, we would estimate probabilities to compute the rate of failure for mechanical components---we could then use this information to make design decisions.

### __q3__ Extract the estimates `shape_est` and `scale_est` from `df_q2`, and use them to estimate the probability that `Y <= 2`.

*Hint*: `pr_true` contains the true probability; modify that code to compute the estimated probability.


```r
## NOTE: No need to modify this line
pr_true <- pweibull(q = 2, shape = 2, scale = 4)

set.seed(101)
shape_est <-
  df_q2 %>%
  filter(term == "shape") %>%
  pull(estimate)
scale_est <-
  df_q2 %>%
  filter(term == "scale") %>%
  pull(estimate)

pr_est <- pweibull(q = 2, shape = shape_est, scale = scale_est)

pr_true
```

```
## [1] 0.2211992
```

```r
pr_est
```

```
## [1] 0.1988446
```

You'll probably find that `pr_true != pr_est`! As we saw in `e-stat06-clt` we should really compute a *confidence interval* to assess our degree of confidence in this probability estimate. However, it's not obvious how we can use the ideas of the Central Limit Theorem to put a confidence interval around `pr_est. In the next exercise we'll learn a very general technique for estimating confidence intervals.

<!-- include-exit-ticket -->

## Notes
<!-- -------------------------------------------------- -->

[1] For another tutorial on fitting distributions in R, see this [R-bloggers](https://www.r-bloggers.com/fitting-distributions-with-r/) post.
