Setup: RStudio
================
Zach del Rosario
2020-05-02

*Purpose*: We’re going to make extensive use of the [R programming
language](https://www.r-project.org/about.html); in particular, the
[Tidyverse](https://www.tidyverse.org/) packages. This first exercise
will guide you through setting up the necessary software.

*Reading*: (None)

**q1** Install Rstudio

Download [RStudio
Desktop](https://rstudio.com/products/rstudio/download/) and install the
[R programming language](https://cran.rstudio.com/). Both are free\!

Once installed, you can [download the
source](https://github.com/zdelrosario/data-science-curriculum/blob/master/exercises/e-setup00-install-master.Rmd)
for this exercise and open open it in RStudio (or you can follow
`e-rep01-intro-git` and *clone* the repository). This is an `R Markdown`
file, which is a combination of human-readable text and machine-readable
code. Think of it as a modern take on a lab notebook.

**q2** Install packages

Next, run RStudio. When the program opens, you should see a console tab,
as in the image below.

![RStudio console](./images/rstudio-console.png)

Note that RStudio has multiple tabs, including the `Console`,
`Terminal`, `Jobs`, and any files you may have opened. Make sure you are
in the `Console` tab.

Type the line `install.packages("tidyverse")` in your `Console` and
press Enter. This will start the installation of the `tidyverse`
package, which we will use extensively in this class.

![RStudio package install](./images/rstudio-cli-install.png)

**q3** Test your install

Once your installation has finished, return to your console and use the
command `library(tidyverse)`. If your installation is complete, this
command should return a list of packages and version numbers, similar to
the image below.

![RStudio package install](./images/rstudio-cli-library.png)

If you have any issues with installation, **please** let me know\!

**q4** Download extras

We’ll use a number of extras for this class. To that end, please install
the following packages.

  - `curl`
  - `mvtnorm`
  - `nycflights13`
  - `gapminder`
  - `ggrepel`
  - `googlesheets4`
  - `viridis`

**q5** Download cheatsheets

The `tidyverse` is essentially a language built on top of R. As such,
there are a lot of functions to remember. To that end, RStudio has put
together a number of
[cheatsheets](https://rstudio.com/resources/cheatsheets/) to reference
when doing data science. Some of the most important ones are:

*Note*: These links often break! If they're not working, try checking the [Posit website](https://posit.co/resources/cheatsheets/), or just googling "Posit cheatsheets."

  - [Data
    visualization](https://posit.co/wp-content/uploads/2022/10/data-visualization-1.pdf)
  - [Data
    transformation](https://posit.co/wp-content/uploads/2022/10/data-transformation-1.pdf)
  - [Data
    importing](https://posit.co/wp-content/uploads/2022/10/data-import.pdf)

Later, we will learn special tools for handling:

  - [String data](https://posit.co/wp-content/uploads/2022/10/strings-1.pdf)
  - [Dates and times](https://posit.co/wp-content/uploads/2022/10/lubridate-1.pdf)
  - [Factors](https://posit.co/wp-content/uploads/2022/10/factors-1.pdf)
  - [R Markdown](https://posit.co/wp-content/uploads/2022/10/rmarkdown-1.pdf)

# Exit Ticket

<!-- -------------------------------------------------- -->

For every exercise, your deliverable will to complete an “exit ticket”.
Make sure to follow the survey link at the end of every exercise and
submit the survey to get credit for your work\! Note that in RStudio you
can Ctrl + Click (CMD + Click) to follow a link.

Once you have completed this exercise, make sure to fill out the **exit
ticket survey**, [linked
here](https://docs.google.com/forms/d/e/1FAIpQLSeuq2LFIwWcm05e8-JU84A3irdEL7JkXhMq5Xtoalib36LFHw/viewform?usp=pp_url&entry.693978880=e-setup00-install.Rmd).
