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
    states_vector,
    united_states_total_states(),
    format = "rds"
  ),
  tar_target(
    states_and_territories,
    number_of(states_vector, transformed_),
    format = "rds"
  ),
  tar_target(
    year.strikes.2024.monthly,
    month_year_var_number(
      state_var = "national",
      year_var = 2024,
      transformed_data = transformed_
    ),
    format = "rds"
  ),
  tar_target(
    year.strikes.2025.monthly,
    month_year_var_number(
      state_var = "national",
      year_var = 2025,
      transformed_data = transformed_
    ),
    format = "rds"
  ),
  tar_target(
    year.strikes.2023.monthly,
    month_year_var_number(
      state_var = "national",
      year_var = 2023,
      transformed_data = transformed_
    ),
    format = "rds"
  ),
  tar_render(
    paper,
    here("paper", "strike_analysis.rmd")
  ),
  tar_target(
    target_list,
    {
      list(
        dc_data = dc_data,
        md_data = md_data,
        va_data = va_data,
        national_data = national_data,
        year.strikes.2024.monthly = year.strikes.2024.monthly,
        year.strikes.2023.monthly = year.strikes.2023.monthly,
        year.strikes.2025.monthly = year.strikes.2025.monthly,
        states_and_territories = states_and_territories
      )
    }
  ),
  tar_target(output_file,
             write_data_to_excel(target_list,
                                 here("data", "output", "tableau_upload.xlsx")),
             format = "file"),
  tar_target(writes_db,
             write_to_sql(data = year.strikes.2024.monthly,
                          name = "time-series-2024"),
             format = "rds"),
  tar_target(writes_db3,
             write_to_sql(data = year.strikes.2025.monthly,
                          name = "time-series-2025"),
             format = "rds"),
  tar_target(writes_db4,
             write_to_sql(data = transformed_,
                          name = "Labor-prod"),
             format = "rds"),
  tar_target(writes_db2,
             write_to_sql(data = year.strikes.2023.monthly,
                          name = "time-series-2023"),
             format = "rds")
)
