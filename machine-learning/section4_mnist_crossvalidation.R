library(dslabs)
library(caret)

data(mnist_27)
str(data)

set.seed(1995)

# Generate bootstrap sample indices using caret::createResample
indexes <- createResample(mnist_27$train$y, times = 10)

# Count how many times indices 3, 4, and 7 appear in the first bootstrap sample
table(indexes[[1]])[c("3", "4", "7")]

# Count how many times "3" appears in all resampled sets
sum(sapply(indexes, function(ind) sum(ind == 3)))
