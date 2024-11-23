library(targets)
library(RSQLite)


super_function <- function() {

write_to_sql <- function(data, name) {
  driver <- RSQLite::dbDriver("SQLite")
  sql_location <- "~/trade_union-strikes.db"
  conn <- RSQLite::dbConnect(driver, sql_location)
  RSQLite::dbWriteTable(conn, name, data, overwrite = TRUE)
  RSQLite::dbDisconnect(conn)
}

list_creator <- function() {
  file_paths <- list.files(
    path = here::here("data"),
    pattern = "\\.xlsx$",
    full.names = TRUE
  )
  file_names <- basename(file_paths)
  list <- purrr::map(file_paths, readxl::read_xlsx)
  dbl <- purrr::set_names(list, file_names)
  return(dbl)
}

  
dblist <- list_creator()
names <- names(list)
results <- purrr::pmap(list(dblist, names), write_to_sql)
return(results)
}
