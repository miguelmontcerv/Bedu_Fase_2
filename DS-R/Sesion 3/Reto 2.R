# Desarrollo

# Realizamos un scatter plot de las variables wt y mpg, debemos utilizar necesariamente geom_point()

(my_scatplot <- ggplot(mtcars, 
                       aes(x = wt, y = mpg)) + 
  geom_point())

# Adicionalmente se puede agregar una l�nea de tendencia

(my_scatplot <- ggplot(mtcars, 
                       aes(x=wt,y=mpg)) + 
    geom_point() + 
    geom_smooth(method = "lm", se = F))  # modelo lineal, cambia el parametro `se`, este hace referencia al intervalo de confianza

# Agregando los nombres de los ejes, observa que se almacen� el gr�fico en el objeto my_scatplot (nota que pueden agregarse m�s caracter�sticas seguido del signo +)

my_scatplot + xlab('Weight (x 1000lbs)') + ylab('Miles per Gallon')

# Otras caracter�sticas interesantes

(my_scatplot <- ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) + geom_point())
my_scatplot + labs(x='Weight (x1000lbs)',y='Miles per Gallon',colour='Number of\n Cylinders')

# Haciendo un facewrap con la variable cyl

my_scatplot + facet_wrap("am")

# Separ�ndolas por tipo de transmisi�n (am = Transmission (0 = automatic, 1 = manual))

my_scatplot + facet_grid(am~cyl)

# Como puedes observar, hay muchas formas de representar el gr�fico de dispersi�n, �stas son algunas de ellas, obviamente existen muchas m�s.# Desarrollo

# Realizamos un scatter plot de las variables wt y mpg, debemos utilizar necesariamente geom_point()

(my_scatplot <- ggplot(mtcars, 
                       aes(x = wt, y = mpg)) + 
    geom_point())

# Adicionalmente se puede agregar una l�nea de tendencia

(my_scatplot <- ggplot(mtcars, 
                       aes(x=wt,y=mpg)) + 
    geom_point() + 
    geom_smooth(method = "lm", se = T))  # modelo lineal, cambia el parametro `se`, este hace referencia al intervalo de confianza

# Agregando los nombres de los ejes, observa que se almacen� el gr�fico en el objeto my_scatplot (nota que pueden agregarse m�s caracter�sticas seguido del signo +)

my_scatplot + xlab('Weight (x 1000lbs)') + ylab('Miles per Gallon')

# Otras caracter�sticas interesantes

(my_scatplot <- ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) + geom_point())
my_scatplot + labs(x='Weight (x1000lbs)',y='Miles per Gallon',colour='Number of\n Cylinders')

# Haciendo un facewrap con la variable cyl

my_scatplot + facet_wrap("cyl")

# Separ�ndolas por tipo de transmisi�n (am = Transmission (0 = automatic, 1 = manual))

my_scatplot + facet_grid(am~cyl)

# Como puedes observar, hay muchas formas de representar el gr�fico de dispersi�n, �stas son algunas de ellas, obviamente existen muchas m�s.