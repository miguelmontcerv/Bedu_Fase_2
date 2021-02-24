#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(shinydashboard)
library(shinythemes)
library(dplyr)

ui <- fluidPage (
    
    titlePanel("Postwork Sesión 8"),
    sidebarPanel(p("GOLES ANOTADOS"), 
        selectInput("x", "SELECCIÓN DE GRÁFICA", 
                    c("LOCAL", "VISITANTE"))
    ),
    
    mainPanel(
        
        tabsetPanel(
            tabPanel("Gráficas",
                     h3(textOutput("output_text")), 
                     plotOutput("output_plot"),
            ),
            
            tabPanel("Gráficas de goles",
                     img( src = "GolCasa.png", height = 400),
                     img( src = "GolVisita.png", height = 400),
                     img( src = "GolConjunta.png", height = 400)
            ),
            
            tabPanel("Data Table", dataTableOutput("data_table")),
            
            tabPanel("Factores de ganancias", 
                     img( src = "FactorGanMa.png", height = 400),
                     img( src = "FactorGanMin.png", hheight = 400)
                     
            )
        )
    )
)


server <- function(input, output) {
    
    match.data <- read.csv("match.data.csv")
    
    output$output_text <- renderText(paste("Goles del equipo ", 
                                           input$x, " Goles visitante"))
    
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
        
    })
    
    output$data_table <- renderDataTable({match.data},
                                         options = list(lengthMenu = c(50,70,100),
                                                        iDisplayLength = 30))
}

shinyApp(ui, server)