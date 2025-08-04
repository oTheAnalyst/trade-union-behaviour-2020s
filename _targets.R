library(targets)
library(tarchetypes)
library(here)

here::i_am("_targets.R")

source(here("functions", "functions.R"))
options(clustermq.schedular = "multicore")
tar_option_set(
               packages = c(
                            "tidyverse",
                            "targets",
                            "rmarkdown",
                            "openxlsx",
                            "readxl"),
               format = "rds")

list(
  tar_target(
    transformed_,
    load_and_transform_data("Labor-prod.xlsx"),
    format = "rds"
  ),
  tar_target(
    writes_to_sql,
    super_function(),
    format = "rds"
  ),
  tar_render(strike_DSA_report, here::here("strike_DSA_report.Rmd"))
  )
