library(tidyverse)
library(gghighlight)

source("~/Lab2/Trade_Union_Global_Analysis/summary_analysis/Enviroment_Setup.R")
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

# Create color mapping
custom_colors <- setNames(
  c(
    "steelblue", "darkorange", "red",
    "limegreen", "deepskyblue", "gold",
    "purple", "#FF00FF", "pink"
  ),
  unique(filtered_data$ref_area)
)

# Assuming the range of years in your data
start_year <- min(filtered_data$time)
end_year <- max(filtered_data$time)

# Plotting Union Density over time for each country with integer year labels
p1 <- filtered_data %>%
  ggplot(aes(
    x = time, y = `Union Density`,
    group = ref_area, color = ref_area
  )) +
  geom_line() +
  geom_point(size = 2) +
  facet_wrap(~ref_area, scales = "free_x") +
  theme_minimal(base_family = "Gudea") +
  common_theme() +
  labs(
    title = "Union Density Over a Period of 5 Years",
    x = "Year", y = "Union Density", color = "Country"
  ) +
  scale_color_manual(values = custom_colors) +
  scale_x_continuous(breaks = seq(start_year, end_year, by = 1)) # Integer year breaks

# Plotting Collective Bargaining Coverage over time for each country with integer year labels
p2 <- filtered_data %>%
  ggplot(aes(x = time, y = `Collective Bargaining Coverage`, group = ref_area, color = ref_area)) +
  geom_line() +
  geom_point(size = 2) +
  facet_wrap(~ref_area, scales = "free_x") +
  theme_minimal(base_family = "Gudea") +
  common_theme() +
  labs(
    title = "Collective Bargaining Coverage Over a Period of 5 Years",
    x = "Year", y = "Collective Bargaining Coverage", color = "Country"
  ) +
  scale_color_manual(values = custom_colors) +
  scale_x_continuous(breaks = seq(start_year, end_year,
    by = 1
  )) # Integer year breaks

print(p1)
print(p2)
