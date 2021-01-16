library(dplyr)
data2 <- read.csv("c:/Escomc/bedu_fase_2/Sesion3/boxp.csv")
head(data2)
names(data2)
data <- mutate(data2, Mediciones = Mediciones*1.23)
head(data)
# Utilizando la función hist
hist(data$Mediciones)
hist(data$Mediciones, breaks = seq(0,360, 20), 
     main = "Histograma de Mediciones",
     xlab = "Mediciones",
     ylab = "Frecuencia")

# Ahora utilizando ggplot para apreciar los resultados de las dos funciones

# Evitar el Warning de filas con NA´s

str(data)
summary(data)

data <- na.omit(data) 

data %>%
  ggplot() + 
  aes(Mediciones) +
  geom_histogram(binwidth = 5)

# Agregando algunas etiquetas y tema, intenta modificar algunas de las opciones para que aprecies los resultados

data %>%
  ggplot() + 
  aes(Mediciones) +
  geom_histogram(binwidth = 10, col="#984319", fill = "#650298") + 
  ggtitle("Histograma de Mediciones") +
  ylab("Frecuencia") +
  xlab("Mediciones") + 
  theme_grey()
