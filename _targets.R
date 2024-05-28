setwd("~/Lab4/")
library(targets)
library(tarchetypes)
library(openxlsx)
source("functions/functions.R")
options(clustermq.schedular = "multicore")
tar_option_set(
  packages = c(
    "tidyverse",
    "targets",
    "rmarkdown",
    "openxlsx",
    "readxl"
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
    "paper/strike_analysis.rmd"
  ),
  tar_target(
    all_data,
    {
      list(
        dc_data = dc_data,
        md_data = md_data,
        va_data = va_data,
        national_data = national_data,
        national.monthly.strikes = national.monthly.strikes
      )
    }
  ),
  tar_target(
    output_file,
    write_data_to_excel(all_data, "data/output/tableau_upload.xlsx"),
    format = "file"
  )
)
