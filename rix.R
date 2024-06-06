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
  system_pkgs = "pandoc",
  git_pkgs = NULL,
  ide = "other",
  shell_hook = "
  Rscript -e 'targets::tar_make()
  '",
  overwrite = TRUE
)
