setwd("~/workbook")
con <- dbConnect(rsqlite::sqlite(), "trade_union_data.db")
dblisttables(con)
long_data <- state_union_membership_density %>%
  pivot_longer(
    cols = -c(StateName, StateID), # Exclude non-year columns
    names_to = "Year",
    values_to = "Value"
  )
# Convert Year to a numeric value for plotting
long_data$Year <- as.numeric(long_data$Year)
dbWriteTable(
  con, "state_union_membership_density_long",
  long_data
)
long_data <- state_union_coverage_density %>%
  pivot_longer(
    cols = -c(StateName, StateID), # Exclude non-year columns
    names_to = "Year",
    values_to = "Value"
  )
# Convert Year to a numeric value for plotting
long_data$Year <- as.numeric(long_data$Year)
dbWriteTable(
  con, "state_union_coverage_density_long",
  long_data
)
