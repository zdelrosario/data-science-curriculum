
# Setup: Function Basics

*Purpose*: Functions are our primary tool in carying out data analysis with the `tidyverse`. It is unreasonable to expect yourself to memorize every function and all its details. To that end, we'll learn some basic _function literacy_ in R; how to inspect a function, look up its documentation, and find examples on a function's use.

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

## Getting help

No programmer memorizes how *every single function* works. Instead, effective programmers get used to looking up *documentation*. In R this is easy; if there's a function we want to learn about, we can run `?function` in our console.

For instance, to get help on the `lm()` function, we could execute

`> ?lm`

*Note*: The `>` above is not part of the command; it automatically appears in our R console.
*Hint*: In RStudio, we can press `CTRL + 2` to switch focus to the R console.

Some functions are found in multiple packages; in this case, we need to click a link in the help panel. For instance, the following will open up a help panel with a few links:


``` r
?tibble
```

```
## Help on topic 'tibble' was found in the following packages:
## 
##   Package               Library
##   dplyr                 /home/runner/work/_temp/Library
##   tidyr                 /home/runner/work/_temp/Library
##   tibble                /home/runner/work/_temp/Library
## 
## 
## Using the first match ...
```

At this point, we should just pick a link, and go back if it's not relevant.

### __q1__ Read the docs

Get help on the built-in `rnorm` function.


``` r
?rnorm
```

## (Not) Executing functions

If we try to run a function without using parentheses, we get some odd behavior:


``` r
## NOTE: No need to edit; run and inspect
rbind
```

```
## function (..., deparse.level = 1) 
## .Internal(rbind(deparse.level, ...))
## <bytecode: 0x558f4d038808>
## <environment: namespace:base>
```

Calling the function this way shows its *source code*. This can sometimes be helpful for understanding, but isn't (usually) what we want out of our functions.

### __q2__ Show source code

Show the source code for `lm`.


``` r
lm
```

```
## function (formula, data, subset, weights, na.action, method = "qr", 
##     model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, 
##     contrasts = NULL, offset, ...) 
## {
##     ret.x <- x
##     ret.y <- y
##     cl <- match.call()
##     mf <- match.call(expand.dots = FALSE)
##     m <- match(c("formula", "data", "subset", "weights", "na.action", 
##         "offset"), names(mf), 0L)
##     mf <- mf[c(1L, m)]
##     mf$drop.unused.levels <- TRUE
##     mf[[1L]] <- quote(stats::model.frame)
##     mf <- eval(mf, parent.frame())
##     if (method == "model.frame") 
##         return(mf)
##     else if (method != "qr") 
##         warning(gettextf("method = '%s' is not supported. Using 'qr'", 
##             method), domain = NA)
##     mt <- attr(mf, "terms")
##     y <- model.response(mf, "numeric")
##     w <- as.vector(model.weights(mf))
##     if (!is.null(w) && !is.numeric(w)) 
##         stop("'weights' must be a numeric vector")
##     offset <- model.offset(mf)
##     mlm <- is.matrix(y)
##     ny <- if (mlm) 
##         nrow(y)
##     else length(y)
##     if (!is.null(offset)) {
##         if (!mlm) 
##             offset <- as.vector(offset)
##         if (NROW(offset) != ny) 
##             stop(gettextf("number of offsets is %d, should equal %d (number of observations)", 
##                 NROW(offset), ny), domain = NA)
##     }
##     if (is.empty.model(mt)) {
##         x <- NULL
##         z <- list(coefficients = if (mlm) matrix(NA_real_, 0, 
##             ncol(y)) else numeric(), residuals = y, fitted.values = 0 * 
##             y, weights = w, rank = 0L, df.residual = if (!is.null(w)) sum(w != 
##             0) else ny)
##         if (!is.null(offset)) {
##             z$fitted.values <- offset
##             z$residuals <- y - offset
##         }
##     }
##     else {
##         x <- model.matrix(mt, mf, contrasts)
##         z <- if (is.null(w)) 
##             lm.fit(x, y, offset = offset, singular.ok = singular.ok, 
##                 ...)
##         else lm.wfit(x, y, w, offset = offset, singular.ok = singular.ok, 
##             ...)
##     }
##     class(z) <- c(if (mlm) "mlm", "lm")
##     z$na.action <- attr(mf, "na.action")
##     z$offset <- offset
##     z$contrasts <- attr(x, "contrasts")
##     z$xlevels <- .getXlevels(mt, mf)
##     z$call <- cl
##     z$terms <- mt
##     if (model) 
##         z$model <- mf
##     if (ret.x) 
##         z$x <- x
##     if (ret.y) 
##         z$y <- y
##     if (!qr) 
##         z$qr <- NULL
##     z
## }
## <bytecode: 0x558f509a94b8>
## <environment: namespace:stats>
```

## Executing functions (for real)

To actually run a function, we need to call it with parentheses `()` and provide all of its required *arguments*. Arguments are inputs to a function.

One simple---but important---function in R is the `c()` function: This takes multiple items and combines them into a vector.


``` r
c(1, 2, 3)
```

```
## [1] 1 2 3
```

Note that `c()` takes a variable number of arguments; we can pass as many values as we need to,


``` r
c(1, 2, 3, 4, 5, 6, 7, 8)
```

```
## [1] 1 2 3 4 5 6 7 8
```

Other functions take a specific number of arguments, such as `seq()`, which builds a sequence of values:


``` r
seq(1, 10)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

*Aside*: If you're familiar with other programming languages (like Python), R might offend your aesthetic sensibilities. In R, we can *optionally* specify the argument name for positional arguments; for instance, the following allows works:


``` r
seq(from = 1, to = 10)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

Many functions have *optional arguments*: These functions have reasonable default values, which we can override to get different behavior. For instance, the `seq` function allows us to specify the "stride" of our sequence with a `by` argument:


``` r
seq(1, 10, by = 2)
```

```
## [1] 1 3 5 7 9
```

The best way to figure out what arguments a function requires is to *read its documentation*.

*Nerdy aside*: Computer scientists draw a distinction between "parameters" and "arguments"---there's a [Wikipedia article](https://en.wikipedia.org/wiki/Parameter_(computer_programming)) about this.

### __q3__ Read the docs

Using either the documentation or the source, determine the arguments for `rnorm`.

The arguments for `rnorm` are:

- `n`: The number of samples to draw
- `mean`: The mean of the normal
- `sd`: The standard deviation of the normal

### __q4__ Call the function

Using what you learned in q3, generate a random sample of size `n = 10` using `rnorm`.


``` r
rnorm(n = 10)
```

```
##  [1] -0.03655571 -0.66874100  0.66273868 -2.52489615 -1.17911786 -0.01955648
##  [7]  0.03848138 -0.87564319  0.89895976  0.12306200
```

## Adapting examples

Practically, one of the best ways to use a function is to find an *example* that's close to your intended use, and adapt that example. R documentation tends to be very good with many relevant examples. The examples are often at the *bottom* of the documentation, so sometimes it's best to just scroll to the bottom and check the examples.

### __q5__ Adapt an example

Look up the documentation for the function `tribble`, and figure out how to create the following data.

| u | w |
|---|---|
| 1 | 2 |
| 3 | 4 |

*Hint*: Adapt an example!


``` r
tribble(
  ~u, ~w,
   1,  2,
   3,  4
)
```

```
## # A tibble: 2 × 2
##       u     w
##   <dbl> <dbl>
## 1     1     2
## 2     3     4
```


<!-- include-exit-ticket -->
