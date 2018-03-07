Table

library(dplyr)

chocolate <- read.csv("./flavors_of_cacao.csv", header = TRUE, stringsAsFactors = FALSE)

# takes the character off the function



output$table <- renderTable({
  data <- chocolate
  f <- function(x) {
    substring(x, 1, nchar(x)-1)
  }
  n <- apply (data$cocao, 1, f)
  n <- as.integer(n)
  
  b1 <- (n >= input$cocoa[1]) 
  b2 <- (n <= input$cocoa[2])
  data <- data[b1 & b2]
  if (input$beanorigin != "NONE") {
    data <- filter(data, Broad.Bean.Origin == input$beanorigin)
  }
  if (input$company. != "NONE") {
    data <- filter(data, Company.Location == input$company)
  }
  data <- arrange(data, desc(Rating))
})


