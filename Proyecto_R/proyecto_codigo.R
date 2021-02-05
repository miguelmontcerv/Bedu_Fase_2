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

# Predicciones

divormx <- datos %>% 
  filter(indicador %in% c("Matrimonios", "Divorcios",
                          "Relación divorcios - matrimonios", 
                          "Divorcios judiciales", 
                          "Divorcios administrativos")) %>% 
  filter(desc_entidad == "Estados Unidos Mexicanos")

datos2 <- datos %>% 
  filter(indicador %in% c("Matrimonios", "Divorcios",
                          "Relación divorcios - matrimonios", 
                          "Divorcios judiciales", 
                          "Divorcios administrativos")) %>% 
  filter(desc_entidad != "Estados Unidos Mexicanos")

divormx <- divormx %>% 
  select(-c("cve_entidad", "cve_municipio", "desc_municipio", 
            "desc_entidad", "id_indicador"))
divormx <- divormx %>% 
  select(-c("indicador", "unidad_medida", "X2020"))

divorcios <- datos2 %>% 
  select(-c("cve_entidad", "cve_municipio", "id_indicador")) %>% 
  filter(desc_municipio != "No especificado", indicador == "Divorcios") %>% 
  filter(desc_municipio == "Estatal")

matrimonios <- datos2 %>% 
  select(-c("cve_entidad", "cve_municipio", "id_indicador")) %>% 
  filter(desc_municipio != "No especificado", indicador == "Matrimonios") %>% 
  filter(desc_municipio == "Estatal")

# Divorcios y matrimonios por entidad

divorcios_final <- divorcios %>% 
  select(c("desc_entidad", "X2017", "X2018", "X2019")) %>% 
  rename("Entidad" = desc_entidad) %>% 
  mutate(X2017 = as.numeric(X2017), X2018 = as.numeric(X2018), X2019 = as.numeric(X2019)) %>% 
  arrange(desc(X2019), desc(X2018), desc(X2017))  

matrimonios_final <- matrimonios %>% 
  select(c("desc_entidad", "X2017", "X2018", "X2019")) %>% 
  rename("Entidad" = desc_entidad) %>% 
  mutate(X2017 = as.numeric(X2017), X2018 = as.numeric(X2018), X2019 = as.numeric(X2019)) %>% 
  arrange(desc(X2019), desc(X2018), desc(X2017))


divorcios_mx <- data.frame(t(divormx))
colnames(divorcios_mx) <- c("Matrimonios",
                            "Divorcios",
                            "Relación_divorcios_matrimonios",
                            "Divorcios_judiciales",
                            "Divorcios_administrativos")
rownames(divorcios_mx) <- 1994:2019
divorcios_mx <- divorcios_mx %>% 
  mutate(
    Matrimonios = as.numeric(Matrimonios),
    Divorcios= as.numeric(Divorcios),
    Relación_divorcios_matrimonios = as.numeric(Relación_divorcios_matrimonios),
    Divorcios_judiciales = as.numeric(Divorcios_judiciales),
    Divorcios_administrativos = as.numeric(Divorcios_administrativos)
  )


attach(divorcios_mx)
modelo1 <- lm(Divorcios~Matrimonios)
summary(modelo1)

plot(Matrimonios, Divorcios, pch = 16)
abline(lsfit(Matrimonios, Divorcios)) 
mtext(expression(paste('Regresión lineal estimada:',
                       ' ',
                       hat(y)[i] == 389300 - 0.5044*x[i] + e[i])),
      side = 3, adj=1, font = 2)

# Encontramos intervalos de confianza del 95% para el intercepto y la pendiente del modelo de regresión lineal simple
round(confint(modelo1, level = 0.95), 2)

conf <- predict(modelo1, interval = "confidence", level = 0.95)
pred <- predict(modelo1, interval = "prediction", level = 0.95)

lines(Matrimonios, pred[, 2], lty = 2, lwd = 2, col = "blue") # límites inferiores
lines(Matrimonios, pred[, 3], lty = 2, lwd = 2, col = "blue") # límites superiores

lines(Matrimonios, conf[, 2], lty = 2, lwd = 2, col = "green") # límites inferiores
lines(Matrimonios, conf[, 3], lty = 2, lwd = 2, col = "green") # límites superiores



# Probabilidad de divorcio

modelo2 <- lm(Relación_divorcios_matrimonios~c(1994:2019))
summary(modelo2)
plot(1994:2019, Relación_divorcios_matrimonios, pch = 16, 
     xlab = "Años", 
     ylab = "Divorcios por cada 100 matrimonios")
abline(lsfit(1994:2019, Relación_divorcios_matrimonios)) 
mtext(expression(paste('Regresión lineal estimada:',
                       ' ',
                       hat(y)[i] == -1978.1085 + 0.9930*x[i] + e[i])),
      side = 3, adj=1, font = 2)

# Encontramos intervalos de confianza del 95% para el intercepto y la pendiente del modelo de regresión lineal simple
round(confint(modelo2, level = 0.95), 2)

conf2 <- predict(modelo2, interval = "confidence", level = 0.95)
pred2 <- predict(modelo2, interval = "prediction", level = 0.95)

lines(1994:2019, pred2[, 2], lty = 2, lwd = 2, col = "red") # límites inferiores
lines(1994:2019, pred2[, 3], lty = 2, lwd = 2, col = "red") # límites superiores

lines(1994:2019, conf2[, 2], lty = 2, lwd = 2, col = "green") # límites inferiores
lines(1994:2019, conf2[, 3], lty = 2, lwd = 2, col = "green")

## Divorcios judiciales

modelo3 <- lm()



