# Set seed for reproducibility
set.seed(16, sample.kind = "Rounding")

# Simulate 10,000 ACT scores from normal distribution
act_scores <- rnorm(10000, mean = 20.9, sd = 5.7)

# Mean
mean(act_scores)

# Standard deviation
sd(act_scores) 

# Count of perfect scores (score ≥ 36)
sum(act_scores >= 36)

# Proportion of scores greater than 30
mean(act_scores > 30)

# Proportion of scores less than or equal to 10
mean(act_scores <= 10)

# Probability that a standard normal variable exceeds 2
1 - pnorm(2)

# ACT score that is 2 standard deviations above the mean
mean(act_scores) + 2 * sd(act_scores)

# 97.5th percentile using qnorm
qnorm(0.975, mean = mean(act_scores), sd = sd(act_scores))

# Define the empirical CDF function using act_scores
cdf <- function(x) {
  mean(act_scores <= x)
}

# Apply CDF to integer values from 1 to 36
cdf_values <- sapply(1:36, cdf)

# Find the minimum integer x such that CDF(x) ≥ 0.95
min(which(cdf_values >= 0.95))

# 95th percentile from normal distribution
qnorm(0.95, mean = 20.9, sd = 5.7)

# Compute sample quantiles
p <- seq(0.01, 0.99, 0.01)
sample_quantiles <- quantile(act_scores, p)

# Find the highest percentile where quantile value ≤ 26
which(sample_quantiles <= 26) %>% max()
