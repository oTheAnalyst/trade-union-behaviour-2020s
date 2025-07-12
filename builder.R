library(lubridate)
# I'm building a function that find the most recent data and
# copies it to replaces the prod.csv
# going to need to have all the data in list
# apply the date names to that list
# the data frame thats on an index of 1 is going to be written as prod data
# and its own datafile respecting the naming covention 


files <- base::list.files(here::here("data"))
files <- base::gsub("Labor-", "", files)
files <- base::gsub(".xlsx", "", files)
dates <- files[!grepl(paste0(c("prod", "output"), collapse = "|"), files)]
desc_dates <- lubridate::mdy(dates) |> sort(decreasing = TRUE)
print(desc_dates)


install.packages("esquisse")

library(esquisse)
esquisse:esquisser()

options("esquisse.display.mode" = "browser")
esquisser()