library(targets)
library(tarchetypes)

source("~/Lab4/functions/functions.R")
options(clustermq.scheduler = "multicore")

tar_option_set(
  packages = c(
    "tibble", "dplyr", "stringr",
    "ggplot2", "purrr", "magrittr", "DBI", "RSQLite"
  )
)


dmv <- c("Maryland","Virginia","Disctrict of Columbia")

list(
  tar_target(
    data,
    load_data(data = "LAT-02.19.24"),
    format = "qs"
  ),
  tar_target(
    transformed_data,
    transform_data(data = data),
    format = "qs"),
  tar_target(
    plot_states,
    plot_data(state_var = dmv, transformed_data),
    format = "qs"
  )
)

