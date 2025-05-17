# Week 3 Inferences

## Load dataset
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/babies.txt"
filename <- basename(url)
download(url, destfile=filename)
babies <- read.table("babies.txt", header=TRUE)

bwt.nonsmoke <- filter(babies, smoke==0) %>% select(bwt) %>% unlist 
bwt.smoke <- filter(babies, smoke==1) %>% select(bwt) %>% unlist

library(rafalib)
mean(bwt.nonsmoke)-mean(bwt.smoke)
popsd(bwt.nonsmoke)
popsd(bwt.smoke)

### Find t value for 99% confidence interval
N <- 25
set.seed(1)
dat.ns <- sample(bwt.nonsmoke, N) 
dat.s <- sample(bwt.smoke, N) 
qt(0.995,48)*sqrt( sd( dat.ns)^2/N + sd( dat.s)^2/N )

### Perform two-sample t-test and return p-value
set.seed(1)
N <- 5
dat.ns <- sample(bwt.nonsmoke, N)
dat.s  <- sample(bwt.smoke, N)

t.test(dat.ns, dat.s)$p.value

### Estimate power (proportion of rejections)
set.seed(1)
N <- 5
rejects <- replicate(10000, {
  sample_ns <- sample(bwt.nonsmoke, N)
  sample_s  <- sample(bwt.smoke, N)
  pval <- t.test(sample_ns, sample_s)$p.value
  pval < 0.05
})
mean(rejects)

### Compute power for each N
compute_power <- function(N, B=10000) {
  rejections <- replicate(10000, {
    sample_ns <- sample(bwt.nonsmoke, N)
    sample_s  <- sample(bwt.smoke, N)
    pval <- t.test(sample_ns, sample_s)$p.value
    pval < 0.05
  })
  mean(rejections)
}
sample_sizes <- c(30, 60, 90, 120)

powers <- sapply(sample_sizes, compute_power)
names(powers) <- sample_sizes
powers

### Calculate two-sided permutation p-value
N <- 10
set.seed(1)
nonsmokers <- sample(bwt.nonsmoke, N)
smokers    <- sample(bwt.smoke, N)

obs <- mean(smokers) - mean(nonsmokers)
dat <- c(smokers, nonsmokers)

null_dist <- replicate(1000, {
  shuffled <- sample(dat)
  group1 <- shuffled[1:N]
  group2 <- shuffled[(N+1):(2*N)]
  mean(group1) - mean(group2)
})

p_value <- mean(abs(null_dist) >= abs(obs))
p_value

### Permutation test: median difference
obs2 <- median(smokers) - median(nonsmokers)
dat2 <- c(smokers, nonsmokers)

set.seed(1)
null_dist2 <- replicate(1000, {
  shuffled <- sample(dat)
  group1 <- shuffled[1:N]
  group2 <- shuffled[(N+1):(2*N)]
  median(group1) - median(group2)
})
p_value2 <- mean(abs(null_dist2) >= abs(obs2))
p_value2
