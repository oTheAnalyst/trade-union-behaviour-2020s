
install.packages("rnaturalearth")
library(cartography)
library(sp)

source("~/Lab2/Trade_Union_Global_Analysis/summary_analysis/Enviroment_Setup.R")
# Assuming joined_full_data_set is already loaded
# joined_full_data_set <- ...

# Example: Assuming 'ref_area' in joined_full_data_set matches 'id' in nuts2.df
# and we are visualizing 'Union Density'

# Prepare the data: Aggregate or process your data as needed
# Example: Compute average Union Density per region
union_density_avg <- joined_full_data_set %>%
  group_by(ref_area) %>%
  summarize(average_union_density = mean(`Union Density`, na.rm = TRUE))

# Merge with spatial data
nuts2.df <- merge(nuts2.df, union_density_avg, by.x = "id", by.y = "ref_area", all.x = TRUE)

# Build a color palette
cols <- carto.pal(pal1 = "green.pal", n1 = 2, pal2 = "red.pal", n2 = 4)

# Plot background shapes (sea and world)
plot(nuts0.spdf, border = NA, col = NA, bg = "#A6CAE0")
plot(world.spdf, col = "#E3DEBF", border = NA, add = TRUE)

# Add Union Density layer
choroLayer(
  spdf = nuts2.spdf, df = nuts2.df, var = "average_union_density",
  breaks = seq(min(nuts2.df$average_union_density, na.rm = TRUE), max(nuts2.df$average_union_density, na.rm = TRUE), length.out = 7),
  col = cols, border = "grey40", lwd = 0.5, legend.pos = "right",
  legend.title.txt = "Average Union Density",
  legend.values.rnd = 2, add = TRUE
)

# Add borders
plot(nuts0.spdf, border = "grey20", lwd = 0.75, add = TRUE)

# Add titles, legend ...
layoutLayer(
  title = "Union Density in Europe",
  author = "cartography", sources = "Source Data",
  frame = TRUE, col = NA, scale = NULL, coltitle = "black",
  south = TRUE
)


library(tidyverse)
library(sp)
library(cartography)
library(rnaturalearth)

# Load country shapes
world <- ne_countries(scale = "medium", returnclass = "sp")

# Assuming joined_full_data_set is already loaded
# joined_full_data_set <- ...

# Prepare the data: Aggregate or process your data as needed
union_density_avg <- joined_full_data_set %>%
  group_by(country) %>%
  summarize(average_union_density = mean(`Union Density`, na.rm = TRUE))

# Merge with spatial data
world@data <- merge(world@data, union_density_avg, by.x = "name", by.y = "country", all.x = TRUE)

# Build a color palette
cols <- carto.pal(pal1 = "green.pal", n1 = 2, pal2 = "red.pal", n2 = 4)

# Plot background shapes (sea and world)
plot(world, border = NA, col = NA, bg = "#A6CAE0")

# Add Union Density layer
choroLayer(spdf = world, df = world@data, var = "average_union_density",
    breaks = seq(min(world@data$average_union_density, na.rm = TRUE), max(world@data$average_union_density, na.rm = TRUE), length.out = 7),
    col = cols, border = "grey40", lwd = 0.5, legend.pos = "right",
    legend.title.txt = "Average Union Density",
    legend.values.rnd = 2, add = TRUE)

# Add titles, legend ...
layoutLayer(title = "Union Density in Countries",
    author = "cartography", sources = "Source Data",
    frame = TRUE, col = NA, scale = NULL, coltitle = "black",
    south = TRUE)


str(joined_full_data_set)





# Load necessary libraries
library(tidyverse)
library(sp)
library(rnaturalearth)
library(cartography)

# Assuming joined_full_data_set is already loaded
# joined_full_data_set <- ...

# Prepare the data: Aggregate Union Density by country
union_density_avg <- joined_full_data_set %>%
  group_by(ref_area) %>%
  summarize(average_union_density = mean(Union Density, na.rm = TRUE))

# Load European country shapes
europe_countries <- ne_countries(scale = "medium", returnclass = "sp", continent = "Europe")

# Merge with spatial data
europe_countries@data <- merge(europe_countries@data, union_density_avg, by.x = "name", by.y = "ref_area", all.x = TRUE)

# Build a color palette
cols <- carto.pal(pal1 = "green.pal", n1 = 2, pal2 = "red.pal", n2 = 4)

# Plot background shapes (sea and Europe)
plot(europe_countries, border = NA, col = NA, bg = "#A6CAE0")

# Add Union Density layer
choroLayer(spdf = europe_countries, df = europe_countries@data, var = "average_union_density",
    breaks = seq(min(europe_countries@data$average_union_density, na.rm = TRUE), max(europe_countries@data$average_union_density, na.rm = TRUE), length.out = 7),
    col = cols, border = "grey40", lwd = 0.5, legend.pos = "right",
    legend.title.txt = "Average Union Density",
    legend.values.rnd = 2, add = TRUE)

# Add titles, legend ...
layoutLayer(title = "Union Density in European Countries",
    author = "cartography", sources = "Source Data",
    frame = TRUE, col = NA, scale = NULL, coltitle = "black",
    south = TRUE)
