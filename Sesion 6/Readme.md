# Sesion 6. Series de tiempo.
## Data Science
### Fase 2


#### Objetivo

Obtener predicciones de ventas, de la demanda de productos o servicios, que ayuden a las organizaciones a ajustar presupuestos, justificar decisiones de marketing, o tener un mejor conocimiento sobre la evolución del negocio.

## Postwork

#### Instrucciones

Importa el conjunto de datos match.data.csv a `R` y realiza lo siguiente:

1. Agrega una nueva columna `sumagoles` que contenga la suma de goles por partido.

2. Obtén el promedio por mes de la suma de goles.

3. Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.

4. Grafica la serie de tiempo.


#### Desarrollo
##### Inciso 1

Importamos el data set con el que trabajaremos para despues utilizar un data frame que contenga los datos, a este ultimo agregaremos una columna que corresponde a la suma de goles
```R
datos <- read.csv("match.data.csv")

datos <- datos %>% mutate(sumagoles = home.score + away.score)
```
Uno de los inconvenientes que tuvimos fue el formato de la fecha, lo arreglamos con este comando
```R
datos$date <- as.Date(datos$date)
```
Realizamos un nuevo data frame el cual tendra el promedio de los goles 

```R
promedio <- datos %>% 
  select(date, sumagoles) %>% 
  group_by(format(date, "%Y"), months.Date(date)) %>% 
  summarise(prom = mean(sumagoles))

(promedio)
colnames(promedio) <- c("Anio", "Mes", "Promedio")
```
Generamos una serie de tiempo y la graficamos
```R
promedio2 <- ts(promedio$Promedio, start = c(2010, 8), end = c(2020, 3), frequency = 12)

plot(promedio2, xlab = "", ylab = "")
title(main = "Serie de Promedio de Goles en España",
      ylab = "Promedio de Goles mensuales",
      xlab = "Tiempo")
```

#### Conclusión

Si se desea se puede consultar/ descargar el archivo de R de este ejercicio, se encuentra en este mismo repositorio, con el nombre `Postwork.R`.

Alumnos 
* Sofía Cristina Suárez Campos
* David Garduño Guzmán
* Andrea Noemi Aguilar Hidalgo
* Miguel Angel Monteros Cervantes
