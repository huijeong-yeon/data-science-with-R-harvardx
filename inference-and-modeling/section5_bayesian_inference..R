# Load the libraries and data
library(dplyr)
library(dslabs)
data(polls_us_election_2016)

# Filter Florida polls ending on or after 2016-11-04 and compute spread
polls <- polls_us_election_2016 %>% 
  filter(state == "Florida" & enddate >= "2016-11-04") %>% 
  mutate(spread = rawpoll_clinton / 100 - rawpoll_trump / 100)

# Compute average spread and standard error
results <- polls %>%
  summarize(
    avg = mean(spread),
    se = sd(spread) / sqrt(n())
  )

# Define prior parameters
mu <- 0
sigma <- results$se
Y <- results$avg
tau <- 0.01

# Calculate shrinkage factor B
B <- sigma^2 / (sigma^2 + tau^2)

# Calculate posterior expected value
exp_value <- B * mu + (1 - B) * Y

# Calculate posterior standard error
se <- sqrt(1 / (1 / sigma^2 + 1 / tau^2))

# Compute 95% credible interval
ci <- c(exp_value - qnorm(0.975) * se,
        exp_value + qnorm(0.975) * se)

# Compute probability that spread < 0 (Trump wins)
prob_trump_win <- pnorm(0, mean = exp_value, sd = se)

# Explore effect of different tau values
taus <- seq(0.005, 0.05, len = 100)

# Function to compute posterior Trump win probability by tau
p_calc <- function(tau) {
  B <- sigma^2 / (sigma^2 + tau^2)
  post_mean <- B * mu + (1 - B) * Y
  post_se <- sqrt(1 / (1 / sigma^2 + 1 / tau^2))
  pnorm(0, mean = post_mean, sd = post_se)
}

# Apply the function across taus
ps <- sapply(taus, p_calc)

# Plot posterior probability of Trump win vs tau
plot(taus, ps, type = "l", lwd = 2, col = "blue",
     xlab = expression(tau), ylab = "Pr(Trump wins)",
     main = "Posterior Probability of Trump Winning vs Prior Uncertainty")
