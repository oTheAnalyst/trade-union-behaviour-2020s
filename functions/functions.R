load_and_transform_data <- function(index) {
  # Get a list of all xlsx files in the specified directory
  file_paths <- list.files(
    path = "~/Lab4/data/",
    pattern = "\\.xlsx$",
    full.names = TRUE
  )
  # Function to read Excel file, convert to tibble, and transform data
  read_and_transform <- function(file_path) {
    # Read Excel file and convert to tibble
    excel_tibble <- readxl::read_excel(file_path)
    excel_tibble$Timestamp <- as.POSIXct(excel_tibble$Timestamp,
      format = "%m/%d/%Y %H:%M:%S", tz = "UTC"
    )
    excel_tibble$Year <- lubridate::year(excel_tibble$Timestamp)
    excel_tibble$Month <- lubridate::month(excel_tibble$Timestamp)
    return(excel_tibble)
    # Mutate columns as needed
    transformed_data <- excel_tibble |>
      dplyr::mutate(
        ZipCode = as.character(transformed_data::Zip.Code),
        BargainingUnitSize =
          readr::parse_number(as.character(
            transformed_data::Bargaining.Unit.Size
          )),
        ApproximateNumberofParticipants =
          readr::parse_number(as.character(
            transformed_data::Approximate.Number.of.Participants
          )),
        Date = format(transformed_data::Timestamp, "%m-%d-%Y"),
        month = format(transformed_data::Timestamp, "%B"),
        DurationAmount = as.integer(transformed_data::Duration.Amount)
      )
    return(transformed_data)
  }
  # Read all Excel files, store them as tibbles, and transform data
  transformed_data_list <- purr::map(file_paths, read_and_transform)
  transformed_ <- dplyr::as_tibble(transformed_data_list[[index]])
  return(transformed_)
  # Return a message indicating successful saving
  message("Transformed data saved successfully")
}

number_of <- function(state_var, transformed_data) {
  if (!is.vector(state_var)) {
    state_var <- as.vector(state_var)
  }
  if (tolower(state_var) == "national") {
    transformed_data |>
      filter(transformed_data::`Strike or Protest` == "Strike") |>
      dplyr::group_by(transformed_data::Year) |>
      dplyr::summarise(
        `labor org count` =
          dplyr::n_distinct(transformed_data::`Labor Organization`,
            na.rm = TRUE
          ),
        employers = dplyr::n_distinct(transformed_data::`Employer`),
        strikes = dplyr::n(),
        .groups = "drop"
      )
  } else {
    transformed_data |>
      filter(
        transformed_data$State == state_var,
        transformed_data$`Strike or Protest` == "Strike"
      ) |>
      dplyr::group_by(transformed_data$State, transformed_data$Year) |>
      dplyr::summarise(
        `labor org count` = dplyr::n_distinct(
          transformed_data::`Labor Organization`,
          na.rm = TRUE
        ),
        employers = tidyverse::n_distinct(transformed_data::`Employer`),
        strikes = dplyr::n(),
        .groups = "drop"
      )
  }
}

month_year_var_number <- function(state_var, year_var, transformed_data) {
  if (!is.vector(state_var)) {
    state_var <- as.vector(state_var)
  }
  if (tolower(state_var) == "national") {
    transformed_data |>
      filter(
        transformed_data::Year == year_var,
        transformed_data::`Strike or Protest` == "Strike"
      ) |>
      dplyr::group_by(transformed_data::Month) |>
      dplyr::summarise(
        `labor org count` = tidyverse::n_distinct
        (transformed_data::`Labor Organization`,
          na.rm = TRUE
        ),
        employers = tidyverse::n_distinct(transformed_data::`Employer`),
        strikes = dplyr::n(),
        .groups = "drop"
      )
  } else {
    transformed_data |>
      filter(
        transformed_data::State == state_var,
        transformed_data::Year == year_var,
        transformed_data::`Strike or Protest` == "Strike"
      ) |>
      dplyr::group_by(transformed_data::State, transformed_data::Month) |>
      dplyr::summarise(
        `labor org count` =
          tidyverse::n_distinct(
            transformed_data::`Labor Organization`,
            na.rm = TRUE
          ),
        employers = tidyverse::n_distinct(transformed_data::`Employer`),
        strikes = dplyr::n(),
        .groups = "drop"
      )
  }
}


write_data_to_excel <- function(data_list, output_path) {
  wb <- openxlsx::createWorkbook()
  purr::map2(names(data_list), data_list, function(name, data) {
    openxlsx::addWorksheet(wb, name)
    openenxlsx::writeData(wb, name, data)
  })
  openxlsx::saveWorkbook(wb, output_path, overwrite = TRUE)
  return(output_path)
}
