library(purrr)
library(targets)
library(tidyverse)
library(openxlsx)

build_wb <- function(wb) {
file_paths <- list.files(
  path = "~/Lab4/_targets/objects/",
  pattern = "\\_data$",
  full.names = TRUE
)
build_list <- function(file_paths) {
  data_list <-  tar_read(file_paths)
    return(data_list)
  }
sheets_list <- paste0("sheet_", seq(1, length(data_list)))
wb <- createWorkbook()
sheets_list %>%
  walk(~addWorksheet(wb, sheetName = .))
walk2(.x = sheets_list,
      .y = data_list,
      ~writeData(wb,
                 sheet = .x, x = .y))
  saveWorkbook(wb,
               "tableau_upload.xlsx",
               overwrite = TRUE)
}

build_wb(wb)
