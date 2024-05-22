# About

This a rework of a Trade-Union-Analysis (featured on my github) on Union Density. The goal of this is to make the Trade-Union-Analysis code cleaner, cogent, and more precise.

This analysis uses `targets` to build a reproducible pipeline in R-Programming. The data is sourced from the Cornell University's Labor Action Tracker and is updated monthly. The pipeline is built in entirely in R and is reproducible by running the `targets_.R` file. Paths in `targets_.R` may need to be adjusted to your operating system preferences. `_lanchpad.r` is a self contained scripted meant to grab relevant Rds files in `/objects` and place it in staging file for `tableau` if you have tableau installed locally on your machine you can link `tableau` to the xlsx document for greater automation capabilities.
