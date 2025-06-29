# Week 1 – Statistics and R (HarvardX PH525.1x)

This folder contains practice scripts from Week 1 of the HarvardX course *Statistics and R*, taught by Prof. Rafael Irizarry.

## Topics Covered

- Inspecting base R datasets (e.g., `cars`)
- Using `class()`, `nrow()`, `colnames()` for dataset exploration
- Subsetting data with `[ , ]` and `$`
- Filtering data with `filter()`
- Selecting columns with `select()`
- Calculating means with `mean()`, `unlist()`, and `summarize()`
- Using `%>%` (pipe operator) to chain operations
- Filtering and summarizing by condition (e.g., primates’ sleep data)
- Random sampling with `sample()` and `set.seed()`

## Files

- `week1_cars_analysis.R`: Exploratory analysis of the `cars` dataset using base R
- `week1_female_mice_weights.R`: Analysis of the `femaleMiceWeights.csv` dataset including diet filtering and sampling
- `week1_msleep_ggplot2.R`: Analysis of animal sleep data using `msleep_ggplot2.csv`, with filtering and summarization
- `week1_skew_analysis.R`: QQ-plot and histogram-based assessment of skewed distributions using `skew.RData
- `week1_insect_sprays.R`: Comparative boxplot analysis using `InsectSprays` dataset, including identification of most effective spray and visual outliers

## Packages Used

- Base R
- `dplyr`
- `downloader`
