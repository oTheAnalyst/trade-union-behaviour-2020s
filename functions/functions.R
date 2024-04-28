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


make_plot_strikes <- function(strikes_data, state) {
p <- ggplot(strikes_data %>% filter(Year != "2024")) +
  geom_line(aes(x = Year, y = labor_org_count, color = 'Labor Organization Count', group = 1)) +
  geom_line(aes(x = Year, y = strikes, color = 'Strikes', group = 2)) +
  scale_color_manual(
    values = c('Labor Organization Count' = 'blue', 'Strikes' = 'red'),
    labels = c('Labor Organization Count' = 'Active Labor \n Organization Count', 'Strikes' = 'Strikes')
  ) +
  labs(
    title = paste("Labour Actions in", state),
    subtitle = paste("Source: Labour Action Tracker, Cornell University"),
    caption = paste("Data for", state)
  )

  # Save the plot locally with a dynamic filename
  filename <- paste("plot_", gsub(" ", "_", state), ".png", sep = "")
  ggsave(filename, plot = p, width = 10, height = 6, dpi = 300)

  return(p)
}
