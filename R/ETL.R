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


#' motherduck_df
#'
#' @param input 
#'
#'
#' @returns this function reads data from mother duck and pulls it in as a dataframe
#' @export 
motherduck_df <- function(input) {
    con <- DBI::dbConnect(duckdb::duckdb())
    DBI::dbExecute(con, "INSTALL 'motherduck'")
    DBI::dbExecute(con, "LOAD 'motherduck'")
    DBI::dbExecute(con, "ATTACH 'md:'")
    DBI::dbExecute(con, "USE prod_lat")
     token  <<- DBI::dbExecute(con, "PRAGMA PRINT_MD_TOKEN;")
    res <- DBI::dbGetQuery(con, paste0("SELECT * FROM ",input,"")) |>
           tibble::as_tibble()
    print(res)
}


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
  
  
  excel_tibble$'End Date' <- as.POSIXct(
        excel_tibble$'End Date',
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
  # input_list <- load_list(input)
  input_df <- dsa::motherduck_df(input)
  #this transforms the the data
  tx_list <- dsa::transform_data(input_df) 
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
  sql_location <- system.file("extdata","db","dev.duckdb",package = "dsa")
  con <- DBI::dbConnect(duckdb::duckdb())
    con <- DBI::dbConnect(duckdb::duckdb())
    DBI::dbExecute(con, "INSTALL 'motherduck'")
    DBI::dbExecute(con, "LOAD 'motherduck'")
    DBI::dbExecute(con, token)
    DBI::dbExecute(con, "ATTACH 'md:'")
    DBI::dbExecute(con, "USE prod_lat")
  DBI::dbWriteTable(con, name2, data, append = TRUE)
  DBI::dbDisconnect(con)
  return(paste0("written to table ", name2))
}




#' record insert
#'
#' @returns record each write
#' @export
record_insert <- function(flocation){
  insert <- paste0("
   INSERT INTO stg_imports 
   SELECT 
   nextval('serial'),
   import_dt,
   'email',
   '",flocation,"',
   'NA',
   'NA'
   FROM stg_lat_imports
   WHERE 
   import_dt
   NOT IN(
  select import_dt from stg_imports 
   ) GROUP BY import_dt;")
  
    sql_location <- system.file("extdata","db","dev.duckdb",package = "dsa")
    
    con <- DBI::dbConnect(duckdb::duckdb())
    DBI::dbExecute(con, "INSTALL 'motherduck'")
    DBI::dbExecute(con, "load 'motherduck'")
    DBI::dbExecute(con, "attach 'md:'")
    DBI::dbGetQuery(con, "PRAGMA PRINT_MD_TOKEN")
    DBI::dbExecute(con, "use prod_lat")
    DBI::dbSendQuery(con,insert)
    DBI::dbDisconnect(con)
}


#' main_write
#'
#' @return for running package function to database
#' @export
main_write <- function(){
  loc <- system.file("extdata", package = "dsa") 
  dt <- dsa::load_transform_data("stg_lat_unformatted") 
  dsa::write_to_sql(data = dt, name = 'stg_lat_imports')
  dsa::record_insert(loc)
  return("Wrote data to stg_lat_imports, added timestamp and unique id stg_imports")
}
