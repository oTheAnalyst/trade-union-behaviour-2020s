library(ggplot2)
library(dplyr)
library(purrr)
library(stringr)

source("~/Lab2/Trade_Union_Global_Analysis/summary_analysis/Enviroment_Setup.R")


# Function to create plots
create_plot <- function(data, title, states) {
  # Filter data for selected states
  filtered_data <- data %>% filter(StateName %in% states)

  # Define wrapped title
  wrapped_title <- str_wrap(title, width = 40)

  # Create the ggplot object
  plot <- ggplot(filtered_data, aes(x = Year, y = Value, group = StateName)) +
    geom_line(aes(color = StateName), size = 1.5) +
    scale_color_manual(values = setNames(rainbow(length(states)), states)) +
    scale_x_continuous(breaks = seq(min(filtered_data$Year), max(filtered_data$Year), by = 5)) +
    labs(title = wrapped_title, x = "Year", y = "Union Membership Density") +
    theme_minimal() +
    theme(legend.position = "bottom") +
    plot_theme +
    cit_style

  return(plot)
}

# Define the states
southern_states <- c(
  "Alabama", "Arkansas", "Florida", "Georgia", "Kentucky",
  "Louisiana", "Mississippi", "North Carolina", "South Carolina",
  "Tennessee", "Texas", "Virginia", "West Virginia"
)

northern_states <- c(
  "Connecticut", "Illinois", "Indiana", "Iowa", "Maine",
  "Massachusetts", "Michigan", "Minnesota", "New Hampshire",
  "New Jersey", "New York", "Ohio", "Pennsylvania", "Rhode Island",
  "Vermont", "Wisconsin"
)

# Create a list of state names and corresponding titles
states_list <- list(
  southern = list(states = southern_states, title = "Southern States"),
  northern = list(states = northern_states, title = "Northern States")
)

# Use purrr::map to create plots for each group and store them in a list
plots_list <- map(states_list, ~ create_plot(long_data, .x$title, .x$states))

# Print the list to view the stored plots
print(plots_list)
