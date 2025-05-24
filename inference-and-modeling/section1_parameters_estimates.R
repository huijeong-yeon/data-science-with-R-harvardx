# Sample size
N <- 25

# Let p be the proportion of Democrats in the population

# Expected value of the number of Democrats in the sample
expected_S <- expression(25 * p)

# Standard error (SD) of the number of Democrats
se_S <- expression(sqrt(25 * p * (1 - p)))

# Expected value of the sample proportion
expected_Xbar <- expression(p)

# Standard error of the sample proportion
se_Xbar <- expression(sqrt(p * (1 - p) / 25))

# Expected value of difference in proportions
expected_diff <- expression(2 * p - 1)

# Standard error of difference in proportions
se_diff <- expression(2 * sqrt(p * (1 - p) / 25))
