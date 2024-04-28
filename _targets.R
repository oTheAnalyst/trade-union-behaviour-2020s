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
    strikes_virginia, number_of(state_var = "Virginia", transformed_data),
    format = "fst"
  ),
  tar_target(
    strikes_dc,
    number_of(state_var = "District of Columbia", transformed_data),
    format = "fst"
  ),
  tar_target(
    plot_virginia,
    make_plot_strikes(strikes_virginia, "Virginia")
  ),
  tar_target(
    plot_maryland,
    make_plot_strikes(strikes_dc, "Maryland")
  ),
  tar_target(
    plot_dc,
    make_plot_strikes(strikes_dc, "District of Columbia")
  )
)
