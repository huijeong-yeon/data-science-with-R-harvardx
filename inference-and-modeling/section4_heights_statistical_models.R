# Load the 'dslabs' package and the heights dataset
library(dslabs)
data(heights)

# Make a vector of male heights
x <- heights %>% filter(sex == "Male") %>% .$height

# Calculate the population mean
mu <- mean(x)
mu

# Calculate the population standard deviation
sigma <- sd(x)
sigma

# Set seed for reproducibility
set.seed(1)

# Define sample size
N <- 50

# Draw sample of size N from population x
X <- sample(x, N, replace = TRUE)

# Calculate sample average
X_bar <- mean(X)
X_bar

# Calculate sample standard deviation
s_X <- sd(X)
s_X

# Calculate standard error of the estimate
se <- s_X / sqrt(N)
se

# Construct 95% confidence interval for population mean
ci <- c(X_bar - qnorm(0.975) * se,
        X_bar + qnorm(0.975) * se)
ci

# Define the population mean
mu <- mean(x)

# Set seed for reproducibility
set.seed(1)

# Sample size
N <- 50

# Number of simulations
B <- 10000

# Simulate B confidence intervals and record whether they contain mu
res <- replicate(B, {
  X <- sample(x, N, replace = TRUE)
  X_bar <- mean(X)
  s_X <- sd(X)
  se <- s_X / sqrt(N)
  ci <- c(X_bar - qnorm(0.975) * se,
          X_bar + qnorm(0.975) * se)
  mu >= ci[1] & mu <= ci[2]
})

# Calculate the proportion of intervals that include the true mean
mean(res)
