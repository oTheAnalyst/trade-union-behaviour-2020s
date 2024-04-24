library(targets)
library(tarchetypes)


source("~/Lab4/functions/functions.R")
options(clustermq.scheduler = "multicore")

tar_option_set(
  packages = c(
    "tibble", "dplyr", "stringr", "readr",
    "ggplot2", "purrr", "magrittr", "DBI", "RSQLite", "forcats"
  )
)


dmv <- c("Maryland", "Virginia", "District of Columbia")

list(
  tar_target(
    data,
    load_data(data = "LAT-02.19.24"),
    format = "feather"
  ),
  tar_target(
    transformed_data,
    transform_data(data = data),
    format = "feather"
  ),
  tar_target(
    strikes_maryland,
    number_of(state_var = "Maryland", transformed_data),
    format = "fst"
  ),
  tar_target(
    strikes_virginia,
    number_of(state_var = "Virginia", transformed_data),
    format = "fst"
  ),
  tar_target(
    strikes_dc,
    number_of(state_var = "District of Columbia", transformed_data),
    format = "fst"
  ),
  tar_target(
    plot_states,
    plot_data(state_var = dmv, transformed_data),
    format = "fst"
  ),
  tar_target(
    plot_time_series_virginia,
    plot_time_series(data = strikes_virginia, state = "Virginia"),
    format = "fst")
  )
