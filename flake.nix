{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = {nixpkgs-unstable, ...}: let
    system = "x86_64-linux";
    #       ↑ Swap it for your system if needed
    #       "aarch64-linux" / "x86_64-darwin" / "aarch64-darwin"
    pkgs = nixpkgs-unstable.legacyPackages.${system};
  in {
    pkgs = import nixpkgs-unstable {inherit system;};
    devShells.${system}.default = let
      rPackages = with pkgs.rPackages; [
        tidyverse
        visNetwork
        lintr
        languageserver
        reticulate
        #duckdb
        DBI
        rmarkdown
        readxl
        devtools
        testthat
        reshape2
        repurrrsive
        esquisse # need it all up from here
      ];
      pythonpkgs = (pkgs.python3.withPackages (ps:
        with ps; [
          duckdb
          numpy
          requests
        ])).override {ignoreCollisions = true;};
    in
      pkgs.mkShell {
        packages = with pkgs; [
          pandoc
          glibcLocales
          nix
          gnumake
          duckdb
          libgcc
          gccgo
          pythonpkgs
          (rWrapper.override {packages = rPackages;})
          (rstudioWrapper.override {packages = rPackages;})
        ];
      };
  };
}
