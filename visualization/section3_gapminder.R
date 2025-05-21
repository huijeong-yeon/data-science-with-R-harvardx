# Load required libraries and dataset
library(dplyr)
library(ggplot2)
library(dslabs)

data(gapminder)

## Filter for Africa in 2012
gapminder_africa_2012 <- gapminder %>%
  filter(continent == "Africa", year == 2012)

## Create scatter plot: fertility vs life expectancy
gapminder_africa_2012 %>%
  ggplot(aes(x = fertility, y = life_expectancy)) +
  geom_point()

## Use color to distinguish the different regions of Africa
gapminder %>%
  filter(continent == "Africa", year == 2012) %>%
  ggplot(aes(x = fertility, y = life_expectancy, color = region)) +
  geom_point()

## Filter African countries in 2012 with fertility <= 3 and life expectancy >= 70
df <- gapminder %>%
  filter(continent == "Africa", year == 2012,
         fertility <= 3, life_expectancy >= 70) %>%
  select(country, region)

## Filter data for Vietnam and the United States between 1960 and 2010
tab <- gapminder %>%
  filter(year >= 1960, year <= 2010,
         country %in% c("Vietnam", "United States"))

## Create a time series plot
p <- tab %>%
  ggplot(aes(x = year, y = life_expectancy, color = country)) +
  geom_line()
p

## Create a time series plot from 1960 to 2010 of life expectancy vs year for Cambodia
gapminder %>%
  filter(country == "Cambodia", year >= 1960, year <= 2010) %>%
  ggplot(aes(x = year, y = life_expectancy)) +
  geom_line()

## Create dollars_per_day for African countries in 2010 and remove NA values
daydollars <- gapminder %>%
  filter(continent == "Africa", year == 2010) %>%
  mutate(dollars_per_day = gdp / population / 365) %>%
  filter(!is.na(dollars_per_day))

## Create a smooth density plot of dollars_per_day with log base 2 x-axis
daydollars %>%
  ggplot(aes(x = dollars_per_day)) +
  geom_density() +
  scale_x_continuous(trans = "log2")

## Create dollars_per_day for African countries in 1970 and 2010, remove NA
gapminder %>%
  filter(continent == "Africa", year %in% c(1970, 2010)) %>%
  mutate(dollars_per_day = gdp / population / 365) %>%
  filter(!is.na(dollars_per_day)) %>%
  ggplot(aes(x = dollars_per_day)) +
  geom_density() +
  scale_x_continuous(trans = "log2") +
  facet_grid(. ~ year)

## Create a stacked smooth density plot of dollars_per_day by region in 1970 and 2010
gapminder %>%
  filter(continent == "Africa", year %in% c(1970, 2010)) %>%
  mutate(dollars_per_day = gdp / population / 365) %>%
  filter(!is.na(dollars_per_day)) %>%
  ggplot(aes(x = dollars_per_day, fill = region)) +
  geom_density(bw = 0.5, position = "stack") +
  scale_x_continuous(trans = "log2") +
  facet_grid(. ~ year)

## Create a dataset with dollars_per_day and no NA values for 2010 African countries
gapminder_Africa_2010 <- gapminder %>%
  filter(continent == "Africa", year == 2010) %>%
  mutate(dollars_per_day = gdp / population / 365) %>%
  filter(!is.na(dollars_per_day), !is.na(infant_mortality))

## Create a scatter plot of infant_mortality vs dollars_per_day with region color
gapminder_Africa_2010 %>%
  ggplot(aes(x = dollars_per_day, y = infant_mortality, color = region)) +
  geom_point()

## Scatter plot of infant_mortality vs dollars_per_day with log2 x-axis
gapminder_Africa_2010 %>%
  ggplot(aes(x = dollars_per_day, y = infant_mortality, color = region)) +
  geom_point() +
  scale_x_continuous(trans = "log2")

## Scatter plot of infant_mortality vs dollars_per_day with country names as labels
gapminder_Africa_2010 %>%
  ggplot(aes(x = dollars_per_day, y = infant_mortality, color = region, label = country)) +
  geom_text() +
  scale_x_continuous(trans = "log2")

## # Prepare and plot infant_mortality vs dollars_per_day for Africa in 1970 and 2010
gapminder %>%
  filter(continent == "Africa", year %in% c(1970, 2010)) %>%
  mutate(dollars_per_day = gdp / population / 365) %>%
  filter(!is.na(dollars_per_day), !is.na(infant_mortality)) %>%
  ggplot(aes(x = dollars_per_day, y = infant_mortality, color = region, label = country)) +
  geom_point() +
  geom_text(vjust = -0.5) +
  scale_x_continuous(trans = "log2") +
  facet_grid(year ~ .)
