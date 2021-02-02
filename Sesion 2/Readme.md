# Sesion 2. Manipulación de datos en R: Postwork
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


Alumnos 
* Sofía Cristina Suárez Campos
* David Garduño Guzmán
* Andrea Noemi Aguilar Hidalgo
* Miguel Angel Monteros Cervantes
