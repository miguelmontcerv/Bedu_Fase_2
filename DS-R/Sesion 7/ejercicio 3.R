# Ejemplo 3. Variantes en la lectura de BDD con R

# Ahora utilizaremos otra opci�n para realizar queries a una BDD con la ayuda 
# de dplyr que sustituye a SELECT en MySQL y el operador %>%, hay que recordar 
# que con este comando tambi�n podemos realizar b�squedas de forma local.

# Comenzamos instalando las paqueter�as necesarias y carg�ndolas a R

 install.packages("pool")
 install.packages("dbplyr")

library(dbplyr)
library(pool)

# Se realiza la lectura de la BDD con el comando dbPool, los dem�s par�metros 
# se siguen utilizando igual que el ejemplo anterior

my_db <- dbPool(
  RMySQL::MySQL(), 
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)

# Para ver el contenido de la BDD y realizar una b�squeda se procede de la 
# siguiente manera

dbListTables(my_db)

# Obtener los primeros 5 registros de Country

my_db %>% tbl("Country") %>% head(5) # library(dplyr)

# Obtener los primeros 5 registros de CountryLanguage

my_db %>% tbl("CountryLanguage") %>% head(5)

# Otra forma de generar una b�squeda ser� con la librer�a DBI, utilizando el 
# comando dbSendQuery

library(DBI)
conn <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

rs <- dbSendQuery(conn, "SELECT * FROM City LIMIT 5;")

dbFetch(rs)

# Para finalizar nos desconectamos de la BDD

dbClearResult(rs)
dbDisconnect(conn)
