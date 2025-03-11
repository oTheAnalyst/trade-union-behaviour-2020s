source("~/Lab2/Trade_Union_Global_Analysis/summary_analysis/Enviroment_Setup.R")


plots_list2 <- list()
long_data <- state_union_membership_density %>%
  pivot_longer(
    cols = -c(StateName, StateID), # Exclude non-year columns
    names_to = "Year",
    values_to = "Value"
  )
# Convert Year to a numeric value for plotting
long_data$Year <- as.numeric(long_data$Year)
state_focus <- unique(long_data$StateName)
# loop starts
for (StateName in state_focus) {
  # Filter data for the current state in the loop
  state_data <- long_data[long_data$StateName == StateName, ]
  title_text <- paste("Time Series of Union Density in", StateName)
  wrapped_title <- str_wrap(title_text, width = 40)
  # Create the plot using the filtered data
  p <- ggplot(state_data, aes(x = Year, y = Value)) +
    geom_line() +
    labs(
      title = wrapped_title,
      x = "Year",
      y = "Union Density (%)"
    ) +
    tstheme # Add theme
  plots_list2[[paste("Union Density", StateName)]] <- p
}
# loop ends
long_data <- state_union_coverage_density %>%
  pivot_longer(
    cols = -c(StateName, StateID), # Exclude non-year columns
    names_to = "Year",
    values_to = "Value"
  )
# Convert Year to a numeric value for plotting
long_data$Year <- as.numeric(long_data$Year)
state_focus <- unique(long_data$StateName)
# loop starts
for (StateName in state_focus) {
  state_data <- long_data[long_data$StateName == StateName, ]
  state_focus <- unique(long_data$StateName)
  title_text <- paste(
    "Time Series of Collective Bargaining Coverage in",
    StateName
  )
  wrapped_title <- str_wrap(title_text, width = 40)
  p <- ggplot(state_data, aes(x = Year, y = Value)) +
    geom_line() +
    labs(
      title = wrapped_title,
      x = "Year",
      y = "Coverage Density in (%)"
    ) +
    tstheme # Add theme
  plots_list2[[paste("Coverage Density", StateName)]] <- p
}
# loop ends
# convert list to tibble
usplots_tibble <- tibble::enframe(plots_list2,
  name = "Plot_Type",
  value = "Plot"
)
desired_plot_row <- usplots_tibble %>%
  filter(Plot_Type == "Coverage Density West Virginia")
desired_plot <- desired_plot_row$Plot[[1]]
print(desired_plot)
desired_plot_row <- usplots_tibble %>%
  filter(Plot_Type == "Union Density West Virginia")
desired_plot <- desired_plot_row$Plot[[1]]
print(desired_plot)

head(usplots_tibble)
tail(usplots_tibble)

View(usplots_tibble)
