# Sesion 2. Manipulación de datos en R: Solución de Postwork
## Data Science
### Fase 2


**Objetivo**: 
* Importar múltiples archivos csv a R
* Observar algunas características y manipular los data frames
* Combinar múltiples data frames en un único data frame

### Instrucciones
1. Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española a `R`, los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php
2. Obten una mejor idea de las características de los data frames al usar las funciones: `str`, `head`, `View` y `summary`
3. Con la función `select` del paquete `dplyr` selecciona únicamente las columnas `Date`, `HomeTeam`, `AwayTeam`, `FTHG`, `FTAG` y `FTR`; esto para cada uno de los data frames. (Hint: también puedes usar `lapply`).
4. Asegúrate de que los elementos de las columnas correspondientes de los nuevos data frames sean del mismo tipo (Hint 1: usa `as.Date` y `mutate` para arreglar las fechas). Con ayuda de la función `rbind` forma un único data frame que contenga las seis columnas mencionadas en el punto 3 (Hint 2: la función `do.call` podría ser utilizada).

### Desarrollo
1. Primero se importaron los datos de la temporada a RStudio. Para esto se seleccionó el directorio de trabajo y posteriormente se importaron los datos usando `read.csv`. Estos se guardaron como data frames.

`setwd("c:/Escomc/bedu_fase_2/Sesion 2")`

`sp2018 <- read.csv("SP2018.csv")`

`p2019 <- read.csv("SP2019.csv")`

`sp2020 <- read.csv("SP2020.csv")`


2. Con el objetivo de conocer mejor las características de los data frames recién creados, se utilizaron las funciones `str`, `head`, `View` y `summary`. `str` muestra la estructura (información del tipo de objeto, las dimensiones (si es un data frame), el nombre de las variables, los diez primeros elementos de las variables numéricas y los niveles o categorías de las variables categóricas), `head` la primera fila, `View`muestra los datos del data frame y `summary` muestra un resumen general sobre las variables del data frame.

`str(sp2018)`
`head(sp2018)`
`View(sp2018)`
`summary(sp2018)`

`str(sp2019)`
`head(sp2019)`
`View(sp2019)`
`summary(sp2019)`

`str(sp2020)`
`head(sp2020)`
`View(sp2020)`
`summary(sp2020)`

3. Utilizando la función `lapply`y `select`, se extrajeron las columnas `Date`, `HomeTeam`, `AwayTeam`, `FTHG`, `FTAG` y `FTR` de cada uno de los dataframes anteriores y se guardaron. Para esto se usó la librería `dplyr`.

`library(dplyr)`

`dir()`

`listaLSP <- lapply(dir(), read.csv)`

`listaLSP <- lapply(listaLSP, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)`

`head(listaLSP[1]); head(listaLSP[2]); head(listaLSP[3])`

4. Por último, se guardaron los datos selecciónados anteriormente en un solo data frame y se comprobó que todos los datos fueran del mismo tipo. Sólo hubo un detalle con el formato de la fecha, el cual se estandarizó para que todos tuvieran el mismo.

`dataLSP <- do.call(rbind, listaLSP)`

`dataLSP <- mutate(dataLSP, Date = as.Date(Date, "%d/%m/%y"))`

`str(dataLSP)`

Si se desea se puede consultar/ descargar el archivo de R de este ejercicio, se encuentra en este mismo repositorio, con el nombre `Postwork.R`.

Alumnos 
* Sofía Cristina Suárez Campos
* David Garduño Guzmán
* Andrea Noemi Aguilar Hidalgo
* Miguel Angel Monteros Cervantes
