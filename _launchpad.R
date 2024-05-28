library(purrr)
library(targets)
library(tidyverse)
library(openxlsx)
# the problem with code snippet is
# that I can't include tar_read in the target list.
# consider a work around
build_list <- function() {
  targets_ <- tar_load(dc_data,md_data,va_data,
    monthly_strikes_data,national_data)
  data_list <- tar_read(targets)
  print(data_list)
}
tar_objects()
# [1] "dc_data"                  "md_data"
# [3] "monthly_strikes_data"     "national.monthly.strikes"
# [5] "national_data"            "transformed_"
# [7] "va_data"

datalist <- tar_objects(names = dc_data,md_data,va_data)

build_wb <- function(data_list) {
  sheets_list <- paste0("sheet_", seq(1, length(data_list)))
  wb <- createWorkbook()
  sheets_list %>%
    walk(~ addWorksheet(wb, sheetName = .))
  walk2(
    .x = sheets_list,
    .y = data_list,
    ~ writeData(wb,
      sheet = .x,
      x = .y
    )
  )
  saveWorkbook(wb,
    "tableau_upload.xlsx",
    overwrite = TRUE
  )
}
