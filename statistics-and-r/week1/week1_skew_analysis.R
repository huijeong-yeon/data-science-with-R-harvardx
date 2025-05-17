#Week1 Introduction to Exploratory Data Analysis

## Load file
load("skew.RData")

### Check dimensions
dim(dat)

### Set 3x3 plotting layout
par(mfrow = c(3, 3))

### Generate QQ plots for each column
for (i in 1:9) {
  qqnorm(dat[, i], main = paste("Column", i))
  qqline(dat[, i], col = "red")
}

### Reset plotting layout
par(mfrow = c(1, 1))

### Examine skewed columns
hist(dat[, 3], main = "Histogram of Column 3")  # Positive skew
hist(dat[, 7], main = "Histogram of Column 7")  # Negative skew
