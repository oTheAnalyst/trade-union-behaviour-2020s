library(ggplot2)
library(dplyr)
library(stringr)
library(extrafont)
library(ggExtra)

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

median_line <- median(long_data$values, na.rm = TRUE)
# Create the ggplot object
p1 <- ggplot(long_data, aes(x = Year, y = Value, color = StateName)) +
  geom_line() +
  geom_hline(yintercept = median_line, linetype = "dashed", color = "blue") +
  scale_x_continuous(breaks = seq(min(long_data$Year),
    max(long_data$Year),
    by = 5
  )) +
  plot_labels + # Add the labels
  plot_theme +
  cit_style # Add the theme
# Print the plot
print(p1)

file_path <- ("~/Lab2/graphs/plot_10.png")
ggsave(file_path, plot = p1)


southern_states <- c(
  "Alabama", "Arkansas", "Florida", "Georgia", "Kentucky",
  "Louisiana", "Mississippi", "North Carolina", "South Carolina",
  "Tennessee", "Texas", "Virginia", "West Virginia"
)
# To view the vector
print(southern_states)
northern_states <- c(
  "Connecticut", "Illinois", "Indiana", "Iowa", "Maine",
  "Massachusetts", "Michigan", "Minnesota", "New Hampshire",
  "New Jersey", "New York", "Ohio", "Pennsylvania", "Rhode Island",
  "Vermont", "Wisconsin"
)
# To view the vector
print(northern_states)
title_text <- "Time Series Analysis of Union Density in the United States Northern States are Highlighted (%Percentage of a States Industry that are Unionized)"
wrapped_title <- str_wrap(title_text, width = 40)
#           northern_states time series
# Plotting with ggplot2
p2 <- ggplot(long_data, aes(x = Year, y = Value, group = StateName)) +
  # Plot all states not in northern_states in grey
  geom_line(
    data = filter(long_data, !StateName %in% northern_states),
    aes(color = "Other States"), linewidth = 0.5
  ) +
  # Highlight northern_states with individual colors
  geom_line(
    data = filter(long_data, StateName %in% northern_states),
    aes(color = StateName), linewidth = 1.5
  ) +
  scale_color_manual(values = c(
    "Other States" = "grey",
    setNames(rainbow(length(northern_states)), northern_states)
  )) +
  scale_x_continuous(breaks = seq(min(long_data$Year),
    max(long_data$Year),
    by = 5
  )) +
  theme_minimal() +
  labs(
    title = wrapped_title,
    x = "Year",
    y = "Union Membership Density",
  ) +
  theme(legend.position = "bottom") +
  plot_theme +
  cit_style
file_path <- ("~/Lab2/graphs/plot_11.png")
ggsave(file_path, plot = p2)






title_text <- "Time Series Analysis of Union Density in the United States Southern States are Highlighted (%Percentage of a States Industry that are Unionized)"
wrapped_title <- str_wrap(title_text, width = 40)
#          southern_states time series
p3 <- ggplot(long_data, aes(x = Year, y = Value, group = StateName)) +
  # Plot all states not in southern_states in grey
  geom_line(
    data = filter(long_data, !StateName %in% southern_states),
    aes(color = "Other States"), linewidth = 0.5
  ) +
  # Highlight southern_states with individual colors
  geom_line(
    data = filter(long_data, StateName %in% southern_states),
    aes(color = StateName), linewidth = 1.5
  ) +
  scale_color_manual(values = c(
    "Other States" = "grey",
    setNames(rainbow(length(southern_states)), southern_states)
  )) +
  scale_x_continuous(breaks = seq(min(long_data$Year),
    max(long_data$Year),
    by = 5
  )) +
  theme_minimal() +
  labs(
    title = wrapped_title,
    x = "Year",
    y = "Union Membership Density",
  ) +
  theme(legend.position = "bottom") +
  plot_theme +
  cit_style
file_path <- ("~/Lab2/graphs/plot_12.png")
ggsave(file_path, plot = p3)

##                               South vs North Summary Data
southern_states_mean <- long_data %>%
  filter(StateName %in% southern_states) %>%
  select(StateName, Value) %>%
  group_by(StateName) %>%
  summarise(union_density_mean = mean(Value))
southern_states_summary <- southern_states_mean %>%
  summary()
print(southern_states_mean)
print(southern_states_summary)


northern_states_mean <- long_data %>%
  filter(StateName %in% northern_states) %>%
  select(StateName, Value) %>%
  group_by(StateName) %>%
  summarise(union_density_mean = mean(Value))
northern_states_summary <- northern_states_mean %>%
  summary()
print(northern_states_mean)
print(northern_states_summary)
