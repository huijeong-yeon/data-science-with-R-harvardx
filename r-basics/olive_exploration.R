library(dslabs)
data(olive)
head(olive)
str(olive)


#scatterplot
plot(olive$palmitic, olive$palmitoleic,
     xlab = "Palmitic Acid (%)",
     ylab = "Palmitoleic Acid (%)",
     main = "Palmitic vs. Palmitoleic Acid")

#histogram
hist(olive$eicosenoic,
     xlab = "Eicosenoic Acid (%)",
     main = "Histogram of Eicosenoic Acid",
     col = "lightblue")

#boxplot
boxplot(palmitic ~ region, data = olive,
        xlab = "Region",
        ylab = "Palmitic Acid (%)",
        main = "Palmitic Acid by Region",
        col = "lightgreen")
