library(ggplot2)
library(dplyr)
library(forcats)
library(tibble)
library(purrr)

# Function to create a plot
create_plot <- function(data, year_focus, y_variable, title_prefix) {
  data_filtered <- data %>%
    filter(time == year_focus) %>%
    mutate(ref_area = fct_reorder(ref_area, !!sym(y_variable)))

  ggplot(data_filtered, aes(x = ref_area, y = !!sym(y_variable))) +
    geom_bar(stat = "identity") +
    coord_flip() +
    labs(
      title = paste(title_prefix, year_focus),
      x = "Country",
      y = y_variable
    ) +
    plot_theme
}
# Define analysis details
analyses <- list(
  list(
    y_variable = "Collective Bargaining Coverage",
    title_prefix = "Comparative Analysis of Collective Bargaining Coverage in"
  ),
  list(
    y_variable = "National_Compliance_wth_Labour_Rights",
    title_prefix = "Comparative Analysis of Countries Compliance with international labor law"
  ),
  list(
    y_variable = "Union Density",
    title_prefix = "Comparative Analysis of Union Density in different countries"
  )
)
# Map to create plots for each analysis
plots_list <- map(analyses, function(analysis) {
  map(2015:2020, ~ create_plot(
    joined_full_data_set,
    .x, analysis$y_variable,
    analysis$title_prefix
  ))
})
# Convert the plots list to a tibble
plots_tibble <- tibble::enframe(plots_list, name = "Plot_Type", value = "Plot")
plots_tibble
