setwd("D:/BEDU/PROGRAMACIÓN Y ESTADÍSTICA CON R/SESIÓN 5/POSTWORK/")

# 1

ligaEsp1718 <- read.csv("LIGA ESPAÑOLA 2017-2018.csv")
ligaEsp1819 <- read.csv("LIGA ESPAÑOLA 2018-2019.csv")
ligaEsp1920 <- read.csv("LIGA ESPAÑOLA 2019-2020.csv")

library(dplyr)

dir()

listaSP <- lapply(dir(), read.csv)

listaSP <- lapply(listaSP,select, Date, HomeTeam, FTHG, AwayTeam ,FTAG)

SmallData <- do.call(rbind, listaSP)

SmallData <- mutate(SmallData, Date = as.Date(Date, "%d/%m/%y"))

SmallData <- rename(SmallData, date = Date, home.team = HomeTeam, 
               home.score = FTHG, away.team = AwayTeam, 
               away.score = FTAG)

write.csv(SmallData, "D:/BEDU/PROGRAMACIÓN Y ESTADÍSTICA CON R/SESIÓN 5/PW/soccer.csv", 
          row.names = FALSE)

setwd("D:/BEDU/PROGRAMACIÓN Y ESTADÍSTICA CON R/SESIÓN 5/PW/")

listasoccer <- create.fbRanks.dataframes(
  scores.file = "soccer.csv")

anotaciones <- listasoccer$scores
equipos <- listasoccer$teams

head(listasoccer$scores)
head(listasoccer$teams)

fecha <- unique(SmallData$date)
fecha <- as.Date(fecha, "%d/%m/%Y")
fecha <- sort(fecha)
n <- length(fecha)

ranking <- rank.teams(anotaciones, teams = equipos, 
                      max.date = fecha[n-1], min.date = fecha[1], 
                      date.format = "%d/%m/%Y")

predict(ranking, date = fecha[n])

SmallData[SmallData$date == fecha[n],]
