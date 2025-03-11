library(tidyverse)
library(RSQLite)
library(DBI)
library(ggplot2)
library(dplyr)
library(forcats)
library(GGally)
library(stringr)
library(magrittr)
library(purrr)
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
state_union_coverage_density <-
  as_tibble(dbReadTable(con, "State_Union_Coverage_Density_1977-2021"))
state_union_join <-
  as_tibble(dbReadTable(con, "state_uniondc_join"))
dbDisconnect(con)


# Define common theme with grid lines
common_theme <- function() {
  theme(
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    panel.grid.major = element_line(color = "grey90"),
    panel.grid.minor = element_line(color = "grey95"),
    text = element_text(color = "black"),
    axis.text = element_text(color = "black"),
    axis.title = element_text(color = "black"),
    strip.text = element_text(color = "black"),
    legend.text = element_text(color = "black"),
    legend.title = element_text(color = "black"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
}


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

# themes

# themes for NorthvsSouth
plot_theme <- theme_minimal(base_size = 8, base_family = "Roboto") +
  theme(
    plot.title = element_text(
      size = 20, family = "Lobster Two",
      face = "bold", color = "#2a475e"
    ),
    axis.title.x = element_text(size = 15, face = "bold", color = "black"),
    axis.title.y = element_text(
      size = 15, face = "bold", color = "black",
      margin = margin(t = 10, b = 0, l = 10, r = 2)
    ),
    axis.text.x = element_text(
      size = 13, color = "black",
      margin = margin(t = 5, b = 0, l = 0, r = 0)
    ),
    axis.text.y = element_text(
      size = 13, color = "black",
      margin = margin(t = 0, b = 5, l = 0, r = 5)
    ),
    legend.position = "none",
    plot.margin = margin(t = 1, r = 1, b = 40, l = 1, unit = "pt"),
    axis.ticks = element_line(size = 2, colour = "grey50"),
    axis.line = element_line(colour = "grey50"),
    panel.grid = element_line(color = "#b4aea9"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_line(linetype = "dashed"),
    panel.grid.major.y = element_line(linetype = "dashed"),
    panel.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"),
    plot.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4")
  )

tstheme <- theme(
  plot.title = element_text(size = 20, face = "bold"), # Bold and larger title
  axis.title.x = element_text(size = 16, face = "bold"), # Bold X axis title
  axis.title.y = element_text(size = 16, face = "bold"), # Bold Y axis title
  axis.text.x = element_text(
    size = 13, color = "black",
    margin = margin(t = 5, b = 0, l = 0, r = 0)
  ),
  axis.text.y = element_text(
    size = 13, color = "black",
    margin = margin(t = 0, b = 5, l = 0, r = 5)
  ),
  panel.grid.major = element_line(color = "gray80"), # Lighter color for major grid lines
  panel.grid.minor = element_blank(), # Remove minor grid lines
  plot.margin = margin(1, 1, 1, 1, "cm") # Adjust plot margins
)
####                  loop for state_union_membership_density       ###### #

# Assuming your tibble is named state_union_membership_density
state_union_membership_density <- state_union_membership_density %>%
  rename_with(~ str_replace(.x, "X.Mem", "19"), starts_with("X.Mem"))
# Assuming your tibble is named state_union_membership_density
# Get the current column names
col_names <- colnames(state_union_membership_density)
#                             Loop through each column name
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
colnames(state_union_membership_density) <- col_names


#####                   loop for state_union_coverage_density         #####
state_union_coverage_density <- state_union_coverage_density %>%
  rename_with(~ str_replace(.x, "X.Cov", "19"), starts_with("X.Cov"))
# Assuming your tibble is named state_union_coverage_density
# Get the current column names
col_names <- colnames(state_union_coverage_density)
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
colnames(state_union_coverage_density) <- col_names

colnames(state_union_join)
head(state_union_join)

# Simple Linear Regression
model_simple <- lm(coverage_density ~ membership_density,
  data = state_union_join
)
summary(model_simple)

# piped predictions
new_membership <- tibble(membership_density = c(10.5, 10.8, 12.5, 13.5))
predict(model_simple, new_membership) %>% round(1)


state_union_join %>%
  lm(coverage_density ~ membership_density, data = .) %>%
  predict(new_membership) %>%
  round(2)

#                         state_union_membership_density
# Reshape the data from wide to long format
long_data <- state_union_membership_density %>%
  pivot_longer(
    cols = -c(StateName, StateID), # Exclude non-year columns
    names_to = "Year",
    values_to = "Value"
  )
# Convert Year to a numeric value for plotting
long_data$Year <- as.numeric(long_data$Year)
# wrap and edit citation
citation_text <- "Source: Barry T. Hirsch, David A. Macpherson, and Wayne G. Vroman, “Estimates of Union Density by State,” Monthly Labor Review, Vol. 124, No. 7, July 2001, pp. 51-55."
wrapped_citation <- str_wrap(citation_text, width = 50) # Adjust width as needed
# wrap and edit title
title_text <- "Time Series Analysis of Union Density in the United States (%Percentage of a States Industry that are Unionized)"
wrapped_title <- str_wrap(title_text, width = 40)
# Define the labels
plot_labels <- labs(
  title = wrapped_title,
  x = "Year",
  y = "Union Density in (%)"
)
# Define the theme
plot_theme <- theme_minimal(base_size = 8, base_family = "Roboto") +
  theme(
    plot.title = element_text(
      size = 20, family = "Lobster Two",
      face = "bold", color = "#2a475e"
    ),
    axis.title.x = element_text(size = 15, face = "bold", color = "black"),
    axis.title.y = element_text(
      size = 15, face = "bold", color = "black",
      margin = margin(t = 10, b = 0, l = 10, r = 2)
    ),
    axis.text.x = element_text(
      size = 10, color = "black",
      margin = margin(t = 5, b = 0, l = 0, r = 0)
    ),
    axis.text.y = element_text(
      size = 10, color = "black",
      margin = margin(t = 0, b = 5, l = 0, r = 5)
    ),
    legend.position = "none",
    plot.margin = margin(t = 1, r = 1, b = 40, l = 1, unit = "pt"),
    axis.ticks = element_line(size = 2, colour = "grey50"),
    axis.line = element_line(colour = "grey50"),
    panel.grid = element_line(color = "#b4aea9"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_line(linetype = "dashed"),
    panel.grid.major.y = element_line(linetype = "dashed"),
    panel.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4"),
    plot.background = element_rect(fill = "#fbf9f4", color = "#fbf9f4")
  )
cit_style <- annotate(
  "text",
  x = max(long_data$Year), y = min(long_data$Value),
  label = wrapped_citation,
  hjust = 1, vjust = -9.4,
  size = 3, color = "grey50",
  angle = 0
)



# library(knitr)
# library(highr)
# library(evaluate)
# library(xfun)
#
# setwd("~/Lab2/Trade Union Global Analysis./")
# knit("TradeUnion.Rnw")
