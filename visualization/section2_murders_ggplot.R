# Load required libraries and dataset
library(dplyr)
library(ggplot2)
library(dslabs)

data(murders)

p <- ggplot(data = murders)         # Full version
p <- ggplot(murders)               # Data is first argument, can omit 'data ='
p <- murders %>% ggplot()          # Using the pipe operator from dplyr

class(p)
str(murders)
head(murders)

## Create a scatter plot
murders %>%
  ggplot(aes(x = population, y = total)) +
  geom_point()

## Flip the axes
murders %>%
  ggplot(aes(total, population)) +
  geom_point()

## State abbreviations are used as labels
murders %>%
  ggplot(aes(x = total, y = population, label = abb)) +
  geom_label()

## Make the labels blue
murders %>%
  ggplot(aes(population, total, label = abb)) +
  geom_label(color = "blue")

## Make the label color correspond to the state's region
murders %>%
  ggplot(aes(x = population, y = total, label = abb, color = region)) +
  geom_label()

## Change both axes to be in the log scale on a single graph
p <- murders %>%
  ggplot(aes(population, total, label = abb, color = region)) +
  geom_label()
p + scale_x_log10() + scale_y_log10()

## Add the title "Gun murder data" to the plot
p + scale_x_log10() + scale_y_log10() + ggtitle("Gun murder data")
