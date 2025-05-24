# Load required package
library(tidyverse)

# Simulate the 'errors' vector

set.seed(1)
p <- 0.45
N <- 1000
B <- 10000

X_hat <- replicate(B, mean(sample(c(0, 1), N, replace = TRUE, prob = c(1 - p, p))))
errors <- X_hat - p

# Plot histogram of errors
hist(errors, main = "Histogram of Errors (X̄ - p)", xlab = "Error", col = "skyblue", border = "white")

# Determine required sample size to achieve SE ≈ 0.01
p <- 0.5
N_values <- seq(100, 5000, length.out = 100)
SE_values <- sqrt(p * (1 - p) / N_values)

# Plot SE vs N
plot(N_values, SE_values, type = "l", col = "darkred", lwd = 2,
     main = "Standard Error vs Sample Size",
     xlab = "Sample Size N", ylab = "Standard Error")

# Find minimum N such that SE <= 0.01
min_N <- N_values[which(SE_values <= 0.01)[1]]
min_N 