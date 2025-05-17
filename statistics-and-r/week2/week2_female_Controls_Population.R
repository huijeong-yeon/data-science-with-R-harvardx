# Week2 Week 2 Random Variables and Probability Distributions

## Download the file
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleControlsPopulation.csv"
filename <- basename(url)
download(url, destfile=filename)
x <- unlist( read.csv(filename) )

## RNG settings
RNGkind("Mersenne-Twister", "Inversion", "Rejection")

###the average of weights
mean(x)
