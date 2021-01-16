#Postwork 2
#1
setwd("c:/Escomc/bedu_fase_2/Sesion 2")
sp2018 <- read.csv("SP2018.csv")
sp2019 <- read.csv("SP2019.csv")
sp2020 <- read.csv("SP2020.csv")
#2
str(sp2018)
head(sp2018)
View(sp2018)
summary(sp2018)

str(sp2019)
head(sp2019)
View(sp2019)
summary(sp2019)

str(sp2020)
head(sp2020)
View(sp2020)
summary(sp2020)

#3
library(dplyr)

sp2018_1 <- select(sp2018,Date,HomeTeam,AwayTeam,FTHG, FTAG, FTR)
sp2019_1 <- select(sp2019,Date,HomeTeam,AwayTeam,FTHG, FTAG, FTR)
sp2020_1 <- select(sp2020,Date,HomeTeam,AwayTeam,FTHG, FTAG, FTR)

#4
datafr <- rbind(sp2018_1,sp2019_1,sp2020_1)

datafr <- mutate(datafr, Date = as.Date(Date, "%d/%m/%y"))
str(datafr)
