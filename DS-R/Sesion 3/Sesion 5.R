# Tambi�n se puede hacer la lectura directamente desde el URL si as� se prefiere (ten en cuenta que es un poco m�s lento debido al tama�o de los archivos)

setwd("c:/Escomc/bedu_fase_2/Sesion3")

conf <- read.csv("st19ncov-confirmados.csv")
mu <- read.csv("st19ncov-muertes.csv")

# Eliminamos la primer fila

Sconf <- conf[-1, ]
Smu <- mu[-1, ]

summary(Sconf)

Sconf <- select(Sconf, Country.Region, Date, Value) # Pa�s, 

Sconf <- rename(Sconf, Country = Country.Region, Infectados = Value) # Cambiamos el nombre de las variables

Sconf <- mutate(Sconf, Date = as.Date(Date, "%Y-%m-%d"), Infectados = as.numeric(Infectados)) # Transformamos la variable
# Seleccionamos pa�s, fecha y acumulado de muertos
Smu <- select(Smu, Country.Region, Date, Value) 
Smu <- rename(Smu, Country = Country.Region, Muertos = Value) # Renombramos
Smu <- mutate(Smu, Date = as.Date(Date, "%Y-%m-%d"), Muertos = as.numeric(Muertos)) # Transformamos
# Unimos infectados y muertos acumulados para cada fecha
Scm <- merge(Sconf, Smu)  
mex <- filter(Scm, Country == "Mexico") # Seleccionamos s�lo a M�xico
mex <- filter(mex, Infectados != 0) # Comienzan los infectados en M�xico

mex <- mutate(mex, NI = c(1, diff(Infectados))) # Nuevos infectados por d�a
mex <- mutate(mex, NM = c(0, diff(Muertos))) # Nuevos muertos por d�a

mex <- mutate(mex, Letalidad = round(Muertos/Infectados*100, 1)) # Tasa de letalidad

mex <- mutate(mex, IDA = lag(Infectados), MDA = lag(Muertos)) # Valores d�a anterior
mex <- mutate(mex, FCI = Infectados/IDA, FCM = Muertos/MDA) # Factores de Crecimiento
mex <- mutate(mex, Dia = 1:dim(mex)[1]) # D�as de contingencia

setwd(".../Sesion_03/")  #Fijando el wd
# Escribimos los resultados de la variable mex, en el archivo C19Mexico.csv

write.csv(mex, "C19Mexico.csv")
dir()  # observemos que se creo en la ruta deseada

# install.packages("scales")

library(scales)
# Ahora vamos a leer nuestro archivo con los resultados de la variable mex con los infectados y muertos acumulados para cada fecha

mex <- read.csv("C19Mexico.csv")

head(mex); tail(mex)

mex <- mutate(mex, Date = as.Date(Date, "%Y-%m-%d"))
str(mex)

####################################################################

# A continuaci�n, te presentamos un panorama de la situaci�n que se ha estado viviendo en M�xico, debido al coronavirus. Es informaci�n simple, que puede resultar valiosa para algunas personas. Las gr�ficas, las hemos realizado utilizando datos que puedes encontrar en el siguiente sitio: https://data.humdata.org/dataset/novel-coronavirus-2019-ncov-cases

# Acumulado de Casos Confirmados

p <- ggplot(mex, aes(x=Date, y=Infectados)) + 
  geom_line( color="blue") + 
  geom_point() +
  labs(x = "Fecha", 
       y = "Acumulado de casos confirmados",
       title = paste("Confirmados de COVID-19 en M�xico:", 
                     format(Sys.time(), 
                            tz="America/Mexico_City", 
                            usetz=TRUE))) +
  theme(plot.title = element_text(size=12))  +
  theme(axis.text.x = element_text(face = "bold", color="#993333" , 
                                   size = 10, angle = 45, 
                                   hjust = 1),
        axis.text.y = element_text(face = "bold", color="#993333" , 
                                   size = 10, angle = 45, 
                                   hjust = 1))  # color, �ngulo y estilo de las abcisas y ordenadas 
p

p <- p  + scale_x_date(labels = date_format("%d-%m-%Y")) # paquete scales

p
###

p <- p +
  theme(plot.margin=margin(10,10,20,10), plot.caption=element_text(hjust=1.05, size=10)) +
  annotate("text", x = mex$Date[round(dim(mex)[1]*0.4)], y = max(mex$Infectados), colour = "blue", size = 5, label = paste("�ltima actualizaci�n: ", mex$Infectados[dim(mex)[1]]))
p

# Casos Confirmados por D�a

p <- ggplot(mex, aes(x=Date, y=NI)) + 
  geom_line(stat = "identity") + 
  labs(x = "Fecha", y = "Incidencia (N�mero de casos nuevos)",
       title = paste("Casos de Incidencia de COVID-19 en M�xico:", 
                     format(Sys.time(), 
                            tz="America/Mexico_City", usetz=TRUE))) +
  theme(plot.title = element_text(size=12))  +
  theme(axis.text.x = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1),
        axis.text.y = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1))  # color, �ngulo y estilo de las abcisas y ordenadas

p <- p  + scale_x_date(labels = date_format("%d-%m-%Y")) # paquete scales
p

nimax <- which.max(mex$NI)
mex[nimax,]

###

p <- p +
  theme(plot.margin=margin(10,10,20,10), plot.caption=element_text(hjust=1.05, size=10)) +
  annotate("text", x = mex$Date[round(dim(mex)[1]*0.4)], y = max(mex$NI), colour = "blue", size = 5, 
           label = paste("�ltima actualizaci�n: ", mex$NI[length(mex$NI)]))
p

# Muertes Acumuladas

mexm <- subset(mex, Muertos > 0) # Tomamos el subconjunto desde que comenzaron las muertes

p <- ggplot(mexm, aes(x=Date, y=Muertos)) + geom_line( color="red") + 
  geom_point() +
  labs(x = "Fecha", 
       y = "Muertes acumuladas",
       title = paste("Muertes por COVID-19 en M�xico:", format(Sys.time(), tz="America/Mexico_City",usetz=TRUE))) +
  theme(axis.text.x = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1),
        axis.text.y = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1))  # color, �ngulo y estilo de las abcisas y ordenadas

p <- p  + scale_x_date(labels = date_format("%d-%m-%Y"))

p


###

p <- p +
  theme(plot.margin=margin(10,10,20,10), plot.caption=element_text(hjust=1.05, size=10)) +
  annotate("text", x = mexm$Date[round(dim(mexm)[1]*0.4)], 
           y = max(mexm$Muertos), colour = "red", size = 5, label = paste("�ltima actualizaci�n: ", mexm$Muertos[dim(mexm)[1]]))
p

# Muertes por D�a
p <- ggplot(mexm, aes(x=Date, y=NM)) + 
  geom_line(stat = "identity") + 
  labs(x = "Fecha", y = "N�mero de nuevos decesos",
       title = paste("Nuevos decesos por COVID-19 en M�xico:", 
                     format(Sys.time(), tz="America/Mexico_City",usetz=TRUE))) +
  theme(plot.title = element_text(size=12)) +
  theme(axis.text.x = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1),
        axis.text.y = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1))  # color, �ngulo y estilo de las abcisas y ordenadas

p <- p  + scale_x_date(labels = date_format("%d-%m-%Y"))
p
###

p <- p +
  theme(plot.margin=margin(10,10,20,10), plot.caption=element_text(hjust=1.05, size=10)) +
  annotate("text", x = mexm$Date[round(dim(mexm)[1]*0.2)], 
           y = max(mexm$NM), colour = "red", size = 5, label = paste("�ltima actualizaci�n: ", mexm$NM[dim(mexm)[1]]))
p

# Acumulado de Casos Confirmados y Muertes
p <- ggplot(mex, aes(x=Date, y=Infectados)) + geom_line(color="blue") + 
  labs(x = "Fecha", 
       y = "Acumulado de casos",
       title = paste("COVID-19 en M�xico:", format(Sys.time(), tz="America/Mexico_City",usetz=TRUE))) +
  geom_line(aes(y = Muertos), color = "red") +
  theme(axis.text.x = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1),
        axis.text.y = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1))  # color, �ngulo y estilo de las abcisas y ordenadas

p <- p  + scale_x_date(labels = date_format("%d-%m-%Y"))

p

###

p <- p +
  theme(plot.margin=margin(10,10,20,10), plot.caption=element_text(hjust=1.05, size=10)) +
  annotate("text", x = mex$Date[round(dim(mex)[1]*0.4)], 
           y = max(mex$Infectados), colour = "blue", size = 5, label = paste("�ltima actualizaci�n para Infectados:", mex$Infectados[dim(mex)[1]])) +
  annotate("text", x = mex$Date[round(dim(mex)[1]*0.4)], 
           y = max(mex$Infectados)-100000, colour = "red", size = 5, label = paste("�ltima actualizaci�n para Muertes:", mex$Muertos[dim(mex)[1]])) 
p

# Tasa de Letalidad: La tasa de letalidad observada para un d�a determinado, la calculamos dividiendo las muertes acumuladas reportadas hasta ese d�a, entre el acumulado de casos confirmados para el mismo d�a. Multiplicamos el resultado por 100 para reportarlo en forma de porcentaje. Lo que obtenemos es el porcentaje de muertes del total de casos confirmados.

p <- ggplot(mexm, aes(x=Date, y=Letalidad)) + geom_line(color="red") + 
  labs(x = "Fecha", 
       y = "Tasa de letalidad",
       title = paste("COVID-19 en M�xico:", format(Sys.time(), tz="America/Mexico_City",usetz=TRUE))) +
  theme(axis.text.x = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1),
        axis.text.y = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1)) + # color, �ngulo y estilo de las abcisas y ordenadas 
  scale_y_discrete(name ="Tasa de letalidad", 
                   limits=factor(seq(1, 13.5, 1)), labels=paste(seq(1, 13.5, 1), "%", sep = ""))

p

p <- p  + scale_x_date(labels = date_format("%d-%m-%Y"))


###

p <- p +
  theme(plot.margin=margin(10,10,20,10), plot.caption=element_text(hjust=1.05, size=10)) +
  annotate("text", x = mexm$Date[round(length(mexm$Date)*0.2)], 
           y = max(mexm$Letalidad)-1, colour = "red", size = 4, label = paste("�ltima actualizaci�n: ", mexm$Letalidad[dim(mexm)[1]], "%", sep = "")) 
p

# Factores de Crecimiento:

# El factor de crecimiento de infectados para un d�a determinado, lo calculamos al dividir el acumulado de infectados para ese d�a, entre el acumulado de infectados del d�a anterior. El factor de crecimiento de muertes lo calculamos de forma similar.

mex <- filter(mex, FCM < Inf) # Tomamos solo valores reales de factores de crecimiento

p <- ggplot(mex, aes(x=Date, y=FCI)) + geom_line(color="blue") + 
  labs(x = "Fecha", 
       y = "Factor de crecimiento",
       title = paste("COVID-19 en M�xico:", format(Sys.time(), tz="America/Mexico_City",usetz=TRUE))) +
  geom_line(aes(y = FCM), color = "red") + theme(plot.title = element_text(size=12)) +
  theme(axis.text.x = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1),
        axis.text.y = element_text(face = "bold", color="#993333" , size = 10, angle = 45, hjust = 1))  # color, �ngulo y estilo de las abcisas y ordenadas

p <- p  + scale_x_date(labels = date_format("%d-%m-%Y"))

###

p <- p +
  annotate("text", x = mex$Date[round(length(mex$Date)*0.4)], y = max(mex$FCM), colour = "blue", size = 5, label = paste("�ltima actualizaci�n para infectados: ", round(mex$FCI[dim(mex)[1]], 4))) +
  annotate("text", x = mex$Date[round(length(mex$Date)*0.4)], y = max(mex$FCM)-0.2, colour = "red", size = 5, label = paste("�ltima actualizaci�n para muertes: ", round(mex$FCM[dim(mex)[1]], 4))) 
p
