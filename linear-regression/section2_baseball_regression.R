library(Lahman)
library(dplyr)
library(broom)
library(ggplot2)

# Fit multivariate linear model for 1971
model_1971 <- Teams %>%
  filter(yearID == 1971) %>%
  lm(R ~ BB + HR, data = .) %>%
  tidy()
print(model_1971)

# Fit multivariate linear model for each year from 1961 to 2018
bb_hr_effects <- Teams %>%
  filter(yearID >= 1961 & yearID <= 2018) %>%
  group_by(yearID) %>%
  do(tidy(lm(R ~ BB + HR, data = .))) %>%
  ungroup()

# Extract BB effect and visualize over time
bb_effects <- bb_hr_effects %>%
  filter(term == "BB")

ggplot(bb_effects, aes(x = yearID, y = estimate)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Effect of BB on Runs Over Time", x = "Year", y = "Estimate for BB")

# Linear model for trend in BB effect
trend_model <- lm(estimate ~ yearID, data = bb_effects)
summary(trend_model)
