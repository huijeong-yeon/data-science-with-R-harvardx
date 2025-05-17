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
