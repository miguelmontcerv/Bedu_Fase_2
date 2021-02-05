  setwd("c:/escomc/ds")
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

#Guardamos solo los datos en México
  datos_mexico <- filter(datos, desc_municipio == "Estados Unidos Mexicanos")
  datos_mexico <- datos_mexico[10:16,]
  datos_mexico <- select(datos_mexico,-X1994:-X2014,-X2016:-X2019)
 
#Guardamos la primer fila en otro DS y lo eliminamos del DS original
solteros_en_mexico <- solteros[1,]
solteros <- solteros[!(solteros$desc_entidad == 'Estados Unidos Mexicanos'),]

#Graficamos cuando ha subido la cantidad de solteros en toda la republica mexicana

ggplot(data=solteros_en_mexico, aes(x=X2015, y="X2015")) + geom_bar(stat="identity")

#Seleccionamos a los solteros de la CDMX
solteros_CDMX <- solteros[!(solteros$desc_entidad != 'Ciudad de México'),]

#Ajuste de tipo de dato
solteros <- mutate(solteros,X2015 = as.numeric(X2015))
solteros <- mutate(solteros,X2020 = as.numeric(X2020))

#Al tener un NA en un valor de la columna 2015, utilizaremos la tasa de crecimiento con respecto al 2020 y 
media <- solteros %>% 
  filter(cve_municipio != 0) %>% 
  group_by(desc_entidad) %>% 
  summarise(media2015 = mean(X2015, na.rm = T), media2020 = mean(X2020))

#Calculamos las medias de cada estado y graficamos
m15 <- media %>% 
  arrange(desc(media2015))

m20 <- media %>% 
  arrange(desc(media2020))

ggplot(
  data = m15,
  mapping = aes(
    x = desc_entidad,
    y = media2015, 
    fill = factor(desc_entidad)
  )
) + geom_bar(stat = "identity") +
  coord_flip()

grafica <- ggplot(m20, aes(x = desc_entidad, y = media2020, fill = factor(desc_entidad)))+
  geom_bar(stat = "identity")+ coord_flip() +
  labs(
    title = "Tabla de Procentajes de Solteros",
    x = " Estado",
    y = " Porcentaje de Solteros ",
    fill = " Porcentaje"
  )
grafica

#Seleccionamos unicamente el top 5

bajos <- m15[28:32,]

m15 <- m15[1:5,]
m20 <- m20[1:5,]

ggplot(
  data = m15,
  mapping = aes(
    x = desc_entidad,
    y = media2015, 
    fill = factor(desc_entidad)
  )
) + geom_bar(stat = "identity") +
  coord_flip()

ggplot(
  data = m20,
  mapping = aes(
    x = desc_entidad,
    y = media2015, 
    fill = factor(desc_entidad)
  )
) + geom_bar(stat = "identity") +
  coord_flip()

#Continuamos con los otros estados
cdmx <- solteros %>% 
  select(cve_municipio, desc_entidad, desc_municipio, X2020) %>% 
  filter(cve_municipio != 0, desc_entidad == "Ciudad de México") %>% 
  arrange(desc(X2020))

edomex <- solteros %>% 
  select(cve_municipio, desc_entidad, desc_municipio, X2020) %>% 
  filter(cve_municipio != 0, desc_entidad == "México") %>% 
  arrange(desc(X2020))

mich <- solteros %>% 
  select(cve_municipio, desc_entidad, desc_municipio, X2020) %>% 
  filter(cve_municipio != 0, desc_entidad == "Michoacán de Ocampo") %>% 
  arrange(desc(X2020))

#Graficamos cada estado
grafica <- ggplot(cdmx, aes(x = desc_municipio, y = X2020, fill = factor(desc_municipio)))+
  geom_bar(stat = "identity")+ coord_flip() +
  labs(
    title = "Tabla de Procentajes de Solteros",
    x = " Municipio",
    y = " Porcentaje de Solteros ",
    fill = " Entidades"
  )
grafica
