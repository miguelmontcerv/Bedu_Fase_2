# Comenzamos leyendo un fichero, el cual contiene informaci�n sobre dos grupos de control G1 y G2, a los cuales se les realiz� a cada uno una medici�n en 3 momentos diferentes C1, C2 y C3

data2 <- read.csv("c:/Escomc/bedu_fase_2/Sesion3/boxp.csv")

# Revisamos el encabezado del fichero y el nombre de sus variables o columnas

head(data2)
names(data2)

# Vamos a realizar un cambio en la variable Mediciones para practicar

data <- mutate(data2, Mediciones = Mediciones*1.23)
head(data)
#view(data)

# Observamos algunos datos estad�sticos sobre las variables

summary(data)

# Como estamos ante la presencia de NA�s los eliminamos con complete.cases() y solamente seleccionamos aquellos sin NAsy convertimos en factores la variableCategoriayGrupo`

bien <- complete.cases(data)
data <- data[bien,]
data <- mutate(data, Categoria = factor(Categoria), Grupo = factor(Grupo))

# Finalmente realizamos el boxplot

ggplot(data, aes(x = Categoria, y = Mediciones, fill = Grupo)) + geom_boxplot() +
  ggtitle("Boxplots") +
  xlab("Categorias") +
  ylab("Mediciones")

# Agregamos el nombre de las etiquetas para los grupos G1 y G2

ggplot(data, aes(x = Categoria, y = Mediciones, fill = Grupo)) + geom_boxplot() +
  scale_fill_discrete(name = "Dos Gps", labels = c("G1", "G2")) + 
  ggtitle("Boxplots") +
  xlab("Categorias") +
  ylab("Mediciones")