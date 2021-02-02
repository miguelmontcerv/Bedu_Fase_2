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
```R
       [,1]   [,2]   [,3]   [,4]   [,5]   [,6]  [,7]
 [1,] 0.9638 0.9634 0.8755 1.8949 0.7994 1.5047 0.000
 [2,] 0.9931 1.0300 1.0726 0.8270 0.9046 0.5108 0.000
 [3,] 0.9653 1.0870 1.0251 0.5291 1.0416 0.8714 2.469
 [4,] 0.8857 0.9436 1.1263 0.9611 1.2614 2.3745 3.363
 [5,] 1.4085 0.8465 0.7275 0.0000 2.5462 0.0000 0.000
 [6,] 2.1128 0.3174 0.5459 0.0000 1.9097 0.0000 0.000
 [7,] 2.0896 0.0000 0.0000 4.9886 0.0000 0.0000 0.000
 [8,] 0.0000 2.8571 0.0000 0.0000 0.0000 0.0000 0.000
 [9,] 0.0000 0.0000 4.9107 0.0000 0.0000 0.0000 0.000
```
 
 Donde las filas hacen referencia a los goles de local, y las columnas a los goles de visitante. No se puede obtener un promedio de todas las tablas porque al hacer el remuestreo mediante bootstrap, no siempre ibamos a obtener el mismo máximo de goles, por lo que las tablas eran de dimensiones diferentes, pero si pudimos observar un patron de independencia en los cocientes de las probabilidades conjuntas de P(X=x, Y=y) para los pares (x, y), donde x<4 & y<3. Casos aislados como el (1, 3) y el (1, 4) tambien presentaban patron, todos manteniendo el cocientes entre 0.9 y 1.1 en todos los remuestreos, por lo que para estos casos consideramos que sería correcto suponer independencia.

Si se desea se puede consultar/ descargar el archivo de R de este ejercicio, se encuentra en este mismo repositorio, con el nombre `Postwork.R`.

Alumnos 
* Sofía Cristina Suárez Campos
* David Garduño Guzmán
* Andrea Noemi Aguilar Hidalgo
* Miguel Angel Monteros Cervantes
