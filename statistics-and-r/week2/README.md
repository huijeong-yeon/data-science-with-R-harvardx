# 📘 Week 2 – Statistics and R (HarvardX PH525.1x)

This folder contains R scripts from Week 2 of the HarvardX course *Statistics and R*, focused on sampling distributions, population statistics, and simulation.

## ✅ Topics Covered

- Downloading and preparing data from online sources
- Working with numeric vectors
- Setting and managing random number generator settings with `RNGkind()` and `set.seed()`
- Calculating sample means and population means
- Using `for` loops for repeated sampling
- Measuring sampling variability and estimating proportions

## 📁 Files

- `week2_female_Controls_Population.R`: Simulates repeated sampling from a population of female control weights to evaluate sampling error and variability using absolute differences from the population mean.
- `week2_gapminder_1952.R`: Analysis of life expectancy distribution across countries in 1952 using the gapminder dataset, including histogram and proportion of countries with life expectancy ≤ 40.
- `week2_female_Controls_Population2.R`: Comparison of sampling distributions with different sample sizes (n = 5 vs n = 50), and estimation of coverage probability using a normal approximation.
- `week2_mice_pheno.R`: Analysis of male mice on the chow diet, including sample mean distribution, population statistics, and standard deviation using the `popsd()` function.

## 📦 Packages Used

- Base R
- `gapminder`
- `dplyr`
- `rafalib
- `downloader`
