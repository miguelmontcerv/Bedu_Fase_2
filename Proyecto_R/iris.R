library(dplyr)
library(tidyr)
library(reshape)
install.packages("reshape")


library(shiny)


shinyUI(fluidPage(
  
  iris <- iris[,-5]
  attach(iris)
  
  mc.iris <- cor(iris)
  
  mc.irism <- melt(mc.iris)
  
  library(ggplot2)
  
  mc.irism %>% ggplot(aes(X1, X2)) + 
    geom_tile(aes(fill = value)) + 
    scale_fill_gradient(low = 'green', high = 'red') + 
    theme(axis.text.x = element_text(angle = 90, hjust = 0))
  
  
)