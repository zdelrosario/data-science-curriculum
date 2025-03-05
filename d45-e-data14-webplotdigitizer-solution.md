
# Data: Liberating data with WebPlotDigitizer

*Purpose*: Sometimes data are messy---we know how to deal with that. Other times data are "locked up" in a format we can't easily analyze, such as in an image. In this exercise you'll learn how to *liberate* data from a plot using WebPlotDigitizer.

*Reading*: (*None*, this exercise *is* the reading.)

*Optional Reading*: [WebPlotDigitizer tutorial video](https://youtu.be/P7GbGdMvopU) ~ 19 minutes. (I recommend you give this a watch if you want some inspiration on other use cases: There are a lot of very clever ways to use this tool!)


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

*Background*: [WebPlotDigitizer](https://automeris.io/WebPlotDigitizer/) is one of those tools that is *insanely useful*, but *no one ever teaches*. I didn't learn about this until six years into graduate school. You're going to learn some very practical skills in this exercise!

*Note*: I originally extracted these data from an [Economist](https://www.economist.com/graphic-detail/2020/05/13/the-spread-of-covid-has-caused-a-surge-in-american-meat-prices) article on American meat prices and production in 2020.

## Setup

### __q1__ Get WebPlotDigitizer.

Go to the [WebPlotDigitizer](https://automeris.io/WebPlotDigitizer/) website and download the desktop version (matching your operating system).

*Note*: On Mac OS X you may have to open `Security & Privacy` in order to launch WebPlotDigitizer on your machine.

## Extract

### __q2__ Extract the data from the following image:

![Beef production](./images/beef_production.png)

This image shows the percent change in US beef production as reported in this [Economist](https://www.economist.com/graphic-detail/2020/05/13/the-spread-of-covid-has-caused-a-surge-in-american-meat-prices) article. We'll go through extraction step-by-step:

1. Click the `Load Image(s)` button, and select `./images/beef_production.png`.

![Load image](./images/e-data14-load-image.png)
2. Choose the `2D (X-Y) Plot` type.

![Load image](./images/e-data14-plot-type.png)
3. Make sure to *read these instructions*!

![Load image](./images/e-data14-xy-instructions.png)
4. Place the four control points; it doesn't matter what *precise* values you pick, just that you know the X values for the first two, and the Y values for the second two.

*Note*: Once you've placed a single point, you can use the arrow keys on your keyboard to make *micro adjustments* to the point; this means *you don't have to be super-accurate* with your mouse. Use this to your advantage!

![Load image](./images/e-data14-xy-locations.png)
5. *Calibrate* the axes by entering the X and Y values you placed. Note that you can give decimals, dates, times, or exponents.

![Load image](./images/e-data14-xy-calibrate.png)
6. Now that you have a set of axes, you can *extract* the data. This plot is fairly high-contrast, so we can use the *Automatic Extraction* tools. Click on the `Box` setting, and select the foreground color to match the color of the data curve (in this case, black).

![Load image](./images/e-data14-automatic-box.png)

7. Once you've selected the box tool, draw a rectangle over an area containing the data. Note that if you cover the labels, the algorithm will try to extract those too!

![Load image](./images/e-data14-drawn-box.png)
8. Click the `Run` button; you should see red dots covering the data curve.

![Load image](./images/e-data14-extracted.png)

9. Now you can save the data to a file; make sure the dataset is selected (highlighted in orange) and click the `View Data` button.

![Load image](./images/e-data14-view-data.png)
10. Click the `Download .CSV` button and give the file a sensible name.

![Load image](./images/e-data14-download.png)
Congrats! You just *liberated* data from a plot!

### __q3__ Extract the data from the following plot. This will give you price data to compare against the production data.

![Beef price](./images/beef_price.png)

## Use the extracted data

### __q4__ Load the price and production datasets you extracted. Join and plot price vs production; what kind of relationship do you see?


``` r
## NOTE: Your filenames may vary!
df_price <- read_csv(
  "./data/beef_price.csv",
  col_names = c("date", "price_percent")
)
```

```
## Rows: 232 Columns: 2
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## dbl  (1): price_percent
## date (1): date
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

``` r
df_production <- read_csv(
  "./data/beef_production.csv",
  col_names = c("date", "production_percent")
)
```

```
## Rows: 227 Columns: 2
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## dbl  (1): production_percent
## date (1): date
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

``` r
## NOTE: I'm relying on WebPlotDigitizer to produce dates in order to
## make this join work. This will probably fail if you have numbers
## rather than dates.
df_both <-
  inner_join(
    df_price,
    df_production,
    by = "date"
  )
```

```
## Warning in inner_join(df_price, df_production, by = "date"): Detected an unexpected many-to-many relationship between `x` and `y`.
## ℹ Row 7 of `x` matches multiple rows in `y`.
## ℹ Row 2 of `y` matches multiple rows in `x`.
## ℹ If a many-to-many relationship is expected, set `relationship =
##   "many-to-many"` to silence this warning.
```

``` r
df_both %>%
  ggplot(aes(production_percent, price_percent, color = date)) +
  geom_point()
```

<img src="d45-e-data14-webplotdigitizer-solution_files/figure-html/q4-task-1.png" width="672" />

**Observations**:

- In the middle of the pandemic beef production dropped quickly without a large change in price.
- After production dropped by 20% beef price began to spike.
- As the pandemic continued in the US, beef production increased slightly, but price continued to rise.

<!-- include-exit-ticket -->
