source("~/Lab2/Trade_Union_Global_Analysis/summary_analysis/Enviroment_Setup.R")

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
})

# connect to the database and pull out the sheet
setwd("~/workbook")
con <- dbConnect(RSQLite::SQLite(), "trade_union_data.db")
dbListTables(con)
#  [1] "CBCR"                                     "CollectiveBargaining"
#  [3] "ILRLaborActionTracker"                    "IRL&ScrappedDataComparision"
#  [5] "LAT-02.19.24"                             "LAT-03.04.24"
#  [7] "LAT-04.01.24"                             "State_Union_Coverage_Density_1977-2021"
#  [9] "State_Union_Membership_Density_1964-2021" "Strikes_United_States"
# [11] "TUDR"                                     "TradeUnionDensity"
# [13] "WorkplaceRights"                          "raw_strike_table"
# [15] "rawonlystrike_table"                      "state_union_coverage_density_long"
# [17] "state_union_membership_density_long"      "state_uniondc_join"
# [19] "strike_table"                             "summarytable_IRLvSData"
february <- as_tibble(dbReadTable(con, "LAT-02.19.24"))
dbDisconnect(con)

# Convert Timestamp column to POSIXct format
february$Timestamp <- as.POSIXct(february$Timestamp,
  format = "%m/%d/%Y %H:%M:%S"
)

# mutate zip code to a character
february <- february %>%
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


# check the number of non NA and NA's in thsi column against the sheet
sum(!is.na(february$BargainingUnitSize))
sum(is.na(february$BargainingUnitSize))
# exmain the number of notes
sum(!is.na(february$Notes))


# check the number of non NA and NA's in thsi column against the sheet
count_data_busize <- sum(!is.na(february$BargainingUnitSize))
count_na_busize <- sum(is.na(february$BargainingUnitSize))
# exmain the number of notes
count_number_of_notes <- sum(!is.na(february$Notes))


print(paste(
  "the total number of available data points in the BargainingUnitSize vector is",
  count_data_busize
))
print(paste(
  "the total number of missing/blank data points in the BargainingUnitSize vector is",
  count_na_busize
))
print(paste(
  "the total number of missing/blank data points in the notes vector is",
  count_number_of_notes
))

monthly_plot <- function(state_var, year_var) {
  if (length(year_var) == 1) {
    d <- february %>%
      filter(State == state_var, Year == year_var) %>%
      ggplot(aes(x = month)) +
      geom_bar() +
      labs(title = paste("Number of Strikes in", state_var)) +
      common_theme()
  } else {
    d <- february %>%
      filter(State == state_var, Year %in% year_var) %>%
      ggplot(aes(x = month)) +
      geom_bar() +
      labs(title = paste("Number of Strikes in", state_var, "Per Month")) +
      facet_wrap(~Year, scales = "free_x") +
      common_theme()
  }
  return(d)
}

years <- c("2021", "2022", "2023", "2024")
dmv <- c("District of Columbia", "Maryland", "Virginia")

monthly_plot("District of Columbia", years)
monthly_plot("Maryland", years)
monthly_plot("Virginia", years)


number_of <- function(state_var, year_var) {
  b1 <- february %>%
    filter(State == state_var, Year %in% year_var) %>%
    summarise(labor_org_count = n_distinct(LaborOrganization))
  print(paste(
    "The number of active labor organization during the selected period of",
    year_var,
    "is", b1
  ))
}
number_of("Virginia", years)
number_of("Maryland", years)

number_of("District of Columbia", "2022")


number_of <- function(state_var, year_var) {
  # If year_var is a single value, convert it to a vector
  if (!is.vector(year_var)) {
    year_var <- as.vector(year_var)
  }
  b1 <- february %>%
    filter(State == state_var, Year %in% year_var) %>%
    summarise(labor_org_count = n_distinct(LaborOrganization))
  # Extract the labor_org_count value from the tibble
  labor_org_count <- b1$labor_org_count
  # Print the result
  if (length(year_var) > 1) {
    print(paste(
      "The number of active labor organizations during the selected period of",
      paste(year_var, collapse = ", "),
      "is", labor_org_count
    ))
  } else {
    print(paste(
      "The number of active labor organizations during the selected year of",
      year_var,
      "is", labor_org_count
    ))
  }
}
# Assuming 'years' is a defined vector of years
number_of("Virginia", years)
number_of("Maryland", years)
number_of("District of Columbia", "2022")







# Define the truncate_string function
truncate_string <- function(string, max_length) {
  if (nchar(string) > max_length) {
    truncated_string <- paste0(substr(string, 1, max_length - 3), "...")
  } else {
    truncated_string <- string
  }
  return(truncated_string)
}
# Define the number_of function
number_of <- function(state_var, year_var) {
  # If year_var is a single value, convert it to a vector
  if (!is.vector(year_var)) {
    year_var <- as.vector(year_var)
  }
  b1 <- february %>%
    filter(State == state_var, Year %in% year_var) %>%
    summarise(labor_org_count = n_distinct(LaborOrganization))
  # Extract the labor_org_count value from the tibble
  labor_org_count <- b1$labor_org_count
  # Create the sentence
  if (length(year_var) > 1) {
    sentence <- paste(
      "The number of active labor organizations during the selected period of",
      paste(year_var, collapse = ", "),
      "is", labor_org_count
    )
  } else {
    sentence <- paste(
      "The number of active labor organizations during the selected year of",
      year_var,
      "is", labor_org_count
    )
  }
  # Truncate the sentence to 100 characters and print
  truncated_sentence <- truncate_string(sentence, 50)
  print(truncated_sentence)
}

# Assuming 'years' is a defined vector of years
number_of("Virginia", years)
number_of("Maryland", years)
number_of("District of Columbia", "2022")



number_of <- function(state_var, year_var) {
  # If year_var is a single value, convert it to a vector
  if (!is.vector(year_var)) {
    year_var <- as.vector(year_var)
  }
  result <- february %>%
    filter(State == state_var, Year %in% year_var) %>%
    group_by(State, Year) %>%
    summarise(
      labor_org_count = n_distinct(LaborOrganization),
      strikes = n(),
      .groups = "drop"
    )
  # Extract the labor_org_count value from the tibble
  labor_org_count <- sum(result$labor_org_count)
  # Create the paragraph
  if (length(year_var) > 1) {
    paragraph <- paste(
      "The number of active labor organizations during the selected", "\n",
      "period of",
      paste(year_var, collapse = ", "),
      "in", state_var, "is", labor_org_count, ".\n"
    )
  } else {
    paragraph <- paste(
      "The number of active labor organizations during the", "\n",
      "selected year of",
      year_var, "in", state_var, "is", labor_org_count, ".\n"
    )
  }
  # Print the paragraph
  cat(paragraph)
  # Print the result
  print(result)
}
number_of("Maryland", years)


result <- february %>%
  filter(State == "Maryland", Year %in% years) %>%
  group_by(State, Year) %>%
  summarise(
    labor_org_count = n_distinct(LaborOrganization),
    row_count = n(),
    .groups = "drop"
  )
print(result)


number_of("Maryland", years)
