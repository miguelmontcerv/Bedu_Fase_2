#Posrwork 3
#1
Goles_Casa <- table(datafr$FTHG)/nrow(datafr)
(Goles_Casa[1])

Goles_Visitante <- table(datafr$FTAG)/nrow(datafr)
(Goles_Visitante)

Goles_Conjunta <-  table(datafr$FTHG, datafr$FTAG)/nrow(datafr)
(Goles_Conjunta)

library(scales)
barplot(Goles_Casa)

ggplot(
  data = datafr,
  mapping = aes(
  FTHG/nrow(datafr)
  )
) + geom_bar()

