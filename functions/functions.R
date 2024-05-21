load_and_transform_data <- function(index) {
  # Get a list of all xlsx files in the specified directory
  file_paths <- list.files(
    path = "~/Lab4/_targets/data/",
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
    excel_tibble$Month <- month(excel_tibble$Timestamp)
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
  transformed_ <- as_tibble(transformed_data_list[[index]])
  return(transformed_)
  # Return a message indicating successful saving
  message("Transformed data saved successfully")
}

number_of <- function(state_var, transformed_data) {
  if (!is.vector(state_var)) {
    state_var <- as.vector(state_var)
  }
  if (tolower(state_var) == "national") {
    transformed_data %>%
      filter(`Strike or Protest` == "Strike") %>%
      group_by(Year) %>%
      summarise(
        `labor org count` = n_distinct(`Labor Organization`,
          na.rm = TRUE
        ),
        employers = n_distinct(`Employer`),
        strikes = n(),
        .groups = "drop"
      )
  } else {
    transformed_data %>%
      filter(
        State == state_var,
        `Strike or Protest` == "Strike"
      ) %>%
      group_by(State, Year) %>%
      summarise(
        `labor org count` = n_distinct(`Labor Organization`, na.rm = TRUE),
        employers = n_distinct(`Employer`),
        strikes = n(),
        .groups = "drop"
      )
  }
}

month_year_var_number <- function(state_var, year_var, transformed_data) {
  if (!is.vector(state_var)) {
    state_var <- as.vector(state_var)
  }
  if (tolower(state_var) == "national") {
    transformed_data %>%
      filter(
        Year == year_var,
        `Strike or Protest` == "Strike"
      ) %>%
      group_by(Month) %>%
      summarise(
        `labor org count` = n_distinct(`Labor Organization`, na.rm = TRUE),
        employers = n_distinct(`Employer`),
        strikes = n(),
        .groups = "drop"
      )
  } else {
    transformed_data %>%
      filter(
        State == state_var, Year == year_var,
        `Strike or Protest` == "Strike"
      ) %>%
      group_by(State, Month) %>%
      summarise(
        `labor org count` = n_distinct(`Labor Organization`, na.rm = TRUE),
        employers = n_distinct(`Employer`),
        strikes = n(),
        .groups = "drop"
      )
  }
}

