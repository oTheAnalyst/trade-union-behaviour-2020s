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
# names <-  basename(file_paths )
# names <- gsub(".xlsx", "", names)
#  files <- files |> 
#   purrr::set_names(names) 
 return(files)
}

transform_data <- function(input) {
  # Read Excel file and convert to tibble
  excel_tibble <- input
  
  excel_tibble$s_action <- as.POSIXct(
        excel_tibble$'Start Date',
        format = "%m/%d/%Y", tz = "UTC"
        )
  excel_tibble$Year <- lubridate::year(excel_tibble$s_action)
  excel_tibble$Month <- lubridate::month(excel_tibble$s_action)
  tx_data <- excel_tibble
  # Mutate columns as needed
#  tx_data <- excel_tibble |>
#    dplyr::mutate(
#      ZipCode = as.character('Zip Code'),
#      BargainingUnitSize =
#        readr::parse_number(as.character('Bargaining Unit Size')),
#      ApproximateNumberofParticipants =
#        readr::parse_number(as.character('Approximate Number of Participants')),
#      Date = format(s_action, "%m-%d-%Y"),
#      month = format(s_action, "%B"),
#      DurationAmount = as.integer('Duration Amount')
#    )
# 
  tx_data <- tx_data |>
    janitor::clean_names(case = "snake")
  
  return(tx_data)
}

load_transform_data <- function(input) {
  #input list
  input_list <- load_list(input)
  #this transforms the the data
  tx_list <- purrr::map(input_list, transform_data)
  
  return(tx_list)
  # Return a message indicating successful saving
  message("Transformed data saved successfully")
}

load_transform_data(here::here("data"))


write_to_sql <- function(data, name) {
  driver <- RSQLite::dbDriver("SQLite")
  sql_location <- "~/trade_union-strikes.db"
  conn <- RSQLite::dbConnect(driver, sql_location)
  RSQLite::dbWriteTable(conn, name, data, overwrite = TRUE)
  RSQLite::dbDisconnect(conn)
}


