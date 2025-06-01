install.packages("caret")

library(dslabs)
library(dplyr)
library(lubridate)
library(caret)

data(reported_heights)

# Filter data for the week of Jan 25-31, 2016
dat <- mutate(reported_heights, date_time = ymd_hms(time_stamp)) %>%
  filter(date_time >= make_date(2016, 01, 25) & date_time < make_date(2016, 02, 1)) %>%
  mutate(type = ifelse(day(date_time) == 25 & hour(date_time) == 8 & between(minute(date_time), 15, 30), "inclass","online")) %>%
  select(sex, type)

y <- factor(dat$sex, c("Female", "Male"))
x <- dat$type

# Proportion pf females in each group
dat %>%
  group_by(type) %>%
  summarize(prop_female = mean(sex == "Female"))

# Predict sex based on majority class
y_hat <- ifelse(x == "inclass", "Female", "Male")
mean(y_hat == y)

# Confusion matrix
table(y_hat, y)

# Sensitivity and specificity
y_hat_f <- factor(y_hat, levels = c("Female", "Male"))
sensitivity(y_hat_f, y)
specificity(y_hat_f, y)

# Prevalence
mean(y == "Female")
