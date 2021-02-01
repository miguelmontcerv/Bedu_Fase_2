setwd("c:/escomc/ds")
install.packages("readxl")
library(readxl)
library(dplyr)
library(ggplot2)
#Leemos el archivo en excel
excel_format <- read_xlsx("nupcialidad.xlsx")

#Lo transformamos en un DS
datos <- data.frame(excel_format)
#Verificamos su estrucutura
str(datos)

#Seleccionamos el senso donde unicamente se consideraron a los solteros
solteros <- filter(datos, indicador == "Porcentaje de la población de 12 años y más soltera")

#Limpiamos los datos de las columnas inecesarias
solteros <- select(solteros,-X1994)
solteros <- select(solteros,-X1995,-X1996,-X1997,-X1998,-X1999)
solteros <- select(solteros,-X2000:-X2010)
solteros <- select(solteros,-X2011:-X2014,-X2016:-X2019)
solteros <- select(solteros,-unidad_medida)

#Guardamos la primer fila en otro DS y lo eliminamos del DS original
solteros_en_mexico <- solteros[1,]
solteros <- solteros[!(solteros$desc_entidad == 'Estados Unidos Mexicanos'),]

#Graficamos cuando ha subido la cantidad de solteros en toda la republica mexicana

ggplot(data=solteros_en_mexico, aes(x=X2015, y="X2015")) + geom_bar(stat="identity")

#Seleccionamos a los solteros de la CDMX
solteros_CDMX <- solteros[!(solteros$desc_entidad != 'Ciudad de México'),]
