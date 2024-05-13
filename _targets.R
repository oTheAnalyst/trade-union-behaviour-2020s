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
    transformed_data,
    load_and_transform_data("~/Lab4/",
      "~/Lab4/_targets/objects/datalist"),
    format = "rds"
  ),
  tar_target(
    data_frame,
    load_and_extract_df("~/Lab4/_targets/objects/datalist", 4),
    format = "rds"
  ),
  tar_target(
    dc_data,
    number_of("District of Columbia", data_frame),
    format = "rds"
  ),
  tar_target(
    md_data,
    number_of("Maryland", data_frame),
    format = "rds"
  ),
  tar_target(
    va_data,
    number_of("Virginia", data_frame),
    format = "rds"
  ),
  tar_target(
    national_data,
    number_of("national", data_frame),
    format = "rds"
  )
)
