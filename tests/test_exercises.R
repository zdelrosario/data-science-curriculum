library(magrittr)

## Setup
dir_ex <- "../exercises"

str_file <- Vectorize(function(filename) {
  readChar(filename, file.info(filename)$size)
})

## Read all exercises master files, compute statistics
df_ex_all <- 
  tibble::tibble(file = list.files(dir_ex, full.names = TRUE)) %>%
  dplyr::filter(
    stringr::str_detect(file, "master"),
    stringr::str_detect(file, "Rmd$")
  ) %>%
  dplyr::mutate(
    text = str_file(file),

    n_html_sb = stringr::str_count(text, "<\\!-- solution-begin -->"),
    n_html_se = stringr::str_count(text, "<\\!-- solution-end -->"),
    n_code_sb = stringr::str_count(text, "\\# solution-begin"),
    n_code_se = stringr::str_count(text, "\\# solution-end"),

    n_html_tb = stringr::str_count(text, "<\\!-- task-begin -->"),
    n_html_te = stringr::str_count(text, "<\\!-- task-end -->"),
    n_code_tb = stringr::str_count(text, "\\# task-begin"),
    n_code_te = stringr::str_count(text, "\\# task-end"),

    test_s_html = n_html_sb == n_html_se,
    test_s_code = n_code_sb == n_code_se,
    test_t_html = n_html_tb == n_html_te,
    test_t_code = n_code_tb == n_code_te,

    test_exit = stringr::str_detect(text, "<\\!-- include-exit-ticket -->")
  ) 

## Test exercises
purrr::pmap(
  df_ex_all %>% dplyr::select(file, test_s_html),
  function(file, test_s_html) {
    testthat::test_that(stringr::str_c("HTML solution comments match", file), {
      testthat::expect_true(test_s_html)
    })
  }
)

purrr::pmap(
  df_ex_all %>% dplyr::select(file, test_t_html),
  function(file, test_t_html) {
    testthat::test_that(stringr::str_c("HTML task comments match", file), {
      testthat::expect_true(test_t_html)
    })
  }
)

purrr::pmap(
  df_ex_all %>% dplyr::select(file, test_s_code),
  function(file, test_s_code) {
    testthat::test_that(stringr::str_c("Code solution comments match", file), {
      testthat::expect_true(test_s_code)
    })
  }
)

purrr::pmap(
  df_ex_all %>% dplyr::select(file, test_t_code),
  function(file, test_t_code) {
    testthat::test_that(stringr::str_c("Code task comments match", file), {
      testthat::expect_true(test_t_code)
    })
  }
)

purrr::pmap(
  df_ex_all %>% dplyr::select(file, test_exit),
  function(file, test_exit) {
    testthat::test_that(stringr::str_c("Exit ticket included", file), {
      testthat::expect_true(test_exit)
    })
  }
)
