{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/25.05";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    rPackages = with pkgs.rPackages; [
      tidyverse
      httpgd
      visNetwork
      lintr
      languageserver
      duckdb
      DBI
      rmarkdown
      readxl
      devtools
      testthat
      reshape2
      repurrrsive
      esquisse # need it all up from here 
    ];
  in {
    devShells.${system}.default = pkgs.mkShell {
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
        duckdb
        (python313.withPackages (
          ps:
            with ps; [
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
