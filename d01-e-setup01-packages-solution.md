
# Setup: Packages

*Purpose*: Every time you start an analysis, you will need to *load packages*.
This is a quick warmup to get you in this habit.

*Reading*: (None)

**Note**: If you open this `.Rmd` file in RStudio you can *execute* the chunks of code (stuff between triple-ticks) by clicking on the green arrow to the top-right of the chunk, or by placing your cursor within a chunk (between the ticks) and pressing `Ctrl + Shift + Enter`. See [here](https://rmarkdown.rstudio.com/authoring_quick_tour.html) for a brief introduction to RMarakdown files. Note that in RStudio you can Shift + Click (CMD + Click) to follow a link.



### __q1__ Create a new code chunk and prepare to load the `tidyverse`.

In [RStudio](https://bookdown.org/yihui/rmarkdown/r-code.html) use the shortcut
`Ctrl + Alt + I` (`Cmd + Option + I` on Mac). Type the command
`library(tidyverse`).


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

Make sure to load packages at the *beginning* of your notebooks! This is a
best-practice.

### __q2__ Run the chunk with `library(tidyverse)`. What packages are loaded?

In
[RStudio](https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts)
press `Ctrl + Alt + T` (`Cmd + Option + T` on Mac) to run the code chunk at your
cursor.

ggplot2, tibble, tidyr, readr, purrr, dplyr, stringr, forcats

### __q3__ What are the main differences between `install.packages()` and `library()`? How often do you need to call each one?

`install.packages()` downloads and installs packages into R's library of
packages on your computer. After a package is installed, it is available for
use, but not loaded to use. `library()` loads a package from the library for
use. The package remains loaded until your session ends, such as when you
quit R. You only need to call `install.packages()` once. You need to call
`library()` for each new session.

Packages are frequently updated. You can check for updates and update your
packages by using the Update button in the Packages tab of RStudio (lower
right pane).

<!-- include-exit-ticket -->
