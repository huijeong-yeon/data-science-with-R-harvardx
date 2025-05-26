# 📊 Data Science: Inference and Modeling – HarvardX (PH125.4x)

This folder contains code and assessments from the HarvardX course *Data Science: Inference and Modeling* (PH125.4x), covering statistical inference, hypothesis testing, Bayesian reasoning, and predictive modeling such as election forecasting.

## 📅 Sections

1. Parameters and Estimates  
2. Central Limit Theorem in Practice  
3. Confidence Intervals and p-Values  
4. Statistical Models  
5. Bayesian Statistics  
6. Election Forecasting  
7. Association Tests  
8. Final Assessment – Brexit

## 📦 Packages Used

- `tidyverse`
- `dslabs`
- `rafalib`
- `dplyr`
- `ggplot2`

## 📁 Files

- `section1_parameters_estimates.R`: Analytical derivation of expected values and standard errors for binomial sampling. Covers sample totals, proportions, and differences in estimated proportions between groups.
- `section2_central_limit_theorem.R`: Simulation-based exploration of the Central Limit Theorem. Includes histogram of sampling errors and analysis of how sample size affects standard error using visualizations and threshold detection.
- `section3_confidence_interval_for_p.R`: Confidence interval estimation for the proportion of Clinton voters based on 2016 U.S. election polling data. Includes data filtering, proportion calculation, standard error derivation, CI coverage evaluation, and hit rate summary.
- `section3_confidence_interval_for_d.R`: Computes the confidence interval for the difference in support (spread) between Clinton and Trump based on 2016 U.S. national election polls. Includes transformation from spread to proportion, standard error calculation, CI construction, hit rate evaluation, and pollster-wise error visualization (boxplots for all pollsters and those with ≥5 polls).
- `section4_heights_statistical_models.R`: Statistical modeling with male height data from the `heights` dataset. Includes population parameter estimation, sampling-based confidence interval construction, and Monte Carlo simulation to estimate interval coverage probabilities.
- `section4_polling_bias_visualization.R`: Visual and statistical comparison of polling spread (Clinton - Trump) across selected pollsters. Includes boxplots of spread values, pollster-wise standard deviations, difference-in-means estimation, p-value calculation, and filtering for pollsters with 5+ polls.
- `section5_bayesian_inference.R`: Bayesian inference using polling data from Florida in the 2016 U.S. election. Includes posterior estimation of the spread between Clinton and Trump using a prior with varying uncertainty, calculation of posterior means and standard errors, 95% credible intervals, and probability Trump leads. Also visualizes the impact of prior uncertainty (tau) on the posterior probability.
- `section6_heights_t-distribution.R`: Comparison of confidence intervals using the normal distribution versus the t-distribution on small samples of male heights. Simulates 10,000 confidence intervals to estimate empirical coverage rates for each method.
