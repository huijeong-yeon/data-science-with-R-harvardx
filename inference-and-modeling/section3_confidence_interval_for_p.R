# Load required packages
library(tidyverse)
library(dslabs)

# Load election poll data
data(polls_us_election_2016)

# Filter polls that ended on or after October 31, 2016 in the US
polls <- polls_us_election_2016 %>%
  filter(enddate >= "2016-10-31" & state == "U.S.")

# How many rows does `polls` contain?
nrow(polls)

# Assign the sample size of the first poll to variable N
N <- polls$samplesize[1]
N

# Estimated percentage of Clinton voters in the first poll
X_hat <- polls$rawpoll_clinton[1] / 100
X_hat

# Calculate standard error of X_hat
se_hat <- sqrt(X_hat * (1 - X_hat) / N)
se_hat

# 95% confidence interval for proportion
ci <- c(X_hat - qnorm(0.975) * se_hat,
        X_hat + qnorm(0.975) * se_hat)
ci
