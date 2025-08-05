{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    rPackages = with pkgs.rPackages; [
      tidyverse
      devtools
      testthat
      reshape2
      repurrrsive
      reticulate
      esquisse
      DT
      ragg
      DBI
      gridExtra
      plotly
      RSQLite
      palmerpenguins
      thematic
      ggridges
      bsicons
      reactable
      shiny
      bslib
      httpgd
      visNetwork
      lintr
      languageserver
      here
      hrbrthemes
      targets
      tarchetypes
      rmarkdown
      openxlsx
      readxl
      shinydashboard
      htmltools
      bslib
      packrat
      rsconnect
      shiny
      (pkgs.rPackages.buildRPackage {
        name = "htmltools";
        src = pkgs.fetchzip {
          url = "https://cran.r-project.org/src/contrib/Archive/htmltools/htmltools_0.5.8.tar.gz";
          sha256 = "sha256-a7ORSO6bXB2M+lPbn5w460VSY7wCXHTz1KDW+OBqlWQ=";
        };
        propagatedBuildInputs = with pkgs.rPackages; [
          base64enc
          digest
          fastmap
          rlang
        ];
      })
    ];
  in {
    devShells.${system}.default =
      pkgs.mkShell {
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";

        buildInputs = with pkgs; [
          pandoc
          glibcLocales
          dbt
          nix
          gnumake
          libgcc
          gccgo
          neovim
          sqlite
          (python313.withPackages (
            ps: with ps; [
              numpy
              pandas
            ]
          ))
          (rWrapper.override {packages = rPackages;})
          (rstudioWrapper.override {packages = rPackages;})
        ];

#        shellHook = "
#  Rscript -e 'targets::tar_make()'
#        echo 'Welcome to the trade union analysis shell the data for your models\n has already been build. Please update your data via the inputs\n folder, all your data will be generated in outputs and summarized\n in the paper. When you add more data or make changes\n rebuildthe data by:\n running _targets.R\n then inputting tar_make() in the console'
#      ";
      };
  };
}
