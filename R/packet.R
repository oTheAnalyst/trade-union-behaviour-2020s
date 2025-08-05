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
write_to_sql <- function(data, name) {
  driver <- RSQLite::dbDriver("SQLite")
  sql_location <- "~/trade_union-strikes.db"
  conn <- RSQLite::dbConnect(driver, sql_location)
  RSQLite::dbWriteTable(conn, name, data, overwrite = TRUE)
  RSQLite::dbDisconnect(conn)
}


transform_data <- function(input_list) {
  # Read Excel file and convert to tibble
  excel_tibble <- readxl::read_excel(input_list)
  excel_tibble$Timestamp <- as.POSIXct(excel_tibble$'Start Date',
    format = "%m/%d/%Y", tz = "UTC"
  )
  excel_tibble$Year <- lubridate::year(excel_tibble$Timestamp)
  excel_tibble$Month <- lubridate::month(excel_tibble$Timestamp)
  return(excel_tibble)
  # Mutate columns as needed
  transformed_data <- excel_tibble |>
    dplyr::mutate(
      ZipCode = as.character('Zip Code'),
      BargainingUnitSize =
        readr::parse_number(as.character('Bargaining Unit Size')),
      ApproximateNumberofParticipants =
        readr::parse_number(as.character('Approximate Number of Participants')),
      Date = format(Timestamp, "%m-%d-%Y"),
      month = format(Timestamp, "%B"),
      DurationAmount = as.integer('Duration Amount')
    )
  return(transformed_data)
}
  
  
tx_load_list <- function() {
  file_paths <- list.files(
    path = here::here("data"),
    pattern = "\\.xlsx$",
    full.names = TRUE
  )
  return(file_paths)
}


load_and_transform_data <- function(index) {
  input_list <- tx_load_list()
  # Get a list of all xlsx files in the specified directory
  print(input_list)
  # Function to read Excel file, convert to tibble, and transform data
  # Read all Excel files, store them as tibbles, and transform data
  names <- base::basename(input_list)
  transformed_data_list <- purrr::map(input_list, transform_data)
  transformed_data_list <- transformed_data_list |> purrr::set_names(names)
  transformed_ <- tibble::as_tibble(transformed_data_list[[index]])
  return(transformed_)
  # Return a message indicating successful saving
  message("Transformed data saved successfully")
}


load_and_transform_data("Labor-prod.xlsx")



