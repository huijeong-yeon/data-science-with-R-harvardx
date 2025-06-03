library(dslabs)

# Part 1: Monte Carlo Simulation

set.seed(1)

B <- 10000
n <- 100

montecarlo_q75 <- replicate(B, {
  y <- rnorm(n, 0, 1)
  quantile(y, 0.75)
})

mean(montecarlo_q75)
sd(montecarlo_q75)

# Part 2: Bootstrap Estimation

set.seed(1)
y <- rnorm(n, 0, 1)  # fixed sample

set.seed(1)
bootstrap_q75 <- replicate(B, {
  sample_y <- sample(y, replace = TRUE)
  quantile(sample_y, 0.75)
})

mean(bootstrap_q75)
sd(bootstrap_q75)