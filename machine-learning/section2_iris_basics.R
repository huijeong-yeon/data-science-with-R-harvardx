library(caret)

data(iris)
iris <- iris[-which(iris$Species == "setosa"), ]
y <- iris$Species

plot(iris, pch=21, bg=iris$Species)

# Train/test split
set.seed(76)
test_index <- createDataPartition(y, times = 1, p = 0.5, list = FALSE)
train <- iris[-test_index, ]
test <- iris[test_index, ]

# Function to find best cutoff per feature

foo <- function(x){
  rangedValues <- seq(range(x)[1], range(x)[2], by=0.1)
  sapply(rangedValues, function(i){
    y_hat <- ifelse(x>i, 'virginica', 'versicolor')
    mean(y_hat==train$Species)
  })
}
predictions <- apply(train[,-5], 2, foo)
sapply(predictions, max)


# Use best feature and apply best cutoff to test set
predictions <- foo(train[, 4])  # Petal.Width
rangedValues <- seq(range(train[, 4])[1], range(train[, 4])[2], by = 0.1)
cutoffs <- rangedValues[which(predictions == max(predictions))]

y_hat <- ifelse(test[, 4] > cutoffs[1], 'virginica', 'versicolor')
mean(y_hat == test$Species)


# Combine Petal.Length and Petal.Width with grid search

petalLengthRange <- seq(range(train$Petal.Length)[1], range(train$Petal.Length)[2],by=0.1)
petalWidthRange <- seq(range(train$Petal.Width)[1], range(train$Petal.Width)[2],by=0.1)

length_predictions <- sapply(petalLengthRange, function(i){
  y_hat <- ifelse(train$Petal.Length>i, 'virginica', 'versicolor')
  mean(y_hat==train$Species)
})
length_cutoff <- petalLengthRange[which.max(length_predictions)] # 4.6

width_predictions <- sapply(petalWidthRange, function(i){
  y_hat <- ifelse(train$Petal.Width>i, 'virginica', 'versicolor')
  mean(y_hat==train$Species)
})
width_cutoff <- petalWidthRange[which.max(width_predictions)] # 1.5

y_hat <- ifelse(test$Petal.Length>length_cutoff & test$Petal.Width>width_cutoff, 'virginica', 'versicolor')
mean(y_hat==test$Species)
