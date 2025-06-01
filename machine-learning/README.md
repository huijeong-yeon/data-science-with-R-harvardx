# 🤖 Data Science: Machine Learning – HarvardX (PH125.8x)

This repository contains code and exercises from the HarvardX course *Data Science: Machine Learning* (PH125.8x), part of the Data Science Professional Certificate.  
The course introduces supervised machine learning algorithms and evaluation methods using R.

---

## 📅 Sections

1. Introduction to Machine Learning  
2. Machine Learning Basics  
3. Smoothing and Linear Regression for Prediction
4. Cross-validation and K-nearest Neighbors
5. The Caret Package
6. Model Fitting and Recommendation Systems

---

## 📁 Files

- `section2_reported_heights_basics.R`: Uses class attendance type (inclass vs. online) to predict sex. Accuracy, sensitivity, specificity, and prevalence are calculated using `caret`.
- `section2_iris_basics.R`: Applies threshold-based binary classification using Petal.Width to distinguish virginica from versicolor. Also performs a grid search combining Petal.Length and Petal.Width to improve prediction accuracy.
- `section3_mortality_report_smoothing.R`: LOESS smoothing of daily mortality data extracted from PDF report. Uses span = 60 and degree = 1 for seasonal trend visualization.
- `section4_heights_KNN.R`: Applied k-Nearest Neighbors (KNN) to predict sex based on height using the `dslabs::heights` dataset. Evaluated F1 scores across various k values (1 to 101 by 3) and identified the optimal k using cross-validation. Demonstrates the effect of underfitting and overfitting by varying k.


> More sections and files will be added as the course progresses.

---

## 📦 Packages Used

- `dslabs`
- `dplyr`
- `lubridate`
- `caret`
- `tidyverse`
- `pdftools`
- `purrr`
- `MASS`
  
> Each `.R` script is designed to be modular and reproducible. More sections will be added as the course progresses.
