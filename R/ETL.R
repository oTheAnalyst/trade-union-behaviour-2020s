#
# This is an example function named 'hello' 
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   https://r-pkgs.org
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'
#

#' load_list
#'
#' @param input 
#'
#' @return this function will load the list of data within the package
#' @export
load_list <- function(input) {
 #load in the data paths  
  file_paths <- list.files(
    path = input,
    pattern = "\\.xlsx$",
    full.names = TRUE
  )
 
#read the path output a list 
 files <- file_paths |> 
  purrr::map(readxl::read_xlsx) 
 # set the name as a list
 names <-  basename(file_paths )
 names <- gsub(".xlsx", "", names)
  files <- files |> 
   purrr::set_names(names) 
 return(files)
}
#'


#' transform_data
#'
#' @param input 
#'
#' @return transforms loaded data
#' @export
transform_data <- function(input) {
  # Read Excel file and convert to tibble
  excel_tibble <- input
  
  excel_tibble$'Start Date' <- as.POSIXct(
        excel_tibble$'Start Date',
        format = "%m/%d/%Y", tz = "UTC"
        )
  excel_tibble$Year <- lubridate::year(excel_tibble$'Start Date')
  excel_tibble$Month <- lubridate::month(excel_tibble$'Start Date')
  
  tx_data <- excel_tibble |>
    janitor::clean_names(case = "lower_camel")
  
  # Mutate columns as needed
 # tx_data <- tx_data |>
 #   dplyr::mutate(
 #     id = as.integer(id),
 #     durationAmount = as.integer(durationAmount),
 #     approximateNumberOfParticipants = as.integer(approximateNumberOfParticipants),
 #     durationAmount = as.integer(durationAmount),
 #     numberOfLocations = as.integer(numberOfLocations),
 #     year = as.integer(year),
 #     month = as.integer(month)
 #   )
 #
  return(tx_data)
}

#' load_and_transform_data
#'
#' @param input 
#'
#' @return this is main() function
#' @export
load_transform_data <- function(input) {
  #input list
  input_list <- load_list(input)
  #this transforms the the data
  tx_list <- purrr::map(input_list, transform_data)
  return(tx_list)
  # Return a message indicating successful saving
  message("Transformed data saved successfully")
}



#' write_to_sql
#'
#' @param input 
#'
#' @return writes data to sql
#' @export
write_to_sql <- function(data, name) {
  driver <- duckdb::dbDriver("SQLite")
  sql_location <- "~/production.duckdb"
  conn <- duckdb::dbConnect(duckdb::duckdb(), sql_location, read_only = false)
  duckdb::dbWriteTable(conn, name, data, overwrite = TRUE)
  duckdb::dbDisconnect(conn)
}



