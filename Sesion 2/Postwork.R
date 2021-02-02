#Postwork 2
setwd("...")
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

dir()

listaLSP <- lapply(dir(), read.csv)

listaLSP <- lapply(listaLSP, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

head(listaLSP[1]); head(listaLSP[2]); head(listaLSP[3])

#4
dataLSP <- do.call(rbind, listaLSP)

dataLSP <- mutate(dataLSP, Date = as.Date(Date, "%d/%m/%y"))
str(dataLSP)
