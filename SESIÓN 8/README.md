# POSTWORK 8
## CONTENIDO
1. [DESARROLLO](#desarrollo)
2. [RESULTADOS](#resultados)
#### DESARROLLO

Para este postwork genera un dashboar en un solo archivo `app.R`, para esto realiza lo siguiente: 

- Ejecuta el código `momios.R`

- Almacena los gráficos resultantes en formato `png` 

- Crea un dashboard donde se muestren los resultados con 4 pestañas:
   
- Una con las gráficas de barras, donde en el eje de las x se muestren los goles de local y visitante con un menu de selección, con una geometria de tipo barras además de hacer un facet_wrap con el equipo visitante
   
- Realiza una pestaña donde agregues las imágenes de las gráficas del postwork 3
    
- En otra pestaña coloca el data table del fichero `match.data.csv` 
    
- Por último en otra pestaña agrega las imágenes de las gráficas de los factores de ganancia mínimo y máximo

Nota: recuerda que si tienes problemas con el codificado guarda tu archivo `app.R` con la codificacion `UTF-8`

### RESULTADOS
Después de ejecutar el archivo `momios.R` y obtener las gráficas, nos vamos a la gración de nuestro dashboard.

Vamos a crear las pestañas, para las gráficas de barras, las imágenes de `Postwork 3`, las obtenidas anteriormente y el `Data Table`

```R

titlePanel("Postwork Sesión 8"), #NOMBRE DEL DASHBOARD
    sidebarPanel(p("GOLES ANOTADOS"), 
        selectInput("x", "SELECCIÓN DE GRÁFICA", 
                    c("LOCAL", "VISITANTE"))
    ),
    
    mainPanel(
        
        tabsetPanel(
            tabPanel("Gráficas", # NOMBRE DE LA PESTAÑA QUE CONTENDRA LAS GRÁFICAS
                     h3(textOutput("output_text")), 
                     plotOutput("output_plot"),
            ),
            
            tabPanel("Gráficas de goles", # NOMBRE DE LA PESTAÑA QUE CONTIENE LAS IMGS DEL POSTWORK 3
                     img( src = "GolCasa.png", height = 400),
                     img( src = "GolVisita.png", height = 400),
                     img( src = "GolConjunta.png", height = 400)
            ),
            
            tabPanel("Data Table", dataTableOutput("data_table")), # NOMBRE DE LA PESTAÑA QUE TENDRÁ EL DATA TABLE
            
            tabPanel("Factores de ganancias", # NOMBRE DE LA PESTAÑA QUE TENDRÁN LAS IMÁGENES QUE SE OBTUVIERON CON EL ARCHIVO MIMIOS.R
                     img( src = "FactorGanMa.png", height = 400),
                     img( src = "FactorGanMin.png", hheight = 400)
                     
            )
```
NOTA: Todo esté código va en el apartado de `ui`.

Para poder mostrar la información restante, que sería el `DATA TABLE` y las `GRÁFICAS`, dentro del `server`, vamos a generarlos, usando las variables que se han creado arriba.

```R
match.data <- read.csv("match.data.csv") # LEEMOS EL DATAFRAME 
    
    output$output_text <- renderText(paste("Goles del equipo ", 
                                           input$x, " Goles visitante")) # GENERAMOS TEXTO DE SALIDA, QUE APARECERÁ EN CADA GRÁFICA
    
    output$output_plot <- renderPlot({
        if (input$x == "Local") {
            ggplot(match.data, aes(home.score)) + geom_bar() + 
                facet_wrap(~ away.team) +
                xlab(paste("Goles por partido de equipo ", input$x)) +
                ylab("GOLES TOTALES")
        }
        else{
            ggplot(match.data, aes(away.score)) + geom_bar() + 
                facet_wrap(~ away.team) +
                xlab(paste("GOLES POR PARTIDO DE EQUIPO ", input$x)) +
                ylab("GOLES TOTALES")
        }
        
    }) # COMO SE GENERO UN `sidebarPanel`, VAMOS A COMPRAR LA OPCIÓN QUE SE ELIGE PARA QUE AL MOMENTO DE GENERAR LA GRÁFICA, NOS ARROJE LA CORRECTA,
       # EN ESTE CASO, LAS DOS OPCIONES POSIBLES SON `GRÁFICA PARA LOCAL` Y `GRÁFICA PARA VISITANTE`
    
    # A CONTINUACIÓN, MANDAMOS LLAMAR EL DF Y ELEGIMOS CANTIDAD DE DATOS QUE APARECERÁN EN PANTALLA
    output$data_table <- renderDataTable({match.data},
                                         options = list(lengthMenu = c(50,70,100),
                                                        iDisplayLength = 30)) 
```

