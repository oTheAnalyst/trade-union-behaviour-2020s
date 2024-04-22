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
      filter(State == state_var, Year == years) %>%
      ggplot(aes(x = month)) +
      geom_bar() +
      labs(title = paste("Number of Strikes in", state_var)) +
      common_theme()
  } else {
    d <- transformed_data %>%
      filter(State == state_var, Year %in% years) %>%
      ggplot(aes(x = month)) +
      geom_bar() +
      labs(title = paste("Number of Strikes in", state_var, "Per Month")) +
      facet_wrap(~Year, scales = "free_x") +
      common_theme()
  }
  # Save the plot as a file
  plot_filename <- paste0(state_var, "_plot.png")
  ggsave(plot_filename, plot = d, width = 10, height = 6, dpi = 300)
  return(plot_filename)  # Return the filename for downstream targets
}



