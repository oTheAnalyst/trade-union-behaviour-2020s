# About

This a rework of Trade-Union-Analysis (repo featured on my github) on Union Density& labour strikes. The goal of this is to make the Trade-Union-Analysis code cleaner, cogent, and more precise.

This analysis uses `targets` to build a reproducible pipeline in R-Programming. The data is sourced from the Cornell University's Labor Action Tracker and is updated monthly. The pipeline is built in entirely in R and is reproducible by running the `targets_.R` file. Paths in `targets_.R` may need to be adjusted to your operating system preferences. `_lanchpad.r` is a self contained scripted meant to grab relevant Rds files in `/objects` and place it in staging file for `tableau` if you have tableau installed locally on your machine you can link `tableau` to the xlsx document for greater automation capabilities; Since `launchpad.R` will overwrite existing the xlsx document with data from the index you select.

## Use
```git clone https://github.com/VtheRtech/trade-union-behavior-2020s.git```


![image](https://github.com/VtheRtech/trade-union-behavior-2020s/assets/30744769/7efc4627-36e5-4891-bc16-5e6532ac5c9c)
![image](https://github.com/VtheRtech/trade-union-behavior-2020s/assets/30744769/7efc4627-36e5-4891-bc16-5e6532ac5c9c)
