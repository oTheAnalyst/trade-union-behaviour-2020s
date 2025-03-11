install.packages("knitr", lib = "~/Rpackages")
install.packages("xfun", lib = "~/Rpackages")
install.packages(c("evaluate", "highr"), lib = "~/Rpackages")
# .libPaths("~/Rpackages")




library(knitr)
library(highr)
library(evaluate)
library(xfun)

library(tidyverse)
library(RSQLite)
library(DBI)
library(ggplot2)
library(dplyr)
library(forcats)
library(GGally)
library(stringr)

setwd("~/workbook")
con <- dbConnect(RSQLite::SQLite(), "trade_union_data.db")
dbListTables(con)
tudr <- as_tibble(dbReadTable(con, "TUDR"))
cbcr <- as_tibble(dbReadTable(con, "CBCR"))
collective_bargaining <- as_tibble(dbReadTable(con, "CollectiveBargaining"))
trade_union_density <- as_tibble(dbReadTable(con, "TradeUnionDensity"))
workplace_rights <- as_tibble(dbReadTable(con, "WorkplaceRights"))
state_union_membership_density <-
  as_tibble(dbReadTable(con, "State_Union_Membership_Density_1964-2021"))
dbDworkplaces_rights_2017 <- workplace_rights %>%
  filter(time == 2017)


joined_data <- inner_join(workplaces_rights_2017, tudr_2017,
  by = c("ref_area", "time")
)

joined_data2017 <- inner_join(joined_data, cbcr_2017,
  by = c("ref_area", "time")
)

view(joined_data2017)

joined_data2017 <- joined_data2017 %>%
  rename(
    "National_Compliance_wth_Labour_Rights" = obs_value.x,
    "Union Density" = obs_value.y,
    "Collective Bargaining Coverage" = obs_value
  )

joined_data2017 %>%
  select(
    National_Compliance_wth_Labour_Rights,
    `Collective Bargaining Coverage`
  )


# full joined data is below
joined_data4 <- inner_join(workplace_rights, tudr, by = c("ref_area", "time"))
joined_full_data_set <- inner_join(joined_data4, cbcr,
  by = c("ref_area", "time")
)
joined_full_data_set <- joined_full_data_set %>%
  rename(
    "National_Compliance_wth_Labour_Rights" = obs_value.x,
    "Union Density" = obs_value.y,
    "Collective Bargaining Coverage" = obs_value
  )


trade_union_density <- trade_union_density %>%
  rename("Year" = Time)
OldData <- inner_join(trade_union_density, collective_bargaining,
  by = c("Country", "Year")
)
colnames(OldData)


####                  this for state_union_membership_density       ###### #

# Assuming your tibble is named state_union_membership_density
state_union_membership_density <- state_union_membership_density %>%
  rename_with(~ str_replace(.x, "X.Mem", "19"), starts_with("X.Mem"))
# Assuming your tibble is named state_union_membership_density
# Get the current column names
col_names <- colnames(state_union_membership_density)
# Loop through each column name
for (i in seq_along(col_names)) {
  # Extract the year part of the column name and convert it to a numeric value
  year <- as.numeric(col_names[i])
  # Check if the year is less than 1960 and starts with 19
  if (!is.na(year) && year < 1960 && startsWith(col_names[i], "19")) {
    # Replace "19" with "20" in the year part
    new_year <- sub("19", "20", col_names[i])
    # Update the column name
    col_names[i] <- new_year
  }
}
# Assign the new column names back to the tibble
colnames(state_union_membership_density) <-
  col_names state_union_membership_density %>%
  colnames()


setwd("~/Lab2/Trade Union Global Analysis./")
knit("TradeUnion.Rnw")
