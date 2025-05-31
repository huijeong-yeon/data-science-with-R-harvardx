library(tidyverse)
library(HistData)
library(broom)

# Set seed for reproducibility
set.seed(1, sample.kind = "Rounding")

# Preprocess GaltonFamilies data
galton <- GaltonFamilies %>%
  group_by(family, gender) %>%
  sample_n(1) %>%
  ungroup() %>%
  gather(parent, parentHeight, father:mother) %>%
  mutate(child = ifelse(gender == "female", "daughter", "son")) %>%
  unite(pair, c("parent", "child"))

# Count observations for each parent-child pair
pair_counts <- galton %>%
  group_by(pair) %>%
  summarize(n = n())

print(pair_counts)

# Calculate correlation coefficients
correlations <- galton %>%
  group_by(pair) %>%
  summarize(cor = cor(parentHeight, childHeight))

print(correlations)

# Fit linear models and extract tidy summaries
regression_results <- galton %>%
  group_by(pair) %>%
  do(tidy(lm(childHeight ~ parentHeight, data = .), conf.int = TRUE))

print(regression_results)

# Extract estimate for father-daughter
fd_coef <- regression_results %>%
  filter(pair == "father_daughter", term == "parentHeight") %>%
  pull(estimate)