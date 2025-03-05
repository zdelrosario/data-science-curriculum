
# Stats: Moment Arithmetic

*Purpose*: In a future exercise, we will need to be able to do some basic arithmetic with *moments* of a distribution. To prepare for this later exercise, we'll do some practice now.

*Reading*: (None, this is the reading)

*Topics*: Moments, moment arithmetic, standardization

## Moments
<!-- -------------------------------------------------- -->

Moments are a particular kind of statistic. There is a general, mathematical definition of a [moment](https://en.wikipedia.org/wiki/Moment_(mathematics)), but we will only need to talk about two in this class.

We've already seen the *mean*; this is also called the expectation. For a random variable $X$, the expectation is defined in terms of its pdf $\rho(x)$ via

$$\mathbb{E}[X] = \int x \rho(x) dx.$$

We've also seen the standard deviation $\sigma$. This is related to the variance $\sigma^2$, which is defined for a random variable $X$ in terms of the expectation

$$\sigma^2 \equiv \mathbb{V}[X] = \mathbb{E}[(X - \mathbb{E}[X])^2].$$
For instance, a standard normal $Z$ has

$$ \begin{aligned}
  \mathbb{E}[Z] &= 0 \\
  \mathbb{V}[Z] &= 1
 \end{aligned} $$

For future exercises, we'll need to learn how to do basic arithmetic with these two moments.

## Moment Arithmetic
<!-- -------------------------------------------------- -->

We will need to be able to do some basic arithmetic with the mean and variance. The following exercises will help you remember this basic arithmetic.

## Expectation
<!-- ------------------------- -->

The expectation is *linear*, that is

$$\mathbb{E}[aX + c] = a \mathbb{E}[X] + c.$$

We can use this fact to compute the mean of simply transformed random variables.

### __q1__ 

Compute the mean of $2 Z + 3$, where $Z$ is a standard normal.


``` r
## TASK: Compute the mean of 2 Z + 3
E_q1 <- 3
```

Use the following test to check your answer.


``` r
## NOTE: No need to change this!
assertthat::assert_that(assertthat::are_equal(E_q1, 3))
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

Since the expectation is linear, it also satisfies

$$\mathbb{E}[aX + bY] = a \mathbb{E}[X] + b \mathbb{E}[Y].$$

### __q2__ 

Compute the mean of $2 Z_1 + 3 Z_2$, where $Z_1, Z_2$ are separate standard normals.


``` r
## TASK: Compute the mean of 2 Z1 + 3 Z2
E_q2 <- 2 * 0 + 3 * 0
```

Use the following test to check your answer.


``` r
## NOTE: No need to change this!
assertthat::assert_that(assertthat::are_equal(E_q2, 0))
```

```
## [1] TRUE
```

``` r
print("Great!")
```

```
## [1] "Great!"
```

## Variance
<!-- ------------------------- -->

Remember that variance is the square of standard deviation. Variance satisfies the property

$$\mathbb{V}[aX + c] = a^2 \mathbb{V}[X].$$

### __q3__ 

Compute the variance of $2 Z + 3$, where $Z$ is a standard normal.


``` r
## TASK: Compute the mean of 2 Z + 3
V_q3 <- 2 ^ 2
```

Use the following test to check your answer.


``` r
## NOTE: No need to change this!
assertthat::assert_that(assertthat::are_equal(V_q3, 4))
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

The variance of a *sum* of random variables is a bit more complicated

$$\mathbb{V}[aX + bY] = a^2 \mathbb{V}[X] + b^2 \mathbb{V}[Y] + 2ab \text{Cov}[X, Y],$$
where $\text{Cov}[X, Y]$ denotes the [covariance](https://en.wikipedia.org/wiki/Covariance) of $X, Y$. Covariance is closely related to correlation, which we discussed in `e-stat03-descriptive`. If two random variables $X, Y$ are *uncorrelated*, then $\text{Cov}[X, Y] = 0$.

### __q4__ 

Compute the variance of $2 Z_1 + 3 Z_2$, where $Z_1, Z_2$ are *uncorrelated* standard normals.


``` r
## TASK: Compute the variance of 2 Z1 + 3 Z2
V_q4 <- 2^2 + 3^2
```

Use the following test to check your answer.


``` r
## NOTE: No need to change this!
assertthat::assert_that(assertthat::are_equal(V_q4, 13))
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

## Standardization
<!-- ------------------------- -->

The following two exercises illustrate two important transformations.

### __q5__ 

Compute the mean and variance of $(X - 1) / 2$, where

$$\mathbb{E}[X] = 1, \mathbb{V}[X] = 4$$.


``` r
## TASK: Compute the mean and variance
E_q3 <- 0
V_q3 <- 1
```

Use the following test to check your answer.


``` r
## NOTE: No need to change this!
assertthat::assert_that(assertthat::are_equal(E_q3, 0))
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(assertthat::are_equal(V_q3, 1))
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

This process of centering (setting the mean to zero) and scaling a random variable is called *standardization*. For instance, if $X$ is a normal random variable, then $(X - \mu) / \sigma = Z$ is a standard normal.

### __q6__ 

Compute the mean and variance of $1 + 2 Z$, where $Z$ is a standard normal.


``` r
## TASK: Compute the mean and variance
E_q4 <- 1
V_q4 <- 4
```

Use the following test to check your answer.


``` r
## NOTE: No need to change this!
assertthat::assert_that(assertthat::are_equal(E_q4, 1))
```

```
## [1] TRUE
```

``` r
assertthat::assert_that(assertthat::are_equal(V_q4, 4))
```

```
## [1] TRUE
```

``` r
print("Excellent!")
```

```
## [1] "Excellent!"
```

This example illustrates that we can create a normal with desired mean and standard deviation by transforming a standard normal $\mu + \sigma Z = X$.

## Standard Error
<!-- ------------------------- -->

The variance satisfies the property

$$\mathbb{V}[aX + bY] = a^2 \mathbb{V}[X] + b^2 \mathbb{V}[Y] + 2 \text{Cov}[X, Y],$$

where

$$\text{Cov}[X, Y] = \mathbb{E}[(X - \mathbb{E}[X])(Y - \mathbb{E}[Y])]$$

is the *covariance* between $X$ and $Y$. If $X, Y$ are independent, then the covariance between them is zero.

Using this expression, we can prove that the standard error of the sample mean $\overline{X}$ is $\sigma / \sqrt{n}$.

### __q7__ (Bonus) Prove an equality

Use the identity above to prove that,

$$\mathbb{V}[\overline{X}] = \sigma^2 / n,$$

where $$\overline{X} = \frac{1}{n}\sum_{i=1}^n X_i$$, $\sigma^2 = \mathbb{V}[X]$, and the $X_i$ are mutually independent.

The quantity

$$\sqrt{\mathbb{V}[\overline{X}]}$$

is called the *standard error of the mean*; more generally the *standard error* for a statistic is the standard deviation of its sampling distribution. We saw this idea in `e-stat04-population`, and will return to it in `e-stat07-clt`.

<!-- include-exit-ticket -->
