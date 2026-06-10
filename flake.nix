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
    pythonEnv = pkgs.python3.withPackages (ps:
      with ps; [
        numpy
        pandas
      ]);
  in {
    devShells.${system}.default = pkgs.mkShell {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";

      buildInputs = with pkgs; [
        pandoc
        glibcLocales
        csv2parquet
        dbt
        nix
        gnumake
        nixpkgs-unstable.legacyPackages.${pkgs.system}.duckdb
        libgcc
        gccgo
        pythonEnv
        (rWrapper.override {packages = rPackages;})
        (rstudioWrapper.override {packages = rPackages;})
      ];
    };
  };
}
