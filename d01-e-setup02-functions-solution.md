
# Setup: Function Basics

*Purpose*: Functions are our primary tool in carying out data analysis with the
`tidyverse`. It is unreasonable to expect yourself to memorize every function
and all its details. To that end, we'll learn some basic _function literacy_ in
R; how to inspect a function, look up its documentation, and find examples on a
function's use.

*Reading*: [Programming Basics](https://rstudio.cloud/learn/primers/1.2).
*Topics*: `functions`, `arguments`
*Reading Time*: ~ 10 minutes

### __q1__ How do you find help on a function? Get help on the built-in `rnorm` function.


```r
?rnorm
```

### __q2__ How do you show the source code for a function?


```r
rnorm
```

```
## function (n, mean = 0, sd = 1) 
## .Call(C_rnorm, n, mean, sd)
## <bytecode: 0x7ff13792ac88>
## <environment: namespace:stats>
```

### __q3__ Using either the documentation or the source, determine the arguments for `rnorm`.

The arguments for `rnorm` are:

- `n`: The number of samples to draw
- `mean`: The mean of the normal
- `sd`: The standard deviation of the normal

### __q4__ Scroll to the bottom of the help for the `library()` function. How do you
list all available packages?

Calling `library()` without arguments lists all the available packages.

The __examples__ in the help documentation are often *extremely* helpful for
learning how to use a function (or reminding yourself how its used)! Get used to
checking the examples, as they're a great resource.

<!-- include-exit-ticket -->
