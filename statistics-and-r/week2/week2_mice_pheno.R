# Week2 Central Limit Theorem

## Load dataset
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/mice_pheno.csv"
filename <- basename(url)
download(url, destfile=filename)
dat <- read.csv(filename) 

## Read and clean the data
dat <- read.csv(filename)
dat <- na.omit(dat) 

### Filter for male mice on chow diet and extract body weight
library(dplyr)
x <- dat %>%
  filter(Sex == "M", Diet == "chow") %>%
  pull(Bodyweight)

mean(x)


### Compute population standard deviation
install.packages("rafalib")
library(rafalib)
popsd(x)

### Calculate sample average of x
set.seed(1)
sample_25 <- sample(x, 25)
mean(sample_25)

### Filter for male mice on high fat diet and extract body weight
y <- dat %>%
  filter(Sex == "M", Diet == "hf") %>%
  pull(Bodyweight)
mean(y)
popsd(y)

### Calculate sample average of y
set.seed(1)
sample_25_y <- sample(y, 25)
mean(sample_25_y)

### Proportion of the mice are within one standard deviation away from the average weight
y <- dat %>%
  filter(Sex == "M", Diet == "chow") %>%
  pull(Bodyweight)

mu <- mean(y)
s <- sd(y)

mean(y > (mu - s) & y < (mu + s)) #0.68

### QQ-plot
qqnorm(y)
abline(0, 1)

### Sample mean distribution of size 25
y <- filter(dat, Sex == "M" & Diet == "chow") %>%
  select(Bodyweight) %>%
  unlist()

set.seed(1)
avgs <- replicate(10000, mean(sample(y, 25)))

### QQ-plot of sample averages
mypar(1, 2)
hist(avgs)
qqnorm(avgs)
qqline(avgs)

### The average of the sample averages
mean(avgs)

### The standard deviation of the sample averages
popsd(avgs)
