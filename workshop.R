library(openxlsx)
library(tibble)
library(purrr)


load_data <- function(directory) {
  # Get a list of all xlsx files in the specified directory
  file_paths <- list.files(
    path = directory,
    pattern = "\\.xlsx$",
    full.names = TRUE
  )
  # Function to read Excel file and convert to tibble
  read_excel_to_tibble <- function(file_path) {
    # Read Excel file and convert to tibble
    excel_data <- read.xlsx(file_path)
    excel_tibble <- as_tibble(excel_data)
    return(excel_tibble)
  }
  # Read all Excel files and store them as tibbles in a list
  excel_tibbles_list <- map(file_paths, read_excel_to_tibble)
  return(excel_tibbles_list)
  excel_tibbles_list <- load_data("~/Lab4/")
  data <- excel_tibbles_list[[4]]
  return(data)
}
