#Week1 Getting started

## Install dplyr package
install.packages("dplyr")
library(dplyr)

## use a new dataset
library(downloader)
url="https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
filename <- basename(url)
download(url,filename)

### Read the CSV file
msleep <- read.csv("msleep_ggplot2.csv")

class(msleep)

### Filter only primates
primates <- filter(msleep, order == "Primates")
nrow(primates)
class(primates)

### Filter for primates and select sleep_total column
primates_sleep <- msleep %>%
  filter(order == "Primates") %>%
  select(sleep_total)
class(primates_sleep)

### Convert to vector and calculate mean
mean(unlist(primates_sleep))

### Filter for primates and summarize the average sleep
msleep %>%
  filter(order == "Primates") %>%
  summarize(avg_sleep = mean(sleep_total, na.rm = TRUE))
