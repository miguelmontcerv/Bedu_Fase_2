# Inciso 1 ----

library(dplyr)
library(ggplot2)
library(tidyverse)
library(rsample)

sp2018 <- read.csv("D:/Sofi/Documentos/data_science/r-files/sesion-4/SP2018.csv")
sp2019 <- read.csv("D:/Sofi/Documentos/data_science/r-files/sesion-4/SP2019.csv")
sp2020 <- read.csv("D:/Sofi/Documentos/data_science/r-files/sesion-4/SP2020.csv")

sp2018_1 <- select(sp2018,Date,HomeTeam,AwayTeam,FTHG, FTAG, FTR)
sp2019_1 <- select(sp2019,Date,HomeTeam,AwayTeam,FTHG, FTAG, FTR)
sp2020_1 <- select(sp2020,Date,HomeTeam,AwayTeam,FTHG, FTAG, FTR)

datafr <- rbind(sp2018_1,sp2019_1,sp2020_1)

Goles_Casa <- table(datafr$FTHG)/nrow(datafr)
(Goles_Casa)

Goles_Visitante <- table(datafr$FTAG)/nrow(datafr)
(Goles_Visitante)

Goles_Conjunta <-  table(datafr$FTHG, datafr$FTAG)/nrow(datafr)
(Goles_Conjunta)

A <- matrix(Goles_Casa)
B <- matrix(Goles_Visitante)
AB <- A %*% t(B)
C <-matrix(Goles_Conjunta, 9, 7)
cocientes <- C/AB
(cocientes)

# Inciso 2 ----

set.seed(01012021)
muestreo <- sample(nrow(datafr), size = 1140, replace = TRUE)
muestreo_1 <- datafr[muestreo, ]

Goles_Casa_1 <- table(muestreo_1$FTHG)/nrow(datafr)
(Goles_Casa_1)

Goles_Visitante_1 <- table(muestreo_1$FTAG)/nrow(datafr)
(Goles_Visitante_1)

Goles_Conjunta_1 <-  table(muestreo_1$FTHG, muestreo_1$FTAG)/nrow(datafr)
(Goles_Conjunta_1)

A1 <- matrix(Goles_Casa_1)
B1 <- matrix(Goles_Visitante_1)
AB1 <- A1 %*% t(B1)
C1 <-matrix(Goles_Conjunta_1, 9, 7)
cocientes_bootstrap <- C1/AB1
(cocientes_bootstrap)
