library(tidyverse)
library(dslabs)

# Load data
data(polls_us_election_2016)

# Filter national polls ending on or after 2016-10-31
polls <- polls_us_election_2016 %>%
  filter(enddate >= "2016-10-31" & state == "U.S.") %>%
  mutate(d_hat = (rawpoll_clinton - rawpoll_trump) / 100)

# Sample size and d_hat of first poll
N <- polls$samplesize[1]
d_hat <- polls$d_hat[1]

# Convert d_hat to X_hat and calculate standard error
# d_hat = p_clinton - p_trump, and p_clinton + p_trump = 1

X_hat <- (d_hat + 1) / 2
se_hat <- 2 * sqrt(X_hat * (1 - X_hat) / N)

# 95% confidence interval
ci <- c(d_hat - qnorm(0.975) * se_hat,
        d_hat + qnorm(0.975) * se_hat)

# Create pollster-level results with CI
pollster_results <- polls %>%
  mutate(
    X_hat = (d_hat + 1) / 2,
    se_hat = 2 * sqrt(X_hat * (1 - X_hat) / samplesize),
    lower = d_hat - qnorm(0.975) * se_hat,
    upper = d_hat + qnorm(0.975) * se_hat
  ) %>%
  select(pollster, enddate, d_hat, lower, upper)

# Compute 'hit' column for whether CI includes actual spread
actual_spread <- 0.021
pollster_results <- pollster_results %>%
  mutate(hit = lower <= actual_spread & upper >= actual_spread)

# Proportion of polls with CI covering the actual result
avg_hit <- mean(pollster_results$hit)
avg_hit

# Boxplot of error by pollster (all pollsters)
polls <- polls %>%
  mutate(error = d_hat - actual_spread)

polls %>%
  ggplot(aes(x = pollster, y = error)) +
  geom_boxplot() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  coord_flip() +
  labs(title = "Polling Error by Pollster (Clinton - Trump)",
       y = "Error (d_hat - actual)", x = "Pollster")

# Boxplot of error by pollster (only those with 5+ polls)
poll_counts <- polls %>%
  count(pollster) %>%
  filter(n >= 5)

polls_filtered <- polls %>%
  filter(pollster %in% poll_counts$pollster)

polls_filtered %>%
  ggplot(aes(x = pollster, y = error)) +
  geom_boxplot() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  coord_flip() +
  labs(title = "Polling Error by Pollster (5+ Polls)",
       y = "Error (d_hat - actual)", x = "Pollster")
