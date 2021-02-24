#Repaso Sesion 1

#En R tenemos diferentes tipos de datos, algunos conocidos, otros no tanto
#Recuerda colocar entre parentesis para hacer plots
(cadena <- "Hola Mundo de R")
(entero <- 23L)
(vector <- c(1,6,7))

#Comandos para vectores
length(vector)
#para agregar elementos a un vector, se utiliza la concatenacion
(vector <- c(vector,34))
#se puede utilizar para agregar al inicio, final y juntar dos o más vectores

#Ordenamos un vector de forma DECRECIENTE
sort(vector, decreasing = T)
#Ordenamos un vector de forma CRECIENTE
sort(vector, decreasing = F)

#Para utilizar una lista de numeros utilizamos n:m, donde se llera de n hasta m, otro función para saltos es:
vector2 <- seq(from = 1, to = 10, by =2)
#En r podemos omitir la declaracion de parametros cuando conocemos las instancias a las que corresponden
(vector2 <- seq(1,100, 3))

#Podemos hacer repeticiones numericas, con el siguiente comando, regresa una lista o vector
(vector2 <- rep(vector, times = 3))


#Reciclaje, super importante 
(c(1, 2) + c(7, 8, 9, 10))
#Lo que esta haciendo es repetir el primer vector para sumarlo con el segundo, pero ojo, deben ser compatibles, si son 3 y 4 no funciona

#Matrices
(m <- matrix(1:9, nrow = 3, ncol = 3))
#Para visualizar cada elemento de una matriz, debemos recordar matriz[n,m] n = Fila, m = Columna
(m[1,2])
#Se puede visualizar toda una fila o toda una columna
(m[2,])
(m[,3])
#Se pueden sumar matrices con vectores
 #antes hacemos un vector de solo 3 elementos
vector <- c(34,12,64)
(suma.vecmat <- m + vector)
 #Empieza a sumar en la primer fila, columna por columna

#Se puede voltear la matriz con la traspuesta
(m)
(t(m))
#¿Cómo agregar una columna o fila a una matriz?