#Postwork Sesion 6

setwd("C:/escomc/ds")
datos <- read.csv("match.data.csv")

library(dbplyr)
datos <- datos %>% mutate(sumagoles = home.score + away.score)

datos$date <- as.Date(datos$date)

promedio <- datos %>% 
  select(date, sumagoles) %>% 
  group_by(format(date, "%Y"), months.Date(date)) %>% 
  summarise(prom = mean(sumagoles))

(promedio)
colnames(promedio) <- c("Anio", "Mes", "Promedio")

install.packages("tsa")
library(forecast)
library(tsa)

goles_st<-ts(promedio, start = c(2010,8),end=c(2019,12), frequency = 12)

promedio2 <- ts(promedio$Promedio, start = c(2010, 8), end = c(2020, 3), frequency = 12)

plot(promedio2, xlab = "", ylab = "")
title(main = "Serie de Promedio de Goles en España",
      ylab = "Promedio de Goles mensuales",
      xlab = "Tiempo")
