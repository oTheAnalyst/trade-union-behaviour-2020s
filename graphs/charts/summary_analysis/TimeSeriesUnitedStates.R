library(ggplot2)
library(dplyr)
library(forcats)
library(tibble)


# tudr is trade union density
# cbcr is collective bargaining Coverage
# wpr is work place rights
source("~/Lab2/Trade_Union_Global_Analysis/summary_analysis/Enviroment_Setup.R",
  local = TRUE
)
country_focus <- unique(joined_full_data_set$ref_area)
country_focus
create_plot <- function(country) {
  tud_country <- joined_full_data_set %>%
    filter(ref_area == country)
  p <- ggplot(tud_country, aes(x = time, y = `Union Density`)) +
    geom_line(color = "#00BFC4", linewidth = 1.2) +
    labs(
      title = paste("Time Series of Union Density in", country, "(ILOdata)"),
      x = "Year", y = "Union Density (in %)"
    ) +
    theme_minimal(base_size = 14) +
    tstheme
}
# labels the tu_density_plots for readability
tu_density_plots <- setNames(
  map(country_focus, create_plot),
  country_focus
)
# Access and display the plot for Sweden
print(tu_density_plots[["Sweden"]])


# retooled with purrr, for tudr (the more complete data set for union density)
# earlier sets such as TUD_ and tu_density are more incomplete
country_focus <- unique(tudr$ref_area)
create_plot <- function(country) {
  tudr_country <- tudr %>%
    filter(ref_area == country)
  plot <- ggplot(tudr_country, aes(x = time, y = obs_value)) +
    geom_line(color = "#1b9e77", size = 1.2) +
    geom_point(color = "#7570b3", size = 2, alpha = 0.7) +
    labs(
      title = paste("Time Series of Trade Union Density in", country, "(ILOdata)"),
      x = "Year", y = "Trade Union Density (in %)"
    ) +
    theme_minimal(base_size = 14) +
    tstheme
}
tudr_plots <- setNames(
  map(country_focus, create_plot),
  country_focus
)
print(tudr_plots[["Sweden"]])


# retooled cbcr function for purr
country_focus <- unique(cbcr$ref_area)
create_plot <- function(country) {
  cbcr_country <- cbcr %>%
    filter(ref_area == country)
  plot <- ggplot(cbcr_country, aes(x = time, y = obs_value)) +
    geom_line(color = "#2ca02c", size = 1.2) +
    geom_point(color = "#d62728", size = 2, alpha = 0.7) +
    labs(
      title = paste(
        "Collective Bargaining Coverage Over Time in",
        country, "(ILOdata)"
      ),
      x = "Year", y = "Collective Bargaining Coverage (in %)"
    ) +
    theme_minimal(base_size = 14) +
    tstheme
}
cbcr_plots <- setNames(
  map(country_focus, create_plot),
  country_focus
)
print(cbcr_plots[["Sweden"]])


country_focus <- unique(workplace_rights$ref_area)
create_plot <- function(country) {
  workplace_rights_country <- workplace_rights %>%
    filter(ref_area == country)
  plot <- ggplot(workplace_rights_country, aes(x = time, y = obs_value)) +
    geom_line(color = "#1f78b4", size = 1.2) +
    geom_point(color = "#33a02c", size = 2, alpha = 0.7) +
    labs(
      title = paste("Compliance with International Labor Law Over Time in", country, "(ILOdata)"),
      x = "Year", y = "Compliance with International Labor Law (Rating)"
    ) +
    theme_minimal(base_size = 14) +
    tstheme +
    annotate("text",
      x = Inf, y = Inf, label = "Source: Your Source Here",
      hjust = 1.1, vjust = 2, size = 3.5, color = "grey50"
    )
}
wpr_plots <- setNames(
  map(country_focus, create_plot),
  country_focus
)


# test
print(wpr_plots[["China"]])
print(cbcr_plots[["China"]])
print(tudr_plots[["China"]])
