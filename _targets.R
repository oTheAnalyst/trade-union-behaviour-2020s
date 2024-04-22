library(targets)
library(tarchetypes)

source("functions/functions.R")
options(clustermq.scheduler = "multicore")

tar_option_set(
  packages = c(
    "tibble", "dplyr", "stringr",
    "ggplot2", "purrr", "magrittr", "DBI", "RSQLite"
  )
)

list(
  tar_target(
            file,
            load_data(),
            format = 'qs'
  ),
  tar_target(
             file,
             transform_data(),
             format = 'qs'

  ),
  tar_target(
             "Maryland",
             plot_data(),
             format = 'qs'
  )
)
