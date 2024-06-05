library(rix)

rix(
  r_ver = "latest",
  r_pkgs =
    c(
      "tidyverse",
      "targets",
      "tarchetypes",
      "rmarkdown",
      "openxlsx",
      "readxl"
    ),
  system_pkgs = NULL,
  git_pkgs = NULL,
  ide = "code",
  project_path = "~/Lab4/",
  overwrite = TRUE,
  print = TRUE
)
