# About

This a rework of Trade-Union-Analysis (repo featured on my github) on Union Density& labour strikes. The goal of this is to make the Trade-Union-Analysis code cleaner, cogent, and more precise.

This analysis uses `{targets}` to build a reproducible pipeline in R-Programming. The data is sourced from the Cornell University's Labor Action Tracker and is updated monthly. The pipeline is built in entirely in R and is reproducible by running the `targets_.R` file. Paths in `targets_.R` may need to be adjusted to your operating system preferences. Mac or windows user can have tableau installed locally and link it to the xlsx document output for to make to process more streamlined. Linux users will not be able install and run tableau instead should consider running `tiny11` on a virtual machine.

## Visual of Targets Pipeline

![image](https://github.com/VtheRtech/trade-union-behavior-2020s/assets/30744769/7efc4627-36e5-4891-bc16-5e6532ac5c9c)

[Link to tableau public Visualization](https://public.tableau.com/app/profile/vcumbo/viz/unionworkbook/d3)
![image]("~/Lab4/paper/paper_files/d3.png")

## How to use

cd in the git repro

```
cd ~/trade-union-behavior-2020s
```

run nix inside repro

```
nix-build

nix-shell
```

hooks will run tar_make() building the pipeline and the data
