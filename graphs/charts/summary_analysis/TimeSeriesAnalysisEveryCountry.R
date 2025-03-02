# please run ~/Lab2/Trade Union Global Analysis./Enviroment_Setup.R
source("~/Lab2/Trade_Union_Global_Analysis/summary_analysis/Enviroment_Setup.R",
  local = TRUE
)


# before running this analysis
# Load necessary libraries
country_focus <- unique(joined_full_data_set$ref_area)
country_focus
create_plot <- function(country) {
  TUD_country <- joined_full_data_set %>%
    filter(ref_area == country)
  # Plotting for trends in union density over time
  p <- ggplot(TUD_country, aes(x = time, y = `Union Density`, group = 1)) +
    geom_line() +
    labs(
      title = paste("Time Series of Union Density in", country),
      x = "Time",
      y = "Union Density"
    ) +
    theme_minimal()
}
# labels the tu_density_plots for readability
tu_density_plots <- setNames(
  map(country_focus, create_plot),
  country_focus
)
# Access and display the plot for Sweden
print(tu_density_plots[["Sweden"]])



# Display all the tu_density_plots
walk(tu_density_plots, print)
