# Week 4 Exploratory Data Analysis

## Load dataset
install.packages("UsingR")
library(UsingR)
data(nym.2002, package="UsingR")

head(nym.2002)

### Calculate Pearson correlation for males between age and time
library(dplyr)
males <- nym.2002 %>% filter(gender == "Male")
females <- nym.2002 %>% filter(gender == "Female")
cor(males$age, males$time) #method = "pearson"

### Calculate Pearson correlation for females between age and time
cor(females$age, females$time) 

# Create age groups in 5-year bins
nym.2002 <- nym.2002 %>%
  mutate(age_group = cut(age, breaks = seq(20, 80, 5), right = FALSE))

# Scatterplot of time by age
plot(nym.2002$age, nym.2002$time,
     main = "Marathon Time vs Age",
     xlab = "Age",
     ylab = "Time to Finish (minutes)",
     pch = 20, col = "steelblue")

# Boxplot of time by age group
boxplot(time ~ age_group, data = nym.2002,
        main = "Finish Time by Age Group",
        xlab = "Age Group",
        ylab = "Time to Finish (minutes)",
        las = 2, col = "lightgray")

# Create a vector of sorted marathon finish times
time <- sort(nym.2002$time)

# Calculate ratio of the fastest time to the median time
min(time) / median(time)

# Calculate ratio of the slowest time to the median time
max(time) / median(time)
