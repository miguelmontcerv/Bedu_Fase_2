
setwd("C:/ESCOMc/InteligenciaArtificial/Bedu_DS/Fase 2/Sesion 1")

read.csv("SP1.csv")

ligaEspa <- read.csv("SP1.csv")

tabLig <- data.frame(golCasa <- ligaEspa$FTHG, golVisit <- ligaEspa$FTAG)

table(ligaEspa$FTHG, ligaEspa$FTAG)

with(ligaEspa, table(FTHG, FTAG))

prob <- with(ligaEspa, table(FTHG, FTAG))

prop.table(prob)

#PAQUETES QUE INSTALE

install.packages("devtools")
library(devtools)
install_github("angeloSdP/ULPGCmisc")
install.packages("ULPGCmisc")
library(ULPGCmisc)

prop.table(prob,1)
prop.table(prob,2)

with(ligaEspa, freqTable(ligaEspa$FTHG))
with(ligaEspa, freqTable(ligaEspa$FTAG))

with(ligaEspa, freqTable(FTHG, by = FTAG))
with(ligaEspa, freqTable(FTAG, by = FTHG))

max(ligaEspa$FTHG)
min(ligaEspa$FTHG)
max(ligaEspa$FTAG)
min(ligaEspa$FTAG)

prop.table(table(ligaEspa$FTHG))

summary(ligaEspa$FTHG)
summary(ligaEspa$FTAG)
sum(ligaEspa$FTHG)
sum(ligaEspa$FTAG)
table(ligaEspa$FTHG)
head(ligaEspa)
dim(ligaEspa)
