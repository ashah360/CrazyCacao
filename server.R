#
# server function for chocolate rating shiny app
#

library(shiny)
library(ggplot2)
library(dplyr)
source("facts.R")

# read in csv from current directory (the directory this file is in)
chocolate <- read.csv("./flavors_of_cacao.csv", header = TRUE, stringsAsFactors = FALSE, fileEncoding="UTF-8")

# removing data columns that aren't meaningful to our app
chocolate$Specific.Bean.Origin.or.Bar.Name <- NULL
chocolate$REF <- NULL
chocolate$Review.Date <- NULL
chocolate$Bean.Type <- NULL

# Define server logic required to draw table 
shinyServer(function(input, output) {
  
  # Generate random cacao fact from action button
  fact <- eventReactive(input$factButton, {
    generateFact()
  })
  
  output$randomFact <- renderText({
    if (is.null(input$factButton) || input$factButton == 0) {
      generateFact()
    }
    else {
      fact()
    }
  })
  

  # Tab 2 table output
  output$table <- renderDataTable({
    data <- chocolate
    
    # function to change Cocoa.Percent from a vector of strings to a vector of intergers
    f <- function(x) {
      substring(x, 1, nchar(x)-1)
    }
    n <- lapply(data$Cocoa.Percent, f)
    n <- as.integer(n)
    
    # filtering for input cocoa percent range
    b1 <- n >= input$cocao[1] 
    b2 <- n <= input$cocao[2]
    data <- filter(data, b1 & b2)
    
    # filtering if there is a perferred bean origin
    if (input$beanorigin != "No Preference") {
      data <- filter(data, Broad.Bean.Origin == input$beanorigin)
    }
    
    # filtering for company location if given
    if (input$country != "Any") {
      data <- filter(data, Company.Location == input$country)
    }
    
    # arranging data to have highest ratings at the top
    data <- arrange(data, desc(Rating))
  },
    # aesthetic and functional presentation of table
    options = list(orderClasses = TRUE,
                   # adjusts number of results displayed
                   lengthMenu = list(c(25,50,75,100,-1), c('25','50','75','100','All')),
                   pageLength = 25,
                   # renames column names from R interpretted gibberish
                   columns = list(
                     list(title = 'Company'),
                     list(title = 'Cocoa Percent'),
                     list(title = 'Location'),
                     NULL,
                     list(title = 'Bean Origin')
                   ),
                   ordering = F
    )
  )
  
  # Tab 3 plot output
  output$distPlot <- renderPlot({
    # if else to select what variable is being chosen to be grouped by
    if(input$property == "Company") {
      # group by company
      relevant_data <- group_by(chocolate, Company..Maker.if.known.) 
      # summarise the rating
      rating_mean <- summarise(relevant_data, mean_rating = mean(Rating)) %>% arrange(desc(mean_rating))  
      # taking the top 10
      rating_mean <- head(rating_mean, 10) 
      # plotting property chosen to rating, adjusting x scale so it's readable, aesthetic adjustments for clarity 
      ggplot(rating_mean, aes(Company..Maker.if.known., mean_rating)) + 
        geom_col(aes(fill = Company..Maker.if.known.)) + 
        geom_text(aes(Company..Maker.if.known., mean_rating, label=round(mean_rating, digits=2)), vjust = 2, color = "white") +
        labs(title = paste("Top Ten Cacao by", input$property), x = input$property, y = "Rating") +
        theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
        theme(legend.position="none")
    } else if(input$property == "Location") {
      # group by location
      relevant_data <- group_by(chocolate, Company.Location)
      # summarise the rating
      rating_mean <- summarise(relevant_data, mean_rating = mean(Rating)) %>% arrange(desc(mean_rating))    
      # taking the top 10
      rating_mean <- head(rating_mean, 10)
      # plotting property chosen to rating, adjusting x scale so it's readable, aesthetic adjustments for clarity
      ggplot(rating_mean, aes(Company.Location, mean_rating)) + 
        geom_col(aes(fill = Company.Location)) + 
        geom_text(aes(Company.Location, mean_rating, label=round(mean_rating, digits=2)), vjust = 2, color = "white") +
        labs(title = paste("Top Ten Cacao by", input$property), x = input$property, y = "Rating") + 
        theme(axis.text.x = element_text(angle = 60, hjust = 1)) + 
        theme(legend.position="none")
    } else if(input$property == "Cocoa Percent") {
      # group by cocoa percent
      relevant_data <- group_by(chocolate, Cocoa.Percent)
      # summarise the rating
      rating_mean <- summarise(relevant_data, mean_rating = mean(Rating)) %>% arrange(desc(mean_rating))    
      # taking the top 10
      rating_mean <- head(rating_mean, 10)
      # plotting property chosen to rating, aesthetic adjustments for clarity
      ggplot(rating_mean, aes(Cocoa.Percent, mean_rating)) + 
        geom_col(aes(fill = Cocoa.Percent)) + 
        geom_text(aes(Cocoa.Percent, mean_rating, label=round(mean_rating, digits=2)), vjust = 2, color = "white") +
        labs(title = paste("Top Ten Cacao by", input$property), x = input$property, y = "Rating") + 
        theme(legend.position="none")
    } else {
      # group by bean origin
      relevant_data <- group_by(chocolate, Broad.Bean.Origin)
      # summarise the rating
      rating_mean <- summarise(relevant_data, mean_rating = mean(Rating)) %>% arrange(desc(mean_rating))    
      # taking the top 10
      rating_mean <- head(rating_mean, 10)
      # plotting property chosen to rating, adjusting x scale so it's readable, aesthetic adjustments for clarity
      ggplot(rating_mean, aes(Broad.Bean.Origin, mean_rating)) + 
        geom_col(aes(fill = Broad.Bean.Origin)) + 
        geom_text(aes(Broad.Bean.Origin, mean_rating, label=round(mean_rating, digits=2)), vjust = 2, color = "white") +
        labs(title = paste("Top Ten Cacao by", input$property), x = input$property, y = "Rating") + 
        theme(axis.text.x = element_text(angle = 60, hjust = 1)) + 
        theme(legend.position="none")
    }
    
  })
  
})