# Load required libraries and dataset
library(dplyr)
library(ggplot2)
library(dslabs)
ds_theme_set()
data(murders)

# Calculate proportions for each region
murders %>%
  group_by(region) %>%
  summarize(n = n()) %>%
  mutate(Proportion = n / sum(n)) %>%
  filter(region == "North Central")

# Create a bar plot showing the proportion of states by region
murders %>%
  group_by(region) %>%
  summarize(n = n()) %>%
  mutate(Proportion = n / sum(n), 
         region = reorder(region, Proportion)) %>%
  ggplot(aes(x = region, y = Proportion, fill = region)) + 
  geom_bar(stat = "identity", show.legend = FALSE) + 
  xlab("")

# Plot empirical cumulative distribution function for male heights
heights %>%
  filter(sex == "Male") %>%
  ggplot(aes(height)) + 
  stat_ecdf() +
  ylab("F(a)") + 
  xlab("a")

# Proportion of males shorter than 75 inches
heights %>%
  filter(sex == "Male") %>%
  summarize(p = mean(height < 75))

# Calculate median height of male students
heights %>%
  filter(sex == "Male") %>%
  summarize(median_height = median(height))

# Calculate and count states with murder rate > 10
sum((murders$total / murders$population) * 100000 > 10)

# Count the number of males with height between 62.5 and 65.5
heights %>%
  filter(sex == "Male", height >= 62.5, height <= 65.5) %>%
  summarize(count = n())

# Percentage of males shorter than 60
heights %>%
  filter(sex == "Male") %>%
  summarize(p = mean(height < 60))

# proportion of US states that have populations larger than 10 million?
mean(murders$population > 10^7)


