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
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # NOMBRE DE LA APLICACIÓN
    titlePanel(h1("Proyecto Equipo 1.", align = "center", 
                  style = {"color: red "})),

    # Sidebar with a slider input for number of bins 
    sidebarPanel(p("Promedio de Solteros "),
                 selectInput("x", "SELECCIONE EL AÑO",
                             c("PROMEDIO 2015", "PROMEDIO 2020"))
    ),
    
    mainPanel(
        
        tabsetPanel(
            tabPanel("Gráficas Senso 2015", h3(textOutput("output_text")),
                     plotOutput("output_plot")),
            
            tabPanel("Gráficas Senso 2020", h3(textOutput("output_text1")),
                     plotOutput("output_plot1")),
            tabPanel("Regresiones Líneales", 
                     img(src = "regresiónLineal1.png", height = 500),
                     img(src = "regresión.png", height = 500)
            ),
            
            tabPanel("Resumen Tab General", verbatimTextOutput("summary")),
            tabPanel("Resumen Tabla de Senso 2015", verbatimTextOutput("summ15")),
            tabPanel(" Resumen Tabla de Senso 2020", verbatimTextOutput("summ20")),
            tabPanel("Table", tableOutput("table")),
            tabPanel("Data Table", dataTableOutput("data_table"))
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    datosINEGI <- read.csv("datosINEGI.csv")
    promedio2015 <- read.csv("promedio2015.csv")
    promedio2020 <- read.csv("promedio2020.csv")
    divorcios <- read.csv("divorcios.csv")
    
    output$output_plot <- renderPlot({
        
        if(input$x == "PROMEDIO 2015")
        {
            ggplot(promedio2015, aes(x = media2015, y = desc_entidad, 
                                     fill = factor(desc_entidad))) +
                geom_bar(stat = "identity") +
                ggtitle(" PORCENTAJE DE SOLTEROS EN EL 2015") +
                xlab(" PORCENTAJE DE SOLTEROS ") + 
                ylab(" ENTIDADES") +
                theme_light()
        }
        else
        {
            ggplot(promedio2015, aes(x = media2020, y = desc_entidad, 
                                     fill = factor(desc_entidad))) +
                geom_bar(stat = "identity") +
                ggtitle(" PORCENTAJE DE SOLTEROS EN EL 2020") +
                xlab(" PORCENTAJE DE SOLTEROS ") + 
                ylab(" ENTIDADES")
        }
            
    })
    
    output$output_plot1 <- renderPlot({
        
        if(input$x == "PROMEDIO 2015")
        {
            ggplot(promedio2020, aes(x = media2015, y = desc_entidad, 
                                     fill = factor(desc_entidad))) +
                geom_bar(stat = "identity") +
                ggtitle(" PORCENTAJE DE SOLTEROS EN EL 2015") +
                xlab(" PORCENTAJE DE SOLTEROS ") + 
                ylab(" ENTIDADES") +
                theme_light()
        }
        else
        {
            ggplot(promedio2020, aes(x = media2020, y = desc_entidad, 
                                     fill = factor(desc_entidad))) +
                geom_bar(stat = "identity") +
                ggtitle(" PORCENTAJE DE SOLTEROS EN EL 2020") +
                xlab(" PORCENTAJE DE SOLTEROS ") + 
                ylab(" ENTIDADES")
        }
        
    })
    
    output$summary <- renderPrint( {summary(datosINEGI)} )
    output$summ15 <- renderPrint( {summary(promedio2015)} )
    output$summ20 <- renderPrint( {summary(promedio2020)} )
    
    output$table <- renderTable( {data.frame(datosINEGI)} )
    
    output$data_table <- renderDataTable( {datosINEGI}, 
                                          options = list(lengthMenu = c(10,20,50),
                                                         iDisplayLoutpength = 15))
}

# Run the application 
shinyApp(ui = ui, server = server)
