# Load required packages
library(tidyverse)
library(dslabs)

# Load polling data
data(polls_us_election_2016)

# Filter national polls that ended on or after 2016-10-31
polls <- polls_us_election_2016 %>%
  filter(enddate >= "2016-10-31" & state == "U.S.")

# Number of polls
nrow(polls)

# First poll's sample size
N <- polls$samplesize[1]
N

# First poll's Clinton proportion
X_hat <- polls$rawpoll_clinton[1] / 100
X_hat

# Standard error for first poll
se_hat <- sqrt(X_hat * (1 - X_hat) / N)
se_hat

# 95% confidence interval for first poll
ci <- c(X_hat - qnorm(0.975) * se_hat,
        X_hat + qnorm(0.975) * se_hat)
ci

# Construct results for all polls
pollster_results <- polls %>%
  mutate(X_hat = rawpoll_clinton / 100,
         se_hat = sqrt(X_hat * (1 - X_hat) / samplesize),
         lower = X_hat - qnorm(0.975) * se_hat,
         upper = X_hat + qnorm(0.975) * se_hat) %>%
  select(pollster, enddate, X_hat, se_hat, lower, upper)

# Check structure
head(pollster_results)

# Actual Clinton proportion in popular vote
p_actual <- 0.482

# Add 'hit' column to check if CI includes true value
pollster_results <- pollster_results %>%
  mutate(hit = lower <= p_actual & upper >= p_actual)

# Calculate average hit rate
avg_hit <- mean(pollster_results$hit)
avg_hit
