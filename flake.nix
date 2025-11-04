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

      shellHook = "
        if [ ! -f ./inst/dev.duckdb ]; then
        duckdb ./inst/dev.duckdb < ./inst/sql/setup_schema_sequence.sql
        duckdb ./inst/prod.duckdb < ./inst/sql/setup_schema_sequence.sql
        echo 'dev.ddb initiating database creation'
        echo 'initiating schema creation'
        fi

           ";
    };
  };
}
