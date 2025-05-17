# Week2 Week 2 Random Variables and Probability Distributions

## Install new package
install.packages("gapminder")
library(gapminder)

## Load dataset
data(gapminder)
head(gapminder)

### Extract life expectancies in 1952
x <- gapminder$lifeExp[gapminder$year == 1952]

### Plot histogram
hist(x,
     main = "Histogram of Life Expectancy in 1952",
     xlab = "Life Expectancy (years)",
     col = "lightblue", breaks = 20)

### Proportion of countries with life expectancy <= 40
mean(x <= 40)
