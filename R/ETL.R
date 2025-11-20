# This is an example function named 'hello' 
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   https://r-pkgs.org
#
# Some useful keyboard shortcuts for package authoring: #
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'
#

#' load_list
#'
#' @param input 
#'
#' @return this function will load the list of data within the package
#' @export
load_list <- function(input) {
 #load in the data paths  
  file_paths <- list.files(
    path = input,
    pattern = "\\.xlsx$",
    full.names = TRUE
  )
 
#read the path output a list 
 files <- file_paths |> 
  purrr::map(readxl::read_xlsx) 
 # set the name as a list
 names <-  basename(file_paths )
 names <- gsub(".xlsx", "", names)
  files <- files |> 
   purrr::set_names(names) 
 return(files)
}


#' transform_data
#'
#' @param input 
#'
#' @return transforms loaded data
#' @export
transform_data <- function(input) {
  # Read Excel file and convert to tibble
  excel_tibble <- input
  
  excel_tibble$'Start Date' <- as.POSIXct(
        excel_tibble$'Start Date',
        format = "%m/%d/%Y", tz = "UTC"
        )
  
  tx_data <- excel_tibble |>
    janitor::clean_names(case = "lower_camel")
  
 # Mutate columns as needed
 # tx_data <- tx_data |>
 #   dplyr::mutate(
 #     id = as.integer(ID),
 #     durationAmount = as.integer(durationAmount),
 #     approximateNumberOfParticipants = as.integer(approximateNumberOfParticipants),
 #     durationAmount = as.integer(durationAmount),
 #     numberOfLocations = as.integer(numberOfLocations),
 #   )
 #
  return(tx_data)
}

#' load_and_transform_data
#'
#' @param input 
#'
#' @return this is main() function
#' @export
load_transform_data <- function(input) {
  #input list
  input_list <- load_list(input)
  #this transforms the the data
  tx_list <- purrr::map(input_list, transform_data)
  return(tx_list)
  # Return a message indicating successful saving
  message("Transformed data saved successfully")
}



#' write_to_sql
#'
#' @param input 
#'
#' @return writes data to sql
#' @export
write_to_sql <- function(data, name) {
  name2 <- DBI::SQL(name)
  sql_location <- "~/dev.duckdb"
  con <- duckdb::dbConnect(duckdb::duckdb(), sql_location)
  duckdb::dbWriteTable(conn = con,
                       name = name2,
                       value = data, 
                       append = TRUE)
  duckdb::dbDisconnect(con)
  return(paste0("written to table ", name2))
}



#' record insert
#'
#' @returns record each write
#' @export
record_insert <- function(flocation){
  insert <- paste0("
   INSERT INTO dataImports.stg_imports 
   SELECT 
   nextval('dataImports.serial'),
   import_dt,
   'email',
   '",flocation,"',
   'NA',
   'NA'
   FROM dataImports.stg_lat_imports
   WHERE 
   import_dt
   NOT IN(
  select import_dt from dataImports.stg_imports 
   ) GROUP BY import_dt;")
  
    sql_location <- "~/dev.duckdb"
    con <- DBI::dbConnect(duckdb::duckdb(), sql_location)
    DBI::dbSendQuery(con,insert)
    DBI::dbDisconnect(con)
}

#' main_write
#'
#' @return for running package function to database
#' @export
main_write <- function(){
  loc <- base::system.file("extdata", package = "dsa") 
  dt <- dsa::load_transform_data(loc) 
  test <- dt$`Labor-prod`
  dsa::write_to_sql(data = test, name = "dataImports.stg_lat_imports")
  dsa::record_insert(loc)
}
