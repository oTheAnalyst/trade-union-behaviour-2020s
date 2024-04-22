
load_data <- function(file) {
  setwd("~/workbook")
  con <- dbConnect(RSQLite::SQLite(), "trade_union_data.db")
  file <- as_tibble(dbReadTable(con, "LAT-02.19.24"))
  # disconnet from DB
  dbDisconnect(con)
  return(file)
}

transform_data <- function(file) {
# Convert Timestamp column to POSIXct format
file$Timestamp <- as.POSIXct(file$Timestamp,
  format = "%m/%d/%Y %H:%M:%S"
)
# mutate zip code to a character
file <- file %>%
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
}


plot_data <- function(state_var) {
  years <- unique(file$Year)  # Extract unique years from the 'Year' column in 'file'
  if (length(years) == 1) {
    d <- file %>%
      filter(State == state_var, Year == years) %>%
      ggplot(aes(x = month)) +
      geom_bar() +
      labs(title = paste("Number of Strikes in", state_var)) +
      common_theme()
  } else {
    d <- file %>%
      filter(State == state_var, Year %in% years) %>%
      ggplot(aes(x = month)) +
      geom_bar() +
      labs(title = paste("Number of Strikes in", state_var, "Per Month")) +
      facet_wrap(~Year, scales = "free_x") +
      common_theme()
  }
  return(d)
}
