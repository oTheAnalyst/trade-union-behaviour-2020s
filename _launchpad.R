library(purrr)
library(targets)
library(tidyverse)
library(openxlsx)

# the problem with code snippet is
# that I can't include tar_read in the target list.
# consider a work around
the_list <- tar_objects()
# [1] "dc_data"                  "md_data"
# [3] "monthly_strikes_data"     "national.monthly.strikes"
# [5] "national_data"            "transformed_"
# [7] "va_data"
data_list <- readRDS(the_list)

tar_load(dc_data)
tar_read("dc_data")
tar_read(md_data)

data_list <- purrr::map(the_list, tar_read)

build_wb <- function(data_list) {
  data_list <- as.list(data_list)
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

build_wb(data_list)
