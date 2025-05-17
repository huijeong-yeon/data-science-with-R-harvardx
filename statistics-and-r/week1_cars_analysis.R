#Week1 Getting started

## Check the type of the cars dataset
class(cars)

## Count the number of rows in the cars dataset
nrow(cars)

## Get the column names
colnames(cars)[2]

## Calculate the average of the second column (dist)
mean(cars$dist)

## Find the row where dist is 85
which(cars$dist == 85)

