library(lubridate)
library(readxl)
library(dplyr)
library(purrr)
library(readr)

load_and_transform_data <- function(directory, save_path) {
  # Get a list of all xlsx files in the specified directory
  file_paths <- list.files(
    path = directory,
    pattern = "\\.xlsx$",
    full.names = TRUE
  )
  # Function to read Excel file, convert to tibble, and transform data
  read_and_transform <- function(file_path) {
    # Read Excel file and convert to tibble
    excel_tibble <- read_excel(file_path)
    excel_tibble$Timestamp <- as.POSIXct(excel_tibble$Timestamp,
      format = "%m/%d/%Y %H:%M:%S", tz = "UTC"
    )
    excel_tibble$Year <- year(excel_tibble$Timestamp)
    return(excel_tibble)
    # Mutate columns as needed
    transformed_data <- excel_tibble %>%
      mutate(
        ZipCode = as.character(Zip.Code),
        BargainingUnitSize =
          readr::parse_number(as.character(Bargaining.Unit.Size)),
        ApproximateNumberofParticipants =
          readr::parse_number(as.character(Approximate.Number.of.Participants)),
        Date = format(Timestamp, "%m-%d-%Y"),
        month = format(Timestamp, "%B"),
        DurationAmount = as.integer(Duration.Amount)
      )
    return(transformed_data)
  }
  # Read all Excel files, store them as tibbles, and transform data
  transformed_data_list <- map(file_paths, read_and_transform)
  # Save the list of transformed tibbles locally
  saveRDS(transformed_data_list, file = save_path)
  # Return a message indicating successful saving
  message("Transformed data list saved successfully at ", save_path)
}

number_of <- function(state_var, transformed_data) {
  if (!is.vector(state_var)) {
    state_var <- as.vector(state_var)
  }
  transformed_data %>%
    filter(State == state_var) %>%
    group_by(State, Year) %>%
    summarise(
      labor_org_count = n_distinct(`Labor Organization`, na.rm = TRUE), #use back tics with vectors operations
      strikes = n(),
      .groups = "drop"
    )
}
load_and_extract_df <- function(rds_file, index) {
  # Load the RDS file
  saved_list <- readRDS(rds_file)
  # Extract the desired data frame from the list
  extracted_df <- as_tibble(saved_list[[index]])
  return(extracted_df)
}
load_and_transform_data("~/Lab4/", "~/Lab4/_targets/objects/datalist.rds")
saved_list <- readRDS("~/Lab4/_targets/objects/datalist.rds")
data_frame <- as_tibble(saved_list[[4]])
number_of("District of Columbia", data_frame)
number_of("Maryland", data_frame)
number_of("Virginia", data_frame)
