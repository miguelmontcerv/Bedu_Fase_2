#Reto 2

theurl <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(theurl) 

tables <- html_nodes(file, "table") 
table1 <- html_table(tables[1], fill = TRUE)
table <- na.omit(as.data.frame(table1))  

substr(table$Sueldo, star=4, stop=11)

table$Sueldo <- gsub("[^[:alnum:][:blank:]?]", "", table$Sueldo)
                  
table$Sueldo <- gsub(" [^[:alnum:][:blank:]?]", "", table$Sueldo)
[:punct:]
table$Sueldo <- as.numeric(table$Sueldo)
