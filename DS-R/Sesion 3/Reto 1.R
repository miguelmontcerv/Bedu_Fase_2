library(ggplot2)
altura <- read.csv("c:/Escomc/bedu_fase_2/Sesion3/BD_Altura_Alunos.csv", sep = ";")

#realizando el histograma con la función hist()
hist(altura$Altura, 
     breaks = 20,
     main = " Histograma de alturas",
     ylab = "Frecuencia",
     xlab = "Altura", 
     col = "blue")

#realizando el histograma con la función ggplot()

ggplot(altura, aes(Altura))+ 
  geom_histogram(binwidth = 4, col="black", fill = "#876539") + 
  ggtitle("Histograma de Mediciones") +
  ylab("Frecuencia") +
  xlab("Alturas") + 
  theme_get()
