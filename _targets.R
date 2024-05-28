setwd("~/Lab4/")
library(targets)
library(tarchetypes)
library(openxlsx)
source("~/Lab4/functions/functions.R")
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
    load_and_transform_data(1),
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
  ),
  tar_target(
    all_data,
    {
      list(
        dc_data = dc_data,
        md_data = md_data,
        national_data = national_data,
        transformed_ = transformed_,
        va_data = va_data
      )
    }
  ),
  tar_target(
    output_file,
    {
      # Write the list to an Excel file with multiple sheets
      wb <- createWorkbook()
      addWorksheet(wb, "dc_data")
      writeData(wb, "dc_data", all_data$dc_data)
      addWorksheet(wb, "md_data")
      writeData(wb, "md_data", all_data$md_data)
      addWorksheet(wb, "national_data")
      writeData(wb, "national_data", all_data$national_data)
      addWorksheet(wb, "va_data")
      writeData(wb, "va_data", all_data$va_data)
      output_path <- "data/output.xlsx"
      saveWorkbook(wb, output_path, overwrite = TRUE)
      output_path # Return the file path
    },
    format = "file"
  )
)
