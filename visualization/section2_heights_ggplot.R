# Load required libraries and dataset
library(dplyr)
library(dslabs)
library(ggplot2)

data(heights)

## Create a ggplot object using the pipe
p <- heights %>%
  ggplot(aes(x = height))

## Make the histogram
p + geom_histogram()

## Change the histogram to use bins of size 1 inch.
p + geom_histogram(binwidth = 1)

## Create a smooth density plot of heights
heights %>% 
  ggplot(aes(height)) +
  geom_density()

## Create separate smooth density plots for males and females
heights %>%
  ggplot(aes(x = height, group = sex)) +
  geom_density()

## Add color
heights %>%
  ggplot(aes(x = height, group = sex, color = sex)) +
  geom_density()

## Set the alpha parameter to 0.2
heights %>% 
  ggplot(aes(x = height, fill = sex)) + 
  geom_density(alpha = 0.2)
