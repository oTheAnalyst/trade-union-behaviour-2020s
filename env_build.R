library(rix)

setwd("~/Lab4/")

rix_init(
  project_path = ".",
  rprofile_action = c("create_missing", "create_backup", "overwrite", "append"),
  message_type = c("simple", "verbose")
)

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
  system_pkgs = "pandoc",
  git_pkgs = NULL,
  ide = "other",
  shell_hook = "
  Rscript -e 'targets::tar_make()
  '",
  overwrite = TRUE
)
