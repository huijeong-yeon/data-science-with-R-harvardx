# Week1 Introduction to Exploratory Data Analysis

## Load built-in dataset
head(InsectSprays)

### Boxplot using split()
boxplot(split(InsectSprays$count, InsectSprays$spray),
        main = "Boxplot using split()", xlab = "Spray",
        ylab = "Insect Count")

### Boxplot using formula
boxplot(count ~ spray, data = InsectSprays,
        main = "Boxplot using formula", xlab = "Spray",
        ylab = "Insect Count")

### Identify most effective spray (lowest median)
tapply(InsectSprays$count, InsectSprays$spray, median)

### Boxplot to visually check outliers
boxplot(count ~ spray, data = InsectSprays,
        main = "Insect Counts by Spray (Outliers)",
        ylab = "Count", xlab = "Spray")

