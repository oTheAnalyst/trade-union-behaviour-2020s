# URL of the text data
url <- "https://striketracker.ilr.cornell.edu/geodata.js"

# File path to save the downloaded text
file_path <- "geodata.js"

# Download the text file
download.file(url, destfile = file_path, mode = "wb")

# Read the downloaded text content
raw_content <- readLines(file_path)

# Display the first few lines of the downloaded content
head(raw_content)
