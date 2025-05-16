library(dslabs)
data(heights)
options(digits = 3)

#how many above average height
avg_height <- mean(heights$height)
ind <- heights$height > avg_height
sum(ind)

#how many above average height&female
sum(heights$height > avg_height & heights$sex == "Female")

#proportion of female
n_total <- nrow(heights)
n_female <- sum(heights$sex == "Female")
n_female / n_total

#the sex of the individual with the minimum height
min_height <- min(heights$height)
i <- which(heights$height == min_height)
heights$sex[i]

#the minimum height
min(heights$height)

#the index of the first individual with the minimum height
i2 <- match(min_height, heights$height)
i2

#the maximum height
max(heights$height)

#How many of the integers in x are NOT heights
x <- 50:82
sum(!(x %in% heights$height))

#a new column of heights in centimeters named ht_cm
library(dplyr)
heights2 <- mutate(heights, ht_cm = height*2.54)

#the height in centimeters of the 18th individual
heights2$ht_cm[18]

#the mean height in centimeters
mean(heights2$ht_cm)

#only female individuals
females <- filter(heights2, sex == "Female")

#How many females
nrow(females)

#the mean height of the females
mean(females$ht_cm)