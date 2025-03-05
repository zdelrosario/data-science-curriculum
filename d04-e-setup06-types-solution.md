
# Setup: Types

*Purpose*: Vectors can hold data of only one *type*. While this isn't a course on computer science, there are some type "gotchas" to look out for when doing data science. This exercise will help us get ahead of those issues.

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

## Data Types

Any time we store data in a computer, we need to work with *types*. A type is a system for representing a class of data inside our computer. Types are important because they can muck up our analysis. For instance, we obviously can't perform addition with the number 1 and the letter "a"


``` r
## No need to edit; uncomment and run
# "a" + 1
```

However, we *can* "add" the letter "a" and the *string* "1":


``` r
str_c("a", "1")
```

```
## [1] "a1"
```

Thankfully, there are only a few data types we need to care about:

- *Floating point numbers* allow us to represent decimal values. This is the default type for numbers in R.
- *Integers* are integers (they have no decimal value). To specify an integer, we have to include an `L` character; for instance, `1L`.
- *Booleans* are 1's and 0's. In R we specify these using `TRUE` and `FALSE`, which are the same as `1` and `0`:


``` r
TRUE == 1
```

```
## [1] TRUE
```

``` r
FALSE == 0
```

```
## [1] TRUE
```


- *Strings* can include just about any kind of character, so long as we enclose them with a pair of quotation marks "":


``` r
nihongo <- "私は大学生です" # "I'm a college student"
nihongo
```

```
## [1] "私は大学生です"
```

### Variables vs Strings

One common issue is confusing a *string* with a *variable name*. This is further complicated by the fact that we can store strings *in* variables.

### __q1__ Describe what is wrong with the code below.


``` r
## TASK: Describe what went wrong here
## Set our airport
airport <- "BOS"

## Check our airport value
airport == ATL
```

**Observations**:

- `ATL` (without quotes) is trying to refer to an object (variable); we would need to write `"ATL"` (with quotes) to produce a string.

## Casting

Sometimes our data will not be in the form we want; in this case we may need to *cast* the data to another format.

- `as.integer(x)` converts to integer
- `as.numeric(x)` converts to real (floating point)
- `as.character(x)` converts to character (string)
- `as.logical(x)` converts to logical (boolean)
- `as.factor(x)` converts to a factor (fixed values)

For example, sometimes our numerical data gets loaded as a string, in which case we'll need to cast it back to numbers.

### __q2__ Cast the following vector `v_string` to integers.


``` r
v_string <- c("00", "45", "90")
v_integer <- as.integer(v_string)
```

Use the following test to check your work.


``` r
## NOTE: No need to change this!
assertthat::assert_that(
  assertthat::are_equal(
                v_integer,
                c(0L, 45L, 90L)
  )
)
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

## Statistical "types"

In addition to computer science data types, we will talk about variables in terms that statisticians use. There are only a few key "statistical types":

- **Continuous variables** can have infinitely small differences between values, such as real numbers.
- **Discrete variables** have a minimum difference between values, such as integers.
- **Factors** (or **categoricals**) take only one of a fixed set of values. This could be a set of numbers {1, 2, 3}, or a set of categories {red, blue, green}. 
  - The fixed set of values are sometimes called *factor levels*.

<!-- include-exit-ticket -->
