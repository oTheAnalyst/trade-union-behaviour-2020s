# This file was generated by the {rix} R package v0.7.1 on 2024-06-05
# with following call:
# >rix(r_ver = "3b01abcc24846ae49957b30f4345bab4b3f1d14b",
#  > r_pkgs = c("tidyverse",
#  > "targets",
#  > "tarchetypes",
#  > "rmarkdown",
#  > "openxlsx",
#  > "readxl"),
#  > system_pkgs = NULL,
#  > git_pkgs = NULL,
#  > ide = "other",
#  > project_path = ".",
#  > overwrite = TRUE,
#  > print = TRUE,
#  > shell_hook = "Rscript -e 'targets::tar_make()'")
# It uses nixpkgs' revision 3b01abcc24846ae49957b30f4345bab4b3f1d14b for reproducibility purposes
# which will install R version latest.
# Report any issues to https://github.com/b-rodrigues/rix
let
 pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/3b01abcc24846ae49957b30f4345bab4b3f1d14b.tar.gz") {};
 
 rpkgs = builtins.attrValues {
  inherit (pkgs.rPackages) 
      tidyverse
      targets
      tarchetypes
      rmarkdown
      openxlsx
      readxl;
 };
   
 system_packages = builtins.attrValues {
  inherit (pkgs) R glibcLocales nix;
 };
  
in

 pkgs.mkShell {
   LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
   LANG = "en_US.UTF-8";
   LC_ALL = "en_US.UTF-8";
   LC_TIME = "en_US.UTF-8";
   LC_MONETARY = "en_US.UTF-8";
   LC_PAPER = "en_US.UTF-8";
   LC_MEASUREMENT = "en_US.UTF-8";

   buildInputs = [  rpkgs  system_packages  ];
   shellHook = "Rscript -e 'targets::tar_make()'";
 }