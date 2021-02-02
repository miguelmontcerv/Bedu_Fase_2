# Sesión 4. Algunas distribuciones, teorema central del límite y contraste de hipótesis: Solución de Postwork
## Data Science
### Fase 2


#### Objetivo

- Investigar la dependencia o independecia de las variables aleatorias X y Y, el número de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante.

#### Instrucciones

Ahora investigarás la dependencia o independencia del número de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante mediante un procedimiento denominado bootstrap, revisa bibliografía en internet para que tengas nociones de este desarrollo. 

1. Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.

2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior. Esto para tener una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior. Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y).


#### Desarrollo
##### Inciso 1

Utilizando el código utilizado en postworks anteriores se han determinado las probabilidades marginales y conjuntas de que el equipo local o visitante anote cierta cantidad de goles en un partido. Consulte el Readme.md del postwork 3 para una explicación más detallada.

Se importan las librerías a utilizar.
```R
library(dplyr)
library(ggplot2)
library(tidyverse)
library(rsample)
```
Se importan los datos a utilizar de los `csv` con los datos de los partidos.
```R
sp2018 <- read.csv("SP2018.csv")
sp2019 <- read.csv("SP2019.csv")
sp2020 <- read.csv("SP2020.csv")
```
Se seleccionan los datos de fechas, equipos y cantidad de goles.
```R
sp2018_1 <- select(sp2018,Date,HomeTeam,AwayTeam,FTHG, FTAG, FTR)
sp2019_1 <- select(sp2019,Date,HomeTeam,AwayTeam,FTHG, FTAG, FTR)
sp2020_1 <- select(sp2020,Date,HomeTeam,AwayTeam,FTHG, FTAG, FTR)
```
Esta selección se combina en un único data frame que contenga todos estos datos.
```R
datafr <- rbind(sp2018_1,sp2019_1,sp2020_1)
```
Se obtienen las probabilidades marginales y conjuntas.
```R
Goles_Casa <- table(datafr$FTHG)/nrow(datafr)
(Goles_Casa)

Goles_Visitante <- table(datafr$FTAG)/nrow(datafr)
(Goles_Visitante)

Goles_Conjunta <-  table(datafr$FTHG, datafr$FTAG)/nrow(datafr)
(Goles_Conjunta)
```
Por último, se guardan las probabilidades marginales en las matrices `A` y `B` (estas se multiplican y el producto de ambas se guarda en la matriz `AB`), y la probabilidad conjunta en la matriz `C`, para poder realizar la operación de dividir la matriz `C` entre el producto de las probabilidades marginales `AB`. El resultado se guarda en la matriz `cocientes`.
```R
A <- matrix(Goles_Casa)
B <- matrix(Goles_Visitante) 
AB <- A %*% t(B)
C <-matrix(Goles_Conjunta, 9, 7)
cocientes <- C/AB
(cocientes)
```

##### Inciso 2
Proceso de bootstrapping:
Con la función `sample` se extraen de manera aleatoria las filas del data frame que contiene los datos de los tres años `datafr`.
```R
set.seed(01012021)
muestreo <- sample(nrow(datafr), size = 1140, replace = TRUE)
muestreo_1 <- datafr[muestreo, ]
```
Se vuelven a realizar los pasos descritos en el inciso 1 para volver a obtener la matriz de cocientes, pero en esta ocasión con los datos del remuestreo.
```R
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
```

Con esta información se puede determinar cuáles cocientes se pueden suponer como iguales a 1.

#### Conclusión

Los cocientes que se pueden suponer como iguales a 1 son aquellos que mediante el remuestreo de bootstrap, nos daban un valor muy cercando a uno, en promedio una de las tablas que obteniamos era la siguiente: 

         [,1]      [,2]      [,3]      [,4]      [,5]      [,6]     [,7]
 [1,] 0.9638380 0.9634551 0.8755537 1.8949182 0.7994186 1.5047880 0.000000
 [2,] 0.9931411 1.0300752 1.0726034 0.8270677 0.9046053 0.5108359 0.000000
 [3,] 0.9653270 1.0870611 1.0251323 0.5291005 1.0416667 0.8714597 2.469136
 [4,] 0.8857115 0.9436435 1.1263106 0.9611184 1.2614679 2.3745278 3.363914
 [5,] 1.4085894 0.8465608 0.7275132 0.0000000 2.5462963 0.0000000 0.000000
 [6,] 2.1128842 0.3174603 0.5456349 0.0000000 1.9097222 0.0000000 0.000000
 [7,] 2.0896657 0.0000000 0.0000000 4.9886621 0.0000000 0.0000000 0.000000
 [8,] 0.0000000 2.8571429 0.0000000 0.0000000 0.0000000 0.0000000 0.000000
 [9,] 0.0000000 0.0000000 4.9107143 0.0000000 0.0000000 0.0000000 0.000000
 
 Donde las folas hacen referencia a los goles de local, y las columnas a los goles de visitante. NO se puede obtener un promedio de todas las tablas porque al hacer el remuestreo mediante bootstrap, no siempre ibamos a obtener el mismo máximo de goles, por lo que las tablas eran de dimensiones diferentes, pero si pudimos observar un patron en los cocientes de las probabilidades conjuntas de $$\mathbb{P}$$

Si se desea se puede consultar/ descargar el archivo de R de este ejercicio, se encuentra en este mismo repositorio, con el nombre `Sesion04_Postwork.R`.

Alumnos 
* Sofía Cristina Suárez Campos
* David Garduño Guzmán
* Andrea Noemi Aguilar Hidalgo
* Miguel Angel Monteros Cervantes
