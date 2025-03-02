library(dplyr)
library(stringr)
library(purrr)
library(rvest)
library(RSelenium)
library(RSQLite)
library(DBI)
library(RSQLite)

# Start the RSelenium driver and client
rD <- rsDriver(browser = "firefox", port = as.integer(1235), chromever = NULL)
remDr <- rD[["client"]]
# Start the RSelenium driver without specifying a port
remDr$navigate("https://striketracker.ilr.cornell.edu/")
# Wait for the elements to be present, adjusting sleep time as needed

Sys.sleep(5) # Adjust this value based on actual page load times
# Find all elements with the class '.tab-content'
webElems <- remDr$findElements(using = "css selector", value = ".tab-content")
# Initialize an empty list to store the inner HTML from each 'tab-content'
# Extract inner HTML using purrr::map()
innerHtmlList <- map(webElems, function(elem) {
  elem$getElementAttribute("innerHTML")[[1]]
})
# At this point, innerHtmlList
# contains the inner HTML of each '.tab-content' element
# You can now process or analyze the contents of this list as needed
# Example: Print the contents of innerHtmlList to the console
print(innerHtmlList)
# Close the Selenium driver and stop the server
remDr$close() # Close the browser session
rD[["server"]]$stop() # Stop the Selenium server
clean_text_list <- map(innerHtmlList, ~ str_remove_all(., "<[^>]+>"))
# Now clean_text_list contains cleaned strings from each HTML content
# Print the cleaned text of each element
print(clean_text_list)


# sets working directory connects to a
# local sqlite db and writes the raw data to it
setwd("~/workbook")
con <- dbConnect(RSQLite::SQLite(), "trade_union_data.db")
combined_df <- do.call(rbind, clean_text_list)
combined_df <- as.data.frame(combined_df)
# dbWriteTable(con, "rawonlystrike_table", combined_df)
rawonlystrike_table <- as_tibble(dbReadTable(con, "rawonlystrike_table"))
dbDisconnect(con)

print(clean_text_list[[4]])

strike_table <- rawonlystrike_table %>%
  mutate(
    Employer = str_extract(
      V1,
      "(?<=Employer : ).*(?= Labor Organization :)"
    ),
    LaborOrganization = str_extract(
      V1,
      "(?<=Labor Organization : ).*(?= Local :)"
    ),
    Local = str_extract(
      V1,
      "(?<=Local : ).*(?= Industry :)"
    ),
    Industry = str_extract(
      V1,
      "(?<=Industry : ).*(?= Bargaining Unit Size :)"
    ),
    BargainingUnitSize = str_extract(
      V1,
      "(?<=Bargaining Unit Size : ).*(?= Number of Locations :)",
    ),
    NumberofLocations = str_extract(
      V1,
      "(?<=Number of Locations : ).*(?= Adress :)"
    ),
    Address = str_extract(
      V1,
      "(?<=Address : ).*(?= City :)"
    ),
    City = str_extract(
      V1,
      "(?<=City : ).*(?= State :)"
    ),
    State = str_extract(
      V1,
      "(?<= State : ).*(?= Zip Code :)"
    ),
    ZipCode = str_extract(
      V1,
      "(?<= Zip Code : ).*(?= Strike or Protest :)"
    ),
    StrikeorProtest = str_extract(
      V1,
      "(?<= Strike or Protest : ).*(?= Number of Participants :)"
    ),
    NumberofParticipants = str_extract(
      V1,
      "(?<= Number of Participants : ).*(?= Start Date :)"
    ),
    StartDate = str_extract(
      V1,
      "(?<= Start Date : ).*(?= End Date :)"
    ),
    EndDate = str_extract(
      V1,
      "(?<=End Date : ).*(?= Worker Demands :)"
    ),
    WorkerDemands = str_extract(
      V1,
      "(?<=Worker Demands : ).*(?= Source :)"
    )
  )

# Assuming your tibble is named strike_table
strike_table <- strike_table %>%
  mutate_all(str_trim)
# Show the modified tibble
print(strike_table)
# Assuming your tibble is named strike_table
na_counts <- colSums(is.na(strike_table))
head(strike_table$StrikeorProtest)


strikefiltersna <- strike_table %>%
  summarise_all(~ sum(is.na(.)))


# Show the number of NA values in each column
print(strikefiltersna)
head(strike_table)

strike_table <- strike_table %>%
  select(-V1)

setwd("~/workbook")
con <- dbConnect(RSQLite::SQLite(), "trade_union_data.db")
dbWriteTable(con, "strike_table", strike_table, overwrite = TRUE)
dbDisconnect(con)
