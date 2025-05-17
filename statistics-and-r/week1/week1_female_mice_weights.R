# Week1 Getting started

## Install downloader package
install.packages("downloader")
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- "femaleMiceWeights.csv" 
download(url, destfile=filename)

### Read the data
data <- read.csv("femaleMiceWeights.csv")

colnames(data)

data[12, 2]

data$Bodyweight[11]

nrow(data)

mean(data$Bodyweight[data$Diet == "hf"])

### Extract the Bodyweight for row indices 13 to 24
set.seed(1)
random_row <- sample(13:24, 1)
data$Bodyweight[random_row]
