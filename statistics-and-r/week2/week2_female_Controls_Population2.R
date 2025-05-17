# Week2 Week 2 Random Variables and Probability Distributions

## Load dataset
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleControlsPopulation.csv"
filename <- basename(url)
download(url, destfile=filename)
x <- unlist( read.csv(filename) )

### make averages5
set.seed(1)
n <- 1000
averages5 <- vector("numeric",n)
for(i in 1:n){
  X <- sample(x,5)
  averages5[i] <- mean(X)
}

### make averages50
set.seed(1)
n <- 1000
averages50 <- vector("numeric",n)
for(i in 1:n){
  X <- sample(x,50)
  averages50[i] <- mean(X)
}

mean(averages50 >= 23 & averages50 <= 25)

### Histogram for sample size 5
hist(averages5,
     main = "Sample Size = 5",
     xlab = "Sample Mean",
     col = "skyblue", breaks = 20)

### Histogram for sample size 50
hist(averages50,
     main = "Sample Size = 50",
     xlab = "Sample Mean",
     col = "lightgreen", breaks = 20)

### Using pnorm
pnorm(25, mean = 23.9, sd = 0.43) - pnorm(23, mean = 23.9, sd = 0.43)