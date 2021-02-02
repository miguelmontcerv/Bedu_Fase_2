# Sesión 7. RStudio Cloud - Github, conexiones con BDs y lectura de datos externos
## Data Science
### Fase 2


**Objetivo**: 
- Trabajar con RStudio desde la nube y enviar (traer) código a (desde) un repositorio de github
- Conectarte a una BDD con `R`
- Importar datos de una BDD a `R`
- Manipular datos de una BDD en `R`

## Postwork

### Instrucciones

Utilizando el manejador de BDD _Mongodb Compass_ (previamente instalado), deberás de realizar las siguientes acciones: 

- Alojar el fichero  `data.csv` en una base de datos llamada `match_games`, nombrando al `collection` como `match`

- Una vez hecho esto, realizar un `count` para conocer el número de registros que se tiene en la base

- Realiza una consulta utilizando la sintaxis de **Mongodb**, en la base de datos para conocer el número de goles que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

- Por último, no olvides cerrar la conexión con la BDD
 
### Desarrollo
1. Importamos las librerías necesarias para poder tener una conexión con MongoDB Compass, se utilizaron los siguientes comandos:

```R
conn <- mongo(
  collection = "match",
  db = "match_games",
  url = "mongodb+srv://andyAH:fuJIN42kAiUlGilz@cluster0.alxih.mongodb.net/test",
  verbose = FALSE,
  options = ssl_options()
)
```


2. Hacemos un conteo del número de registros que tiene la base de datos

```R
conn$count()
```

3. Realizamos una consulta utilizando la sintaxis ya conocida de **MongoDB** y de esta manera conoceremos el número de goles que realizo el Real Madrid el 20 de diciembrte del 2015

```R
consulta <- conn$aggregate('[
  {
    "$match": {
      "HomeTeam": "Real Madrid"
    }
  }, {
    "$project": {
      "Año": {
        "$year": "$Date"
      }, 
      "Mes": {
        "$month": "$Date"
      }
    }
  }, {
    "$match": {
      "Mes": {
        "$eq": 12
      }
    }
  }, {
    "$project": {
      "_id": 1, 
      "Año": 1, 
      "Mes": 1, 
      "HomeTeam": 1
    }
  }
]')
```

4. Por último, cerramos la conexión que hicimos con la base de datos para después eliminar la variable y de esta manera no desperdiciar memoria

```R
conn$disconnect()
rm(conn)
```

Si se desea se puede consultar/ descargar el archivo de R de este ejercicio, se encuentra en este mismo repositorio, con el nombre `Postwork.R`.

Alumnos 
* Sofía Cristina Suárez Campos
* David Garduño Guzmán
* Andrea Noemi Aguilar Hidalgo
* Miguel Angel Monteros Cervantes
