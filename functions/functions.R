load_data <- function(data) {
  con <- dbConnect(RSQLite::SQLite(), "trade_union_data.db")
  data <- as_tibble(dbReadTable(con, "LAT-02.19.24"))
  # disconnet from DB
  dbDisconnect(con)
  return(data)
}

transform_data <- function(data) {
  # Convert Timestamp column to POSIXct format
  data$Timestamp <- as.POSIXct(data$Timestamp,
    format = "%m/%d/%Y %H:%M:%S"
  )
  # mutate zip code to a character
  data <- data %>%
    mutate(
      ZipCode = as.character(ZipCode),
      BargainingUnitSize = parse_number(as.character(BargainingUnitSize)),
      ApproximateNumberofParticipants =
        parse_number(as.character(ApproximateNumberofParticipants)),
      Date = format(Timestamp, "%Y-%m-%d"),
      month = format(Timestamp, "%B"),
      Year = format(Timestamp, "%Y"),
      DurationAmount = as.integer(DurationAmount)
    )
  return(data)
}


plot_data <- function(state_var, transformed_data) {
  years <- unique(transformed_data$Year)
  if (length(years) == 1) {
    d <- transformed_data %>%
      filter(State == state_var & Year == years) %>%
      ggplot(aes(x = month))
      geom_bar() +
      labs(title = paste("Number of Strikes in", state_var))
  } else {
    d <- transformed_data %>%
      filter(State == state_var & Year %in% years) %>%
      ggplot(aes(x = month)) +
      geom_bar() +
      labs(title = paste("Number of Strikes in", state_var, "Per Month")) +
      facet_wrap(~Year, scales = "free_x")
  }
  # Save the plot as a file
  plot_filename <- paste0(state_var, "_plot.png")
  ggsave(plot_filename, plot = d, width = 10, height = 6, dpi = 300)
  plot_filename # Return the filename for downstream targets
}


number_of <- function(state_var, transformed_data) {
  if (!is.vector(state_var)) {
    state_var <- as.vector(state_var)
  }
  transformed_data %>%
    filter(State == state_var) %>%
    group_by(State, Year) %>%
    summarise(
      labor_org_count = n_distinct(LaborOrganization),
      strikes = n(),
      .groups = "drop"
    )
}

plot_time_series <- function(data, state) {
  # Filter the data for the specified state
  state_data <- data[data$State == state, ]

  # Convert Year to a date format for time series plotting
  state_data$Year <- as.Date(paste0(state_data$Year, "-01-01"))

  # Create the dual-axis line chart
  p <- ggplot(state_data, aes(x = Year)) +
    geom_line(aes(y = strikes, color = "Strikes"), size = 1.5) +
    geom_line(aes(y = labor_org_count * 10, color = "Labor Org Count"), linetype = "dashed", size = 1.5) +
    scale_color_manual(values = c("Strikes" = "blue", "Labor Org Count" = "red"),
                       labels = c("Strikes", "Labor Org Count")) +
    labs(title = paste("Strikes and Labor Organization Count Over Time in", state),
         x = "Year",
         y = "Count") +
    theme_minimal()

  return(p)
}

