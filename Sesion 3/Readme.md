# Sesion 03. Análisis Exploratorio de Datos (AED o EDA) con R
## Data Science
### Fase 2


#### Objetivo

Lograr un mejor conocimiento o entendimiento del problema con el cual se relacionan los datos, de una manera relativamente fácil y rápida, sin utilizar modelos o teoría matemática avanzada

## Postwork

#### Instrucciones

Ahora graficaremos probabilidades (estimadas) marginales y conjuntas para el número de goles que anotan en un partido el equipo de casa o el equipo visitante.

1. Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:

- La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)

- La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)

- La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)

2. Realiza lo siguiente:

- Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa
- Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
- Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.


#### Desarrollo
##### Inciso 1

Encontramos la probabilidad tanto marginal de los visitantes así como de los locales de que se anoten n cantidad de goles
```R
Goles_Casa <- table(datafr$FTHG)/nrow(datafr)
(Goles_Casa)

Goles_Visitante <- table(datafr$FTAG)/nrow(datafr)
(Goles_Visitante)

Goles_Conjunta <-  table(datafr$FTHG, datafr$FTAG)/nrow(datafr)
(Goles_Conjunta)
```
Realizamos un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa
```R
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
```
Realizamos un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.

```R
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
```
Por ultimo realizamos un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.
```R
Goles_conj <- data.frame(Goles_Conjunta)
colnames(Goles_conj) <- c("Local", "Visitante", "Proba")

ggplot(Goles_conj, 
       aes(
         x = Local, 
         y = Visitante, 
         fill = Proba)
) + geom_tile()
```

#### Conclusión

Si se desea se puede consultar/ descargar el archivo de R de este ejercicio, se encuentra en este mismo repositorio, con el nombre `Postwork.R`.

Alumnos 
* Sofía Cristina Suárez Campos
* David Garduño Guzmán
* Andrea Noemi Aguilar Hidalgo
* Miguel Angel Monteros Cervantes
