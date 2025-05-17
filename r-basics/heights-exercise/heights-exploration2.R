library(dslabs)
data(heights)

# ifelse() statement
sex_numeric <- ifelse(heights$sex == "Female", 1, 2)

# Calculate the sum
sum(sex_numeric)

# Apply condition to height column
filtered_heights <- ifelse(heights$height > 72, heights$height, 0)

# Calculate the mean
mean(filtered_heights)

# Convert inches to feet
inches_to_ft <- function(x) {
  x / 12
}

# Count number of individuals shorter than 60 inches (5 feet)
sum(heights$height < 60)
