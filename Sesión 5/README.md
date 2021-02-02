## Contenido
1. [Desarrollo](#desarrollo)
2. [Resultados](#resultados)

## DESARROLLO

1. A partir del conjunto de datos de soccer de la liga española de las temporadas 2017/2018, 2018/2019 y 2019/2020, crea el data frame SmallData, que contenga las columnas date, home.team, home.score, away.team y away.score; esto lo puede hacer con ayuda de la función select del paquete dplyr. Luego establece un directorio de trabajo y con ayuda de la función write.csv guarda el data frame como un archivo csv con nombre soccer.csv. Puedes colocar como argumento row.names = FALSE en write.csv.

2. Con la función create.fbRanks.dataframes del paquete fbRanks importe el archivo soccer.csv a R y al mismo tiempo asignelo a una variable llamada listasoccer. Se creará una lista con los elementos scores y teams que son data frames listos para la función rank.teams. Asigna estos data frames a variables llamadas anotaciones y equipos.

3. Con ayuda de la función unique crea un vector de fechas (fecha) que no se repitan y que correspondan a las fechas en las que se jugaron partidos. Crea una variable llamada n que contenga el número de fechas diferentes. Posteriormente, con la función rank.teams y usando como argumentos los data frames anotaciones y equipos, crea un ranking de equipos usando unicamente datos desde la fecha inicial y hasta la penúltima fecha en la que se jugaron partidos, estas fechas las deberá especificar en max.date y min.date. Guarda los resultados con el nombre ranking.

4. Finalmente estima las probabilidades de los eventos, el equipo de casa gana, el equipo visitante gana o el resultado es un empate para los partidos que se jugaron en la última fecha del vector de fechas fecha. Esto lo puedes hacer con ayuda de la función predict y usando como argumentos ranking y fecha[n] que deberá especificar en date.

## Resultados

Primero, establecemos el directorio de trabajo que deberá contener los achivos de las temporadas 2017/2018, 2018/2019, 2019/2020.
```R
setwd("D:/BEDU/PROGRAMACIÓN Y ESTADÍSTICA CON R/SESIÓN 5/POSTWORK/") # La dirección depende de cada uno
```
Cargamos la libreria de `dplyr`
```R
library(dplyr)
```

Revisamos que la dirección contenga los archivos que necesitamos.
```R
dir()
```

Con la función `lapply` creamos una lista que contenga los 3 archivos.
```R
listaSP <- lapply(dir(), read.csv)
```
Después con la función `select` sólo seleccionamos las columnas que queremos.
```R
listaSP <- lapply(listaSP,select, Date, HomeTeam, FTHG, AwayTeam ,FTAG)
```
Combinamos la lista y lo convertimos en un dataframe utilizando las funciones `rbind`y `do.call`.
```R
SmallData <- do.call(rbind, listaSP)
```
Con la función `mutate` tranformamos la columna correspondiente a fecha.
```R
SmallData <- mutate(SmallData, Date = as.Date(Date, "%d/%m/%y"))
```
Y con la función `rename`vamos a renombrar las columnas: `Date, HomeTeam, FTHG, AwayTeam, FTAG`.
```R
SmallData <- rename(SmallData, date = Date, home.team = HomeTeam, 
               home.score = FTHG, away.team = AwayTeam, 
               away.score = FTAG)
```
Con la función `write.csv` guardamos el dataframe con el nombre `soccer.csv`.
```R
write.csv(SmallData, "D:/BEDU/PROGRAMACIÓN Y ESTADÍSTICA CON R/SESIÓN 5/PW/soccer.csv", 
          row.names = FALSE)
```
Cargando la libreria `fbRanks`usamos la función `create.fbRanks.dataframes` de ese mismo paquete,
aignándolo a la variable `listasoccer`. 
```R
setwd("D:/BEDU/PROGRAMACIÓN Y ESTADÍSTICA CON R/SESIÓN 5/PW/")

library(fbRanks)

listasoccer <- create.fbRanks.dataframes(
  scores.file = "soccer.csv")
  
# A los dataframes `scores` y `teams`, les asignamos las siguientes variables 

anotaciones <- listasoccer$scores
equipos <- listasoccer$teams

```
```R
head(anotaciones)

date  home.team home.score  away.team away.score
1 2017-08-18    Leganes          1     Alaves          0
2 2017-08-18   Valencia          1 Las Palmas          0
3 2017-08-19      Celta          2   Sociedad          3
4 2017-08-19     Girona          2 Ath Madrid          2
5 2017-08-19    Sevilla          1    Espanol          1
6 2017-08-20 Ath Bilbao          0     Getafe          0

head(equipos)

head(equipos)
        name
1     Alaves
2 Ath Bilbao
3 Ath Madrid
4  Barcelona
5      Betis
6      Celta
```

Usando la función `unique` vamos a crear un vector de fechas en donde no se deben repetir y que estas
correspondan a las fechas en las que fueron jugados los partidos.
```R
fecha <- unique(SmallData$date)
fecha <- as.Date(fecha, "%d/%m/%Y")
fecha <- sort(fecha)
```
```R
 [1] "2017-08-18" "2017-08-19" "2017-08-20" "2017-08-21" "2017-08-25"
 [6] "2017-08-26" "2017-08-27" "2017-09-08" "2017-09-09" "2017-09-10"
 [11] "2017-09-11" "2017-09-15" "2017-09-16" "2017-09-17" "2017-09-18"
```
Después creamos una variable llamada n, la cual va a contener el número de fechas diferentes.
```R
n <- length(fecha)
```

Posteriormente, usando la función `rank.teams` usando como argumentos los dataframes creados arriba: 
`anotaciones` y `equipos`, vamos a crear un ranking de equipos, usaremos sólo los datos de la fecha 
inicial y la penúltima fecha en la que se jugaron los partidos, nuestra variable que almacenará este 
dato será nombrada `ranking`. 
```R
ranking <- rank.teams(anotaciones, teams = equipos, 
                      max.date = fecha[n-1], min.date = fecha[1], 
                      date.format = "%d/%m/%Y")
```

```R
Team Rankings based on matches 18/08/2017 to 22/12/2020
   team        total attack defense n.games.Var1 n.games.Freq
1  Barcelona    1.53 2.24   1.29    Barcelona    114         
2  Ath Madrid   1.23 1.32   1.77    Ath Madrid   114         
3  Real Madrid  1.13 1.86   1.17    Real Madrid  114         
4  Valencia     0.54 1.33   1.10    Valencia     113         
5  Getafe       0.53 1.08   1.33    Getafe       114         
6  Granada      0.47 1.33   1.05    Granada       38         
7  Sevilla      0.44 1.36   0.99    Sevilla      113         
8  Villarreal   0.35 1.40   0.91    Villarreal   114         
9  Sociedad     0.32 1.38   0.90    Sociedad     114         
10 Ath Bilbao   0.10 1.01   1.06    Ath Bilbao   114         
11 Osasuna      0.06 1.19   0.88    Osasuna       38         
12 Betis        0.02 1.27   0.80    Betis        114         
13 Celta        0.01 1.24   0.81    Celta        114         
14 Levante     -0.01 1.26   0.79    Levante      113         
15 Eibar       -0.06 1.07   0.90    Eibar        114         
16 Girona      -0.18 1.07   0.82    Girona        76         
17 Espanol     -0.22 0.92   0.94    Espanol      114         
18 Alaves      -0.27 0.94   0.88    Alaves       114         
19 Valladolid  -0.29 0.80   1.02    Valladolid    76         
20 Leganes     -0.31 0.83   0.97    Leganes      113         
21 Huesca      -0.35 1.08   0.72    Huesca        37         
22 Mallorca    -0.39 1.04   0.73    Mallorca      38         
23 Vallecano   -0.56 1.02   0.66    Vallecano     37         
24 La Coruna   -0.83 0.94   0.60    La Coruna     38         
25 Malaga      -1.18 0.58   0.76    Malaga        38         
26 Las Palmas  -1.44 0.59   0.62    Las Palmas    38
```

Para concluir, vamos a generar la predicción de los partidos que fueron registrados en la última fecha del vector que contiene las fechas. 
```R
predict(ranking, date = fecha[n])
```
```R
Predicted Match Results for 01/05/1900 to 01/06/2100
Model based on data from 18/08/2017 to 22/12/2020
---------------------------------------------
23/12/2020 Leganes vs Sevilla, HW 22%, AW 50%, T 27%, pred score 0.8-1.4  actual: T (1-1)
23/12/2020 Valencia vs Huesca, HW 57%, AW 20%, T 23%, pred score 1.8-1  actual: HW (2-1)
23/12/2020 Vallecano vs Levante, HW 26%, AW 51%, T 23%, pred score 1.3-1.9  actual: HW (2-1)
```
