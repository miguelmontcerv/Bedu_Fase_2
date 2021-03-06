# 2.5 apply, lapply, do.call

# Funci�n apply

# La funci�n apply regresa un vector, arreglo o lista de valores obtenidos 
# al aplicar una funci�n a los m�rgenes de un arreglo o matriz. Por ejemplo

X <- matrix(1:49, ncol = 7)
X
apply(X, 1, mean) # c�lculo de la media para las filas
apply(X, 2, median) # c�lculo de la mediana para las columnas


# Funci�n lapply

# La funci�n lapply se usa de la siguiente manera lapply(X, FUN, ...)
# donde X puede ser un vector o una lista, FUN es una funci�n que ser�
# aplicada a cada elemento de X y ... representa argumentos opcionales 
# para FUN. lapply regresa una lista de la misma longitud que X, en
# donde cada elemento de la lista es el resultado de aplicar FUN al
# elemento que corresponde de X.

# Vamos a utilizar lapply para leer un conjunto de archivos csv de manera
# consecutiva y r�pida, para esto debemos especificar un directorio
# de trabajo y descargar los archivos csv en nuestro directorio, por
# ejemplo, puede crear la carpeta soccer para descargar los datos

u1011 <- "https://www.football-data.co.uk/mmz4281/1011/SP1.csv"
u1112 <- "https://www.football-data.co.uk/mmz4281/1112/SP1.csv"
u1213 <- "https://www.football-data.co.uk/mmz4281/1213/SP1.csv"
u1314 <- "https://www.football-data.co.uk/mmz4281/1314/SP1.csv"

download.file(url = u1011, destfile = "SP1-1011.csv", mode = "wb")
download.file(url = u1112, destfile = "SP1-1112.csv", mode = "wb")
download.file(url = u1213, destfile = "SP1-1213.csv", mode = "wb")
download.file(url = u1314, destfile = "SP1-1314.csv", mode = "wb")

# podemos visualizar el nombre de los archivos descargados en un vector
# de strings de la siguiente manera
setwd("c:/escomc/ds")

var1011 <- read.csv("SP1-1011.csv")
var1112 <- read.csv("SP1-1112.csv.csv")
var1213 <- read.csv("SP1-1213.csv")
var1314 <- read.csv("SP1-1314.csv")

dir()

# podemos leer con una sola instrucci�n los archivos descargados
# usando la funci�n lapply de la siguiente manera

lista <- lapply(dir(), read.csv) # Guardamos los archivos en lista

# los elementos de lista son los archivos csv leidos y se encuentran
# como data frames

library(dplyr)
lista <- lapply(lista, select, Date:FTR) # seleccionamos solo algunas columnas de cada data frame
head(lista[[1]]); head(lista[[2]]); head(lista[[3]]); head(lista[[4]])

# cada uno de los data frames que tenemos en lista, los podemos combinar
# en un �nico data frame utilizando las funciones rbind y do.call
# de la siguiente manera

# Funci�n do.call

data <- do.call(rbind, lista)
head(data)
dim(data)
