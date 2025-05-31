# Load required packages and data
set.seed(1989, sample.kind = "Rounding")
library(HistData)
library(dplyr)
data("GaltonFamilies")

# Create female_heights data frame with one female child per family
female_heights <- GaltonFamilies %>%
  filter(gender == "female") %>%
  group_by(family) %>%
  sample_n(1) %>%
  ungroup() %>%
  select(mother, childHeight) %>%
  rename(daughter = childHeight)

head(female_heights)

# Mean and standard deviation
mean_mother <- mean(female_heights$mother)
sd_mother <- sd(female_heights$mother)

mean_daughter <- mean(female_heights$daughter)
sd_daughter <- sd(female_heights$daughter)

# Correlation coefficient
r <- cor(female_heights$mother, female_heights$daughter)

# Regression slope and intercept (daughter ~ mother)
beta <- r * sd_daughter / sd_mother
alpha <- mean_daughter - beta * mean_mother

# Expected change in daughter's height per 1 inch increase in mother's height
expected_change <- beta

# Proportion of variance explained (R-squared)
r_squared <- r^2 * 100

# Predict daughter's height given mother = 60 inches
mother_height <- 60
predicted_daughter <- alpha + beta * mother_height
