# Load necessary libraries and set options
options(digits = 3)  # report 3 significant digits

install.packages("tidyverse")
install.packages("titanic")
library(tidyverse)
library(titanic)

# Prepare the Titanic dataset
titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(
    Survived = factor(Survived),
    Pclass = factor(Pclass),
    Sex = factor(Sex)
  )

str(titanic)

## Basic density plot of age grouped by sex with alpha blending
titanic %>%
  ggplot(aes(x = Age, fill = Sex)) +
  geom_density(alpha = 0.5) +
  labs(title = "Age Distribution by Sex", x = "Age", y = "Density")

## Faceted density plots to compare male and female distributions side-by-side
titanic %>%
  ggplot(aes(x = Age)) +
  geom_density(fill = "skyblue", alpha = 0.5) +
  facet_wrap(~Sex) +
  labs(title = "Faceted Density Plot of Age by Sex", x = "Age", y = "Density")

## Stacked density plot of age by sex
titanic %>%
  ggplot(aes(x = Age, fill = Sex)) +
  geom_density(alpha = 0.6, position = "stack") +
  labs(title = "Stacked Density Plot of Age by Sex", x = "Age", y = "Density")

## QQ-plot of Age with identity line
params <- titanic %>%
  filter(!is.na(Age)) %>%
  summarize(mean = mean(Age), sd = sd(Age))

titanic %>%
  filter(!is.na(Age)) %>%
  ggplot(aes(sample = Age)) +
  geom_qq(dparams = list(mean = params$mean, sd = params$sd)) +
  geom_abline() +
  labs(title = "QQ-Plot of Passenger Age", x = "Theoretical Quantiles", y = "Sample Quantiles")

## Bar plot of Survived filled by Sex
titanic %>%
  ggplot(aes(x = Survived, fill = Sex)) +
  geom_bar() +
  labs(title = "Survival Counts by Sex", x = "Survived", y = "Count")

## Bar plot of Survived filled by Sex with dodged bars
titanic %>%
  ggplot(aes(x = Survived, fill = Sex)) +
  geom_bar(position = position_dodge()) +
  labs(title = "Survival by Sex (Dodged)", x = "Survived", y = "Count")

## Filter out passengers with Fare == 0
titanic %>%
  filter(Fare > 0) %>%
  ggplot(aes(x = Survived, y = Fare)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.3) +
  scale_y_continuous(trans = "log2") +
  labs(title = "Fare Distribution by Survival Status (log2 scaled)",
       x = "Survived", y = "Fare (log2 scale)")

## Basic barplot: Passenger class filled by survival count
titanic %>%
  ggplot(aes(x = Pclass, fill = Survived)) +
  geom_bar() +
  labs(title = "Passenger Class by Survival (Count)",
       x = "Passenger Class", y = "Count")

## Proportional barplot: Relative survival within each passenger class
titanic %>%
  ggplot(aes(x = Pclass, fill = Survived)) +
  geom_bar(position = position_fill()) +
  labs(title = "Passenger Class by Survival (Proportion)",
       x = "Passenger Class", y = "Proportion")

## Density plots of age filled by survival status, Faceted by sex and passenger class
titanic %>%
  filter(!is.na(Age)) %>%
  ggplot(aes(x = Age, fill = Survived)) +
  geom_density(alpha = 0.5, position = "stack") +
  facet_grid(Sex ~ Pclass) +
  labs(title = "Age Distribution by Survival, Sex, and Class",
       x = "Age", y = "Count Estimate")
