install.packages("dslabs")
library(dslabs)
data(movielens)

#how many rows
nrow(movielens)

#how many different variables
ncol(movielens)

#the variable type of title
class(movielens$title)

#the variable type of genres
class(movielens$genres)

#how many levels are in the factor genres
nlevels(movielens$genres)
