# Week2 Central Limit Theorem

## Load dataset
library(downloader)
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- "femaleMiceWeights.csv"
if(!file.exists("femaleMiceWeights.csv")) download(url,destfile=filename)
dat <- read.csv(filename)

X <- filter(dat, Diet == "chow") %>% select(Bodyweight) %>% unlist
Y <- filter(dat, Diet == "hf") %>% select(Bodyweight) %>% unlist

### Calculate sample average for chow diet
mean(X)

### Estimate the population standard deviation
library(rafalib)
popsd(X)
sd(X) #Estimation!!

### Calculate probability that the sample mean is off by more than 2 grams
sigma_X <- sd(X)
n <- 12
SE <- sigma_X / sqrt(n)
probability <- 2 * (1 - pnorm(2, mean = 0, sd = SE))

probability

### Calculate the standard error (SE) of the difference in sample means
sqrt( var(X)/12 + var(Y)/12)

### Calculate the t-statistic for the difference in means
( mean(Y) - mean(X) ) / sqrt( var(X)/12 + var(Y)/12)

### Calculate p-value
Z <- ( mean(Y) - mean(X) ) / sqrt( var(X)/12 + var(Y)/12)
2*( 1-pnorm(Z)) 

### p-value under t-distribution approximation
t.test(X,Y)$p.value
