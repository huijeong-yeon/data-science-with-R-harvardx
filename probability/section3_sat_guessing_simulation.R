# Load tidyverse
library(tidyverse)

# ----- Old SAT: 5 choices, -0.25 penalty -----

# Define constants
p_correct <- 1 / 5
p_wrong <- 1 - p_correct
score_correct <- 1
score_wrong <- -0.25
n_questions <- 44

## Expected total score
expected_per_question <- p_correct * score_correct + p_wrong * score_wrong
expected_total_score <- n_questions * expected_per_question
expected_total_score

## Standard error of total score
var_per_question <- (score_correct - expected_per_question)^2 * p_correct +
  (score_wrong - expected_per_question)^2 * p_wrong
se_total_score <- sqrt(n_questions * var_per_question)
se_total_score

## Probability of scoring ≥ 8 (using CLT)
z_score <- (8 - expected_total_score) / se_total_score
p_score_ge_8_clt <- 1 - pnorm(z_score)
p_score_ge_8_clt

## Monte Carlo simulation
set.seed(21, sample.kind = "Rounding")
B <- 10000
scores <- replicate(B, {
  guesses <- sample(c(1, 0), n_questions, replace = TRUE, prob = c(p_correct, p_wrong))
  sum(ifelse(guesses == 1, score_correct, score_wrong))
})
mean(scores >= 8)  # ≈ 0.0396

# ----- New SAT: 4 choices, no penalty -----

## Expected value for random guessing
p_correct_new <- 1 / 4
expected_new <- p_correct_new * 1 + (1 - p_correct_new) * 0
expected_new

## Lowest p such that P(score > 35) ≥ 0.8
p_vals <- seq(0.25, 0.95, 0.05)
prob_over_35 <- function(prob) {
  mu <- prob * n_questions
  se <- sqrt(n_questions * prob * (1 - prob))
  1 - pnorm(35, mean = mu, sd = se)
}
probs <- sapply(p_vals, prob_over_35)
p_vals[which(probs > 0.8)[1]]  # 0.85
