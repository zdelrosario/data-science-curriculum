
# Setup: Documentation

*Purpose*: No programmer memorizes every fact about every function. Expert
programmers get used to quickly reading *documentation*, which allows them to
look up the facts they need, when they need them. Just as you had to learn how
to read English, you will have to learn how to consult documentation. This
exercise will get you started.

*Reading*: [Getting help with R](https://www.r-project.org/help.html) (Vignettes and Code Demonstrations)


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

The `vignette()` function allows us to look up
[vignettes](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/vignette.html);
short narrative-form tutorials associated with a package, written by its
developers.

### __q1__ Use `vignette(package = ???)` (fill in the ???) to look up vignettes
associated with `"dplyr"`. What vignettes are available?


``` r
vignette(package = "dplyr")
```

The `dplyr` package has vignettes `compatibility`, `dplyr`, `programming`,
`two-table`, and `window-functions`. We'll cover many of these topics
in this course!

Once we know *what* vignettes are available, we can use the same function to
read a particular vignette.

### __q2__ Use `vignette(???, package = "dplyr")` to read the vignette on `dplyr`.
Read this vignette up to the first note on `filter()`. Use `filter()` to select
only those rows of the `iris` dataset where `Species == "setosa"`.

*Note*: This should open up your browser.


``` r
iris %>%
  as_tibble() %>%
  filter(
    # TODO: Filter on Species "setosa"
    Species == "setosa"
  )
```

```
## # A tibble: 50 × 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##           <dbl>       <dbl>        <dbl>       <dbl> <fct>  
##  1          5.1         3.5          1.4         0.2 setosa 
##  2          4.9         3            1.4         0.2 setosa 
##  3          4.7         3.2          1.3         0.2 setosa 
##  4          4.6         3.1          1.5         0.2 setosa 
##  5          5           3.6          1.4         0.2 setosa 
##  6          5.4         3.9          1.7         0.4 setosa 
##  7          4.6         3.4          1.4         0.3 setosa 
##  8          5           3.4          1.5         0.2 setosa 
##  9          4.4         2.9          1.4         0.2 setosa 
## 10          4.9         3.1          1.5         0.1 setosa 
## # ℹ 40 more rows
```

Vignettes are useful when we only know *generally* what we're looking for. Once
we know the verbs (functions) we want to use, we need more specific help.

### __q3__ Remember back to `e-setup02-functions`; how do we look up help for a
specific function?

We have a few options:

- We can use `?function` to look up the help for a function
- We can execute `function` (without parentheses) to show the source code

Sometimes we'll be working with a function, but we won't *quite* know how to get
it to do what we need. In this case, consulting the function's documentation can
be *extremely* helpful.

### __q4__ Use your knowledge of documentation lookup to answer the following
question: How could we `filter` the `iris` dataset to return only those rows
with `Sepal.Length` between `5.1` and `6.4`?


``` r
iris %>%
  as_tibble() %>%
  filter(
    5.1 <= Sepal.Length,
    Sepal.Length <= 6.4
  )
```

```
## # A tibble: 83 × 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##           <dbl>       <dbl>        <dbl>       <dbl> <fct>  
##  1          5.1         3.5          1.4         0.2 setosa 
##  2          5.4         3.9          1.7         0.4 setosa 
##  3          5.4         3.7          1.5         0.2 setosa 
##  4          5.8         4            1.2         0.2 setosa 
##  5          5.7         4.4          1.5         0.4 setosa 
##  6          5.4         3.9          1.3         0.4 setosa 
##  7          5.1         3.5          1.4         0.3 setosa 
##  8          5.7         3.8          1.7         0.3 setosa 
##  9          5.1         3.8          1.5         0.3 setosa 
## 10          5.4         3.4          1.7         0.2 setosa 
## # ℹ 73 more rows
```

We have at least two options:

- We can use two lines of filter
- We can use the helper function `between()`

On other occasions we'll know a function, but would like to know about other,
related functions. In this case, it's useful to be able to trace the `function`
back to its parent `package`. Then we can read the vignettes on the package to
learn more.

### __q5__ Look up the documentation on `cut_number`; what package does it come
from? What about `parse_number()`? What about `row_number()`?

* `ggplot2::cut_number()`
* `readr::parse_number()`
* `dplyr::row_number()`

<!-- include-exit-ticket -->
