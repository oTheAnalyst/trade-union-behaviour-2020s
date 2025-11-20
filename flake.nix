{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    rPackages = with pkgs.rPackages; [
      tidyverse
      httpgd
      visNetwork
      lintr
      languageserver
      nixpkgs-unstable.legacyPackages.${pkgs.system}.duckdb
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

      shellHook = "
        if [ ! -f ./inst/extdata/db/dev.duckdb ]; then
        mkdir ./inst/extdata/db
        duckdb ./inst/extdata/db/dev.duckdb < ./inst/sql/setup_schema_sequence.sql
        echo 'duckdb initiating database creation \n
        initiating schema creation'
        fi

           ";
    };
  };
}
