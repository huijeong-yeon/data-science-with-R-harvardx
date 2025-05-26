# Load required libraries and data
library(dslabs)
library(dplyr)
data(heights)

# Use the sample code to generate `x`, a vector of male heights
x <- heights %>% filter(sex == "Male") %>% .$height

# True population mean
mu <- mean(x)

# Sampling parameters
N <- 15
B <- 10000
set.seed(1)

# Simulation using normal distribution
res_normal <- replicate(B, {
  sample_x <- sample(x, N, replace = TRUE)
  x_bar <- mean(sample_x)
  s <- sd(sample_x)
  se <- s / sqrt(N)
  ci_lower <- x_bar - qnorm(0.975) * se
  ci_upper <- x_bar + qnorm(0.975) * se
  mu >= ci_lower & mu <= ci_upper
})

# Proportion of normal CIs that contain the true mean
mean(res_normal)

# Simulation using t-distribution
res_t <- replicate(B, {
  sample_x <- sample(x, N, replace = TRUE)
  x_bar <- mean(sample_x)
  s <- sd(sample_x)
  se <- s / sqrt(N)
  t_critical <- qt(0.975, df = N - 1)
  ci_lower <- x_bar - t_critical * se
  ci_upper <- x_bar + t_critical * se
  mu >= ci_lower & mu <= ci_upper
})

# Proportion of t-distribution CIs that contain the true mean
mean(res_t)
