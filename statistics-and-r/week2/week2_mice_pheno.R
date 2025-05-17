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
