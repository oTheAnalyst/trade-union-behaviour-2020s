# About

This a rework of Trade-Union-Analysis (repo featured on my github) on Union Density& labour strikes. The goal of this is to make the Trade-Union-Analysis code cleaner, cogent, precise, and reproducible.

This analysis uses `{targets}` & `{rix}` to build a reproducible pipeline in R-Programming. The data is sourced from the Cornell University's Labor Action Tracker and is updated monthly. The pipeline is built in entirely in R and is reproducible by running `tar_make()` in the `targets_.R` file. Paths do not not be adjusted per operating system thanks to the {here} package. Mac or windows user can have tableau installed locally and link it to the xlsx document output to make the process more streamlined. Linux users will not be able install and run tableau instead should consider running `tiny11` on a virtual machine.

## Visual of Targets Pipeline

![image](https://github.com/VtheRtech/trade-union-behavior-2020s/assets/30744769/7efc4627-36e5-4891-bc16-5e6532ac5c9c)

[Link to tableau public Visualization](https://public.tableau.com/app/profile/vcumbo/viz/unionworkbook/DMVYearlyNational2)
![image of tableau dashboard](<https://github.com/VtheRtech/trade-union-behavior-2020s/blob/main/paper/paper_files/DMV & Yearly National.png?raw=true>)

## How to use

Clone the repo

```{bash}
git clone https://github.com/VtheRtech/trade-union-behavior-2020s.git
```

CD into the git repo

```{bash}
cd ~/trade-union-behavior-2020s
```

Run this to build the shell environment from default.nix

```{bash}
nix-build
```

Running this command will enter the shell environment and automatically build targets.

```{bash}
nix-shell
```

Hooks will run tar_make() building the pipeline and the data.
