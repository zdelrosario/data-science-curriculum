
# Vis: Scatterplots and Layers

*Purpose*: *Scatterplots* are a key tool for EDA. Scatteplots help us inspect the relationship between two variables. To enhance our scatterplots, we'll learn how to use *layers* in ggplot to add multiple pieces of information to our plots.

*Reading*: [Scatterplots](https://rstudio.cloud/learn/primers/3.5)
*Topics*: (All topics)
*Reading Time*: ~40 minutes




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

```r
library(ggrepel)
```

## A Note on Layers
<!-- -------------------------------------------------- -->

In the reading we learned about *layers* in ggplot. Formally, ggplot is a
"layered grammar of graphics"; each layer has the option to use built-in or
inherited defaults, or override those defaults. There are two major settings we
might want to change: the source of `data` or the `mapping` which defines the
aesthetics. If we're being verbose, we write a ggplot call like:


```r
## NOTE: No need to modify! Just example code
ggplot(
  data = mpg,
  mapping = aes(x = displ, y = hwy)
) +
  geom_point()
```

<img src="d18-e-vis04-scatterplot-solution_files/figure-html/exposition-1-1.png" width="672" />

However, ggplot makes a number of sensible defaults to help save us typing.
Ggplot assumes an order for `data, mapping`, so we can drop the keywords:


```r
## NOTE: No need to modify! Just example code
ggplot(
  mpg,
  aes(x = displ, y = hwy)
) +
  geom_point()
```

<img src="d18-e-vis04-scatterplot-solution_files/figure-html/exposition-2-1.png" width="672" />

Similarly the aesthetic function `aes()` assumes the first two arguments will be
`x, y`, so we can drop those arguments as well


```r
## NOTE: No need to modify! Just example code
ggplot(
  mpg,
  aes(displ, hwy)
) +
  geom_point()
```

<img src="d18-e-vis04-scatterplot-solution_files/figure-html/exposition-3-1.png" width="672" />

Above `geom_point()` inherits the `mapping` from the base `ggplot` call;
however, we can override this. This can be helpful for a number of different
purposes:


```r
## NOTE: No need to modify! Just example code
ggplot(mpg, aes(x = displ)) +
  geom_point(aes(y = hwy, color = "hwy")) +
  geom_point(aes(y = cty, color = "cty"))
```

<img src="d18-e-vis04-scatterplot-solution_files/figure-html/exposition-4-1.png" width="672" />

Later, we'll learn more concise ways to construct graphs like the one above. But
for now, we'll practice using layers to add more information to scatterplots.

## Exercises
<!-- -------------------------------------------------- -->

### __q1__ Add two `geom_smooth` trends to the following plot. Use "gam" for one
trend and "lm" for the other. Comment on how linear or nonlinear the "gam" trend
looks.


```r
diamonds %>%
  ggplot(aes(carat, price)) +
  geom_point() +
  geom_smooth(aes(color = "gam"), method = "gam") +
  geom_smooth(aes(color = "lm"), method = "lm")
```

```
## `geom_smooth()` using formula 'y ~ s(x, bs = "cs")'
```

```
## `geom_smooth()` using formula 'y ~ x'
```

<img src="d18-e-vis04-scatterplot-solution_files/figure-html/q1-task-1.png" width="672" />

**Observations**:
- No; the "gam" trend curves below then above the linear trend

### __q2__ Add non-overlapping labels to the following scattterplot using the
provided `df_annotate`.

*Hint 1*: `geom_label_repel` comes from the `ggrepel` package. Make sure to load
it, and adhere to best-practices!

*Hint 2*: You'll have to use the `data` keyword to override the data layer!


```r
## TODO: Use df_annotate below to add text labels to the scatterplot
df_annotate <-
  mpg %>%
  group_by(class) %>%
  summarize(
    displ = mean(displ),
    hwy = mean(hwy)
  )

mpg %>%
  ggplot(aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_label_repel(
    data = df_annotate,
    aes(label = class, fill = class)
  )
```

<img src="d18-e-vis04-scatterplot-solution_files/figure-html/q2-task-1.png" width="672" />

### __q3__ Study the following scatterplot: Note whether city (`cty`) or highway
(`hwy`) mileage tends to be greater. Describe the trend (visualized by
`geom_smooth`) in mileage with engine displacement (a measure of engine size).

*Note*: The grey region around the smooth trend is a *confidence bound*; we'll
discuss these further as we get deeper into statistical literacy.


```r
## NOTE: No need to modify! Just analyze the scatterplot
mpg %>%
  pivot_longer(names_to = "source", values_to = "mpg", c(hwy, cty)) %>%
  ggplot(aes(displ, mpg, color = source)) +
  geom_point() +
  geom_smooth() +
  scale_color_discrete(name = "Mileage Type") +
  labs(
    x = "Engine displacement (liters)",
    y = "Mileage (mpg)"
  )
```

```
## `geom_smooth()` using method = 'loess' and formula 'y ~ x'
```

<img src="d18-e-vis04-scatterplot-solution_files/figure-html/q3-task-1.png" width="672" />

**Observations**:
- `hwy` mileage tends to be larger; driving on the highway is more efficient
- Mileage tends to decrease with engine size; cars with larger engines tend to be less efficient

## Aside: Scatterplot vs bar chart
<!-- -------------------------------------------------- -->

Why use a scatterplot vs a bar chart? A bar chart is useful for emphasizing some *threshold*. Let's look at a few examples:

## Raw populations
<!-- ------------------------- -->

Two visuals of the same data:


```r
economics %>%
  filter(date > lubridate::ymd("2010-01-01")) %>%
  ggplot(aes(date, pop)) +
  geom_col()
```

<img src="d18-e-vis04-scatterplot-solution_files/figure-html/vis-bar-raw-1.png" width="672" />

Here we're emphasizing zero, so we don't see much of a change


```r
economics %>%
  filter(date > lubridate::ymd("2010-01-01")) %>%
  ggplot(aes(date, pop)) +
  geom_point()
```

<img src="d18-e-vis04-scatterplot-solution_files/figure-html/vis-point-raw-1.png" width="672" />

Here's we're not emphasizing zero; the scale is adjusted to emphasize the trend in the data.

## Population changes
<!-- ------------------------- -->

Two visuals of the same data:


```r
economics %>%
  mutate(pop_delta = pop - lag(pop)) %>%
  filter(date > lubridate::ymd("2005-01-01")) %>%
  ggplot(aes(date, pop_delta)) +
  geom_col()
```

<img src="d18-e-vis04-scatterplot-solution_files/figure-html/vis-bar-change-1.png" width="672" />

Here we're emphasizing zero, so we can easily see the month of negative change.


```r
economics %>%
  mutate(pop_delta = pop - lag(pop)) %>%
  filter(date > lubridate::ymd("2005-01-01")) %>%
  ggplot(aes(date, pop_delta)) +
  geom_point()
```

<img src="d18-e-vis04-scatterplot-solution_files/figure-html/vis-point-change-1.png" width="672" />

Here we're not emphasizing zero; we can easily see the outlier month, but we have to read the axis to see that this is a case of negative growth.

For more, see [Bars vs Dots](https://dcl-data-vis.stanford.edu/discrete-continuous.html#bars-vs.-dots).

<!-- include-exit-ticket -->