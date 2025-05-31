# 📈 Data Science: Linear Regression – HarvardX (PH125.7x)

This repository contains code and exercises from the HarvardX course *Data Science: Linear Regression* (PH125.7x), part of the Data Science Professional Certificate. The course explores how linear models can be applied to real-world scenarios, particularly using baseball statistics.

---

## 📅 Sections

1. **Introduction to Regression**  
2. **Linear Models**  
3. **Confounding**

---

## 📁 Files

- `section1_baseball_intro.R`: Visual exploration of baseball team statistics between 1961 and 2001 using scatterplots. Includes analyses of runs vs at-bats, win rate vs errors, and triples vs doubles.
- `section1_baseball_correlation.R`: Computes correlation coefficients between runs and at-bats, win rate and errors, and doubles and triples using per-game statistics.
- `section1_Galton_Families_stratification_variance.R`: Uses the GaltonFamilies dataset to investigate the regression relationship between mothers' and daughters' heights and interprets the proportion of variance explained (R²).
- `section2_Galton_Families_LSE.R`: Fits a linear regression model to predict mothers’ heights using daughters’ heights. Includes slope, intercept, and prediction comparison using the `lm()` and `predict()` functions.
- section2_batting_LSE.R: Creates scatterplots and fits linear models comparing 2002 singles and BB rates with 1999–2001 averages. Used to assess year-to-year stability of batting metrics using the Lahman dataset.


> More sections and files will be added as the course progresses.

---

## 📦 Packages Used

- `Lahman`
- `dplyr`
- `ggplot2`
- `HistData`

> Each `.R` script is designed to be modular and reproducible. More sections will be added as the course progresses.
