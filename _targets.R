setwd("~/Lab4/")
library(targets)
library(tarchetypes)
source("~/Lab4/functions/functions.R")
options(clustermq.schedular = "multicore")
tar_option_set(
  packages = c(
    "tibble", "dplyr", "stringr", "readr", "readxl",
    "ggplot2", "purrr", "lubridate", "DBI", "RSQLite", "readr"
  ), format = "rds"
)

list(
  tar_target(
    transformed_,
    load_and_transform_data(4),
    format = "rds"
  ),
  tar_target(
    dc_data,
    number_of("District of Columbia", transformed_),
    format = "rds"
  ),
  tar_target(
    md_data,
    number_of("Maryland", transformed_),
    format = "rds"
  ),
  tar_target(
    va_data,
    number_of("Virginia", transformed_),
    format = "rds"
  ),
  tar_target(
    national_data,
    number_of("national", transformed_),
    format = "rds"
  ),
  tar_target(
    national.monthly.strikes,
    month_year_var_number(
      state_var = "national",
      year_var = 2024,
      transformed_data = transformed_
    ),
    format = "rds"
  ),
  tar_render(
    paper,
    "~/Lab4/paper/strike_analysis.rmd"
  )
)
