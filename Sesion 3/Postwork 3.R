#Posrwork 3
#1
Goles_Casa <- table(datafr$FTHG)/nrow(datafr)
(Goles_Casa)

#2
Goles_Visitante <- table(datafr$FTAG)/nrow(datafr)
(Goles_Visitante)

Goles_Conjunta <-  table(datafr$FTHG, datafr$FTAG)/nrow(datafr)
(Goles_Conjunta)

#3
library(scales)
barplot(Goles_Casa)

probas_casa <- data.frame(cbind(goles = 0:8 , proba = Goles_Casa$Freq))

probas_casa

ggplot(
  data = probas_casa,
  mapping = aes(
    x = goles,
    y = proba,
    fill = factor(goles)
  ) 
) + geom_bar(stat = "identity")+
  labs(y = "Probabilidad", 
       x = "Número de Goles",
       title ="Goles Locales")

#4
Goles_Visitante <- data.frame(Goles_Visitante)
probas_visit <- data.frame(cbind(goles = 0:7 , proba = Goles_Visitante$Freq))
ggplot(
  data = probas_visit,
  mapping = aes(
    x = goles,
    y = proba,
    fill = factor(goles)
  ) 
) + geom_bar(stat = "identity")+
  labs(y = "Probabilidad", 
       x = "Número de Goles",
       title ="Goles Visitantes")

#5
Goles_conj <- data.frame(Goles_Conjunta)
colnames(Goles_conj) <- c("Local", "Visitante", "Proba")

ggplot(Goles_conj, 
       aes(
         x = Local, 
         y = Visitante, 
         fill = Proba)
) + geom_tile()
