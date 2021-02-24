#Reto 1
library(DescTools)
set.seed(134)
x <- round(rnorm(1000, 175, 6), 1)
mean(x)
median(x)
Mode(x)

quantile(x, seq(0.1,0.9, by = 0.1))
IQR(x)
sd(x)
var(x)
