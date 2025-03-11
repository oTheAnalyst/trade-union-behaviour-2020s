library(dplyr)
library(tidyverse)
library(readr)


data <- read_csv("data.csv")

data %>%
  mutate(NumberOfLocations = as.numeric(NumberOfLocations)) %>%
  pull(NumberOfLocations) %>%
  print()
