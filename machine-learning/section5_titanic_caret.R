library(titanic)    # loads titanic_train data frame
library(caret)
library(tidyverse)
library(rpart)

str(titanic_train)

# 3 significant digits
options(digits = 3)

# clean the data - `titanic_train` is loaded with the titanic package
titanic_clean <- titanic_train %>%
  mutate(Survived = factor(Survived),
         Embarked = factor(Embarked),
         Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age), # NA age to median age
         FamilySize = SibSp + Parch + 1) %>%    # count family members
  select(Survived,  Sex, Pclass, Age, Fare, SibSp, Parch, FamilySize, Embarked)

# Partition the data: 20% testing
set.seed(42) 
test_index <- createDataPartition(titanic_clean$Survived, times = 1, p = 0.2, list = FALSE) # create a 20% test set
test_set <- titanic_clean[test_index,]
train_set <- titanic_clean[-test_index,]

nrow(train_set)
nrow(test_set)

mean(train_set$Survived == 1)

# Guess with equal probability of survival
set.seed(3)

guess <- sample(c(0,1), nrow(test_set), replace = TRUE)
mean(guess == test_set$Survived)

# Predict survival by sex
train_set %>%
  group_by(Sex) %>%
  summarize(proportion_survived = mean(Survived == 1))

sex_model <- ifelse(test_set$Sex == "female", 1, 0)    # predict Survived=1 if female, 0 if male
mean(sex_model == test_set$Survived)    # calculate accuracy

# Predict survival by passenger class
train_set %>%
  group_by(Pclass) %>%
  summarize(Survived = mean(Survived == 1))

class_model <- ifelse(test_set$Pclass == 1, 1, 0)    # predict survival only if first class
mean(class_model == test_set$Survived)    # calculate accuracy

train_set %>%
  group_by(Sex, Pclass) %>%
  summarize(Survived = mean(Survived == 1)) %>%
  filter(Survived > 0.5)

sex_class_model <- ifelse(test_set$Sex == "female" & test_set$Pclass != 3, 1, 0)
mean(sex_class_model == test_set$Survived)

# Confusion matrix
confusionMatrix(data = factor(sex_model), reference = factor(test_set$Survived))
confusionMatrix(data = factor(class_model), reference = factor(test_set$Survived))
confusionMatrix(data = factor(sex_class_model), reference = factor(test_set$Survived))

# F-measure
F_meas(data = factor(sex_model), reference = test_set$Survived)
F_meas(data = factor(class_model), reference = test_set$Survived)
F_meas(data = factor(sex_class_model), reference = test_set$Survived)

# Survival by fare - Loess
install.packages("gam")
library(gam)

set.seed(1)
model_loess <- train(Survived ~ Fare,
                     method = "gamLoess",
                     data = train_set)

loess_pred <- predict(model_loess, test_set)
mean(loess_pred == test_set$Survived)

# Logistic regression models
set.seed(1)
model_age <- train(Survived ~ Age, method = "glm", data = train_set)
pred_age <- predict(model_age, test_set)
mean(pred_age == test_set$Survived)

set.seed(1)
model_4 <- train(Survived ~ Sex + Pclass + Fare + Age, method = "glm", data = train_set)
pred_4 <- predict(model_4, test_set)
mean(pred_4 == test_set$Survived)

set.seed(1)
model_all <- train(Survived ~ ., method = "glm", data = train_set)
pred_all <- predict(model_all, test_set)
mean(pred_all == test_set$Survived)

# kNN model
set.seed(6)
grid <- data.frame(k = seq(3, 51, 2))
fit_knn <- train(Survived ~ ., 
                 method = "knn",
                 tuneGrid = grid,
                 data = train_set)
fit_knn$bestTune$k

ggplot(fit_knn)

knn_preds <- predict(fit_knn, newdata = test_set)
mean(knn_preds == test_set$Survived)   # Accuracy

# Crossvalidation
set.seed(8)

fit_knn_cv <- train(Survived ~ ., 
                    method = "knn",
                    data = train_set,
                    tuneGrid = data.frame(k = seq(3, 5, 2)),
                    trControl = trainControl(method = "cv", number = 10, p = 0.9))

fit_knn_cv$bestTune$k

knn_preds_cv <- predict(fit_knn_cv, newdata = test_set)
mean(knn_preds_cv == test_set$Survived)    # Accuracy

# Classification tree model
set.seed(10)

fit_rpart <- train(Survived ~ .,
                   method = "rpart",
                   data = train_set,
                   tuneGrid = data.frame(cp = seq(0, 0.05, 0.002)))

fit_rpart$bestTune$cp
                                     
pred_rpart <- predict(fit_rpart, newdata = test_set)
mean(pred_rpart == test_set$Survived)    # Accuracy
