# Hello, world!
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

#' Title
#'
#' @param input 
#'
#' @return
#' @export
#'
#' @examples
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


knit2docs::knit2docs(
  rmd_file = system.file("test2.Rmd", package = "dsa"),
  doc_name = "dsa_report",
  overwrite = TRUE
)
system.file("paper/strike_DSA_report.Rmd", package = "dsa")
system.file(package = "dsa")


#' Title
#'
#' @param input 
#'
#' @return
#' @export
#'
#' @examples
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
  tx_data <- tx_data |>
    dplyr::mutate(
      id = as.integer(id),
      durationAmount = as.integer(durationAmount),
      approximateNumberOfParticipants = as.integer(approximateNumberOfParticipants),
      durationAmount = as.integer(durationAmount),
      numberOfLocations = as.integer(numberOfLocations),
      year = as.integer(year),
      month = as.integer(month)
    )
 
  return(tx_data)
}


### this is the full and proper function for the formatting the table
#' Title
#'
#' @param input 
#'
#' @return
#' @export
#'
#' @examples
load_transform_data <- function(input) {
  #input list
  input_list <- load_list(input)
  #this transforms the the data
  tx_list <- purrr::map(input_list, transform_data)
  return(tx_list)
  # Return a message indicating successful saving
  message("Transformed data saved successfully")
}



#' Title
#'
#' @param data 
#' @param name 
#'
#' @return
#' @export
#'
#' @examples
write_to_sql <- function(data, name) {
  driver <- RSQLite::dbDriver("SQLite")
  sql_location <- "~/trade_union-strikes.db"
  conn <- RSQLite::dbConnect(driver, sql_location)
  RSQLite::dbWriteTable(conn, name, data, overwrite = TRUE)
  RSQLite::dbDisconnect(conn)
}




