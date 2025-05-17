# Week 4 Robust Summaries

## Load dataset
data(ChickWeight)

head(ChickWeight)
plot( ChickWeight$Time, ChickWeight$weight, col=ChickWeight$Diet)

## Reshape the data to wide format
chick = reshape(ChickWeight, idvar=c("Chick","Diet"), timevar="Time",
                direction="wide")

head(chick)
chick = na.omit(chick)

### Add outlier of 3000g
mean(c(chick$weight.4, 3000)) / mean(chick$weight.4)
median(c(chick$weight.4, 3000)) / median(chick$weight.4)
sd(c(chick$weight.4, 3000)) / sd(chick$weight.4)
mad(c(chick$weight.4, 3000)) / mad(chick$weight.4)

cor(c(chick$weight.4, 3000), c(chick$weight.21,3000))/cor(chick$weight.4, chick$weight.21)

### Add 200g outlier to x and perform t-test
x = chick$weight.4[chick$Diet == 1]
y = chick$weight.4[chick$Diet == 4]
t.test(c(x, 200), y)$p.value

### Perform Wilcoxon test
x = chick$weight.4[chick$Diet == 1]
y = chick$weight.4[chick$Diet == 4]
wilcox.test(c(x, 200), y, exact=FALSE)$p.value

### Difference in t-test statistic between adding 10 and adding 100 to all y
t.test(x,y + 10)$statistic - t.test(x,y + 100)$statistic
