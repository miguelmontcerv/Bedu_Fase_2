# Proyecto: La Ciencia de Datos Detrás del Amor
## Data Science
### Fase 2

#### Presentan los Alumnos:
* Sofía Cristina Suárez Campos
* David Garduño Guzmán
* Andrea Noemi Aguilar Hidalgo
* Miguel Angel Monteros Cervantes

#### Objetivo

Realizar tareas de limpieza, manipulación y análisis de los datos de nupcialidad del INEGI utilizando el lenguaje de programación R, para después poder crear visualizaciones, predicciones y modelaje matemático, que permitirán transformar datos en información, que se espera pueda orientar a la población de México en la búsqueda de una pareja sentimental y en sus desiciones de pareja.

#### Hipótesis

Con el paso de los años, la cantidad de divorcios en México ha aumentado en comparación con los matrimonios.

#### Desarrollo

En este apartado se muestra y explica el código desarrollado.

1. Se define el espacio de trabajo y se importan las librerías a utilizar.
  ```R
  setwd("c:/escomc/ds")
  library(readxl)
  library(dplyr)
  library(ggplot2)
  ```
2. Se hace la lectura del archivo en excel.
  ```R
  excel_format <- read_xlsx("nupcialidad.xlsx")
  ``` 
3. Este archivo se transforma en un data frame.
  ```R
  datos <- data.frame(excel_format)
  ```
4. Se verifica su estructura.
  ```R
  str(datos)
  ```
5. Seleccionamos el censo donde únicamente se consideró a los solteros.
  ```R
  solteros <- filter(datos, indicador == "Porcentaje de la población de 12 años y más soltera")
  ```
6. Se hace la limpieza de datos descartando los datos de las columnas inecesarias.
  ```R
  solteros <- select(solteros,-X1994)
  solteros <- select(solteros,-X1995,-X1996,-X1997,-X1998,-X1999)
  solteros <- select(solteros,-X2000:-X2010)
  solteros <- select(solteros,-X2011:-X2014,-X2016:-X2019)
  solteros <- select(solteros,-unidad_medida)
  ```
7. Se guardan sólo los datos de México.
  ```R
  datos_mexico <- filter(datos, desc_municipio == "Estados Unidos Mexicanos")
  datos_mexico <- datos_mexico[10:16,]
  datos_mexico <- select(datos_mexico,-X1994:-X2014,-X2016:-X2019)
  ```
8. Se guarda la primer fila en otro data frame y lo eliminamos del original
  ```R
  solteros_en_mexico <- solteros[1,]
  solteros <- solteros[!(solteros$desc_entidad == 'Estados Unidos Mexicanos'),]
  ```
9. Se grafica la cantidad de solteros en toda la República Mexicana
  ```R
  ggplot(data=solteros_en_mexico, aes(x=X2015, y="X2015")) + geom_bar(stat="identity")
  ```
10. Se selecciona a los solteros de la CDMX.
  ```R
  solteros_CDMX <- solteros[!(solteros$desc_entidad != 'Ciudad de México'),]
  ```
11. Se hace el ajuste del tipo de dato
  ```R
  solteros <- mutate(solteros,X2015 = as.numeric(X2015))
  solteros <- mutate(solteros,X2020 = as.numeric(X2020))
  ```
12. Al tener un NA en un valor de la columna 2015, se utiliza la tasa de crecimiento con respecto al 2020 para completar los datos.
  ```R
  media <- solteros %>% 
  filter(cve_municipio != 0) %>% 
  group_by(desc_entidad) %>% 
  summarise(media2015 = mean(X2015, na.rm = T), media2020 = mean(X2020))
  ```
13. Se calcula la media de cada estado y se crean las gráficas.
  ```R
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
  ```
14. Se selecciona únicamente el top 5:
  ```R
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
   ```
15. Continuamos con los estados.
  ```R
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
  ```
16. Se grafica cada estado.
  ```R
  grafica <- ggplot(cdmx, aes(x = desc_municipio, y = X2020, fill = factor(desc_municipio)))+
    geom_bar(stat = "identity")+ coord_flip() +
    labs(
      title = "Tabla de Procentajes de Solteros",
      x = " Municipio",
      y = " Porcentaje de Solteros ",
      fill = " Entidades"
    )
  grafica
  ```

##### Predicciones

17. Se seleccionan y filtran los datos a procesar.
  ```R
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
  ```
18. Se hacen modificaciones de tipo de dato y se agrupan divorcios y matrimonios por entidad.
  ```R
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
  ```
19. Se selecciona el modelo de regresión lineal simple y se grafica.
  ```R
  modelo1 <- lm(Divorcios~Matrimonios)
  summary(modelo1)

  plot(Matrimonios, Divorcios, pch = 16)
  abline(lsfit(Matrimonios, Divorcios)) 
  mtext(expression(paste('Regresión lineal estimada:',
                         ' ',
                         hat(y)[i] == 389300 - 0.5044*x[i] + e[i])),
        side = 3, adj=1, font = 2)
   ```   
20. Se encuentran intervalos de confianza del 95% para el intercepto y la pendiente del modelo de regresión lineal simple.

  ```R
  round(confint(modelo1, level = 0.95), 2)

  conf <- predict(modelo1, interval = "confidence", level = 0.95)
  pred <- predict(modelo1, interval = "prediction", level = 0.95)

  lines(Matrimonios, pred[, 2], lty = 2, lwd = 2, col = "blue") # límites inferiores
  lines(Matrimonios, pred[, 3], lty = 2, lwd = 2, col = "blue") # límites superiores

  lines(Matrimonios, conf[, 2], lty = 2, lwd = 2, col = "green") # límites inferiores
  lines(Matrimonios, conf[, 3], lty = 2, lwd = 2, col = "green") # límites superiores
  ```
21. Se obtiene la Probabilidad de divorcio.
  ```R
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
   ```
22. Se encuentran intervalos de confianza del 95% para el intercepto y la pendiente del modelo de regresión lineal simple.
  ```R
  round(confint(modelo2, level = 0.95), 2)

  conf2 <- predict(modelo2, interval = "confidence", level = 0.95)
  pred2 <- predict(modelo2, interval = "prediction", level = 0.95)

  lines(1994:2019, pred2[, 2], lty = 2, lwd = 2, col = "red") # límites inferiores
  lines(1994:2019, pred2[, 3], lty = 2, lwd = 2, col = "red") # límites superiores

  lines(1994:2019, conf2[, 2], lty = 2, lwd = 2, col = "green") # límites inferiores
  lines(1994:2019, conf2[, 3], lty = 2, lwd = 2, col = "green") # límites superiores
  ```
23. Ahora los Divorcios judiciales
```R
modelo3 <- lm()
```

Utilizando este código, se creó un dashboard en Shiny, el cual muestra las gráficas obtenidas de una forma amigable para el usuario y que ayuda al análisis de la información. Este se puede consultar dentro de la carpeta `proyectoShinyWeb`, dentro de este mismo repositorio.

#### Resultados

Se obtuvieron los estados con mayor porcentaje de solteros respecto a su población total obteniendo como top 5:

1. Ciudad de México: 47.9 %
2. Querétaro: 35.2 %
3. Baja California: 34.6 %
4. Jalisco: 34.2 %
5. Aguascalientes: 34.1 %

Analizando el estado con mayor porcentaje de solteros, la Ciudad de México, se obtuvo el porcentaje de solteros por alcaldía, teniendo como top 5:

1. Cuauhtémoc: 42.5 %
2. Benito Juárez: 41.0 %
3. Miguel Hidalgo: 40.1 %
4. Coyoacán: 39.3 %
5. Venustiano Carranza: 39.0 %

Utilizando este código se puede obtener el porcentaje de solteros de cualquier estado de la República Mexicana y así mismo de los municipios en cada uno de ellos.

Basándonos en las gráficas obtenidas podemos concluir que la hipótesis planteada inicialmente es errónea porque la cantidad de divorcios respecto a los matrimonios a lo largo del tiempo ha disminuido. Sin embargo, al analizar la predicción de la cantidad de divorcios por cada 100 matrimonios para 2021, se obtuvo que casi el 30 % de esos 100 matrimonios termina en divorcio y no hay que olvidar que el 90 % de ellos son divorcios judiciales.

Los resultados de este trabajo se pusieron en una presentación, que se encuentra en este repositorio con el nombre: `Proyecto Bedu 2021.pdf`.

El video de este trabajo se encuentra en la siguiente dirección: https://youtu.be/LEMz9kvgiwU

#### Trabajo posterior

En posteriores etapas de este proyecto se espera poder analizar más a fondo la búsqueda de pareja y las causas de divorcio para así procesar las variables demográficas que afectan estos fenómenos y poder dar un estimado de probabilidad de que alguna pareja se mantenga unida o se separe.

#### Agradecimientos

Agradecemos a BEDU y a Santander por la oportunidad de aprender tan útiles herramientas.
