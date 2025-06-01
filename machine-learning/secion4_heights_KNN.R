# Load necessary libraries
library(dslabs)
library(caret)
library(dplyr)
library(purrr)

# Load data and set seed
data("heights")
set.seed(1)

# Partition the data (50% for training)
ind <- createDataPartition(heights$sex, times = 1, p = 0.5, list = FALSE)
train_set <- heights[-ind, ]
test_set <- heights[ind, ]

ks <- seq(1, 101, 3)

# Compute F1 scores for each k
F1_scores <- sapply(ks, function(k){
  fit <- knn3(sex ~ height, data = train_set, k = k)
  y_hat <- predict(fit, test_set, type = "class") %>% 
           factor(levels = levels(train_set$sex))
  F_meas(data = y_hat, reference = test_set$sex)
})

# Output the maximum F1 score
max(F1_scores)

# Identify k with the maximum F1 score
ks[which.max(F1_scores)]
