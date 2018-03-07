library(shiny)
library(markdown)
source("facts.R")

shinyUI(fluidPage(theme="style.css",
                  
  headerPanel(title=div(img(src="cocoa.png"), "Crazy Cacao"), windowTitle = "Crazy Cacao"),
  
  headerPanel(""),
  headerPanel(""),
  headerPanel(""),
  headerPanel(""),
  headerPanel(""),
  
  sidebarPanel(
    
    conditionalPanel(condition="input.selectedtab==1",
                     tags$div(class="cntr-head", h3("Did You Know?"),
                      class="cntr-head", h5(textOutput("randomFact"))),
                     tags$div(class="cntr", 
                     actionButton("factButton", label = "Generate New Fact", icon=icon("retweet", lib="font-awesome")))),
    conditionalPanel(condition="input.selectedtab==2",
                     h4("Top Rated Cacao Companies"),
                     sliderInput(inputId = "cocao", label = "Cocoa Percentage Range",
                                 min = 40, max = 100, value = c(60, 80)),
                     selectInput("beanorigin", "Bean Origin Preference",
                                 choices = list("No Preference"="No Preference","Australia"="Australia","Belize"="Belize","Bolivia"="Bolivia","Brazil"="Brazil","Burma"="Burma","Cameroon"="Cameroon",
                                                "Carribean"="Carribean","Colombia"="Colombia","Congo"="Congo","Costa Rica"="Costa Rica","Cuba"="Cuba","Dominican Republic"="Dominican Republic",
                                                "Ecuador"="Ecuador","El Salvador"="El Salvador","Fiji"="Fiji","Gabon"="Gabon","Ghana"="Ghana","Grenada"="Grenada","Guatemala"="Guatemala",
                                                "Haiti"="Haiti","Hawaii"="Hawaii","Honduras"="Honduras","India"="India","Indonesia"="Indonesia","Ivory Coast"="Ivory Coast","Jamaica"="Jamaica",
                                                "Liberia"="Liberia","Madagascar"="Madagascar","Malaysia"="Malaysia","Martinique"="Martinique","Mexico"="Mexico","Nicaragua"="Nicaragua","Peru"="Peru",
                                                "Philippines"="Philippines","PNG"="PNG","Principe"="Principe","Puerto Rico"="Puerto Rico","Samoa"="Samoa","Sao Tome"="Sao Tome","Solomon Islands"="Solomon Islands",
                                                "South America"="South America","Sri Lanka"="Sri Lanka","St. Lucia"="St. Lucia","Suriname"="Suriname","Tanzania"="Tanzania","Tobago"="Tobago","Togo"="Togo","Trinidad"="Trinidad",
                                                "Uganda"="Uganda","Vanuatu"="Vanuatu","Venezuela"="Venezuela","Vietnam"="Vietnam","West Africa"="West Africa"), selected = "No Preference"),
                     selectInput("country", "Preferred Cacao Company Location",
                                        choices =  list("Any"="Any","Brazil"="Brazil","Canada"="Canada","Chile"="Chile","Colombia"="Colombia","Costa Rica"="Costa Rica",
                                                        "Czech Republic"="Czech Republic","Denmark"="Denmark","Domincan Republic"="Domincan Republic",
                                                        "Ecuador"="Ecuador","Fiji"="Fiji","Finland"="Finland","France"="France","Germany"="Germany",
                                                        "Ghana"="Ghana","Grenada"="Grenada","Guatemala"="Guatemala","Honduras"="Honduras","Hungary"="Hungary",
                                                        "Iceland"="Iceland","India"="India","Ireland"="Ireland","Israel"="Israel","Italy"="Italy","Japan"="Japan",
                                                        "Lithuania"="Lithuania","Madagascar"="Madagascar","Martinique"="Martinique","Mexico"="Mexico","Netherlands"="Netherlands",
                                                        "New Zealand"="New Zealand","Nicaragua"="Nicaragua","Peru"="Peru","Philippines"="Philippines","Poland"="Poland",
                                                        "Portugal"="Portugal","Puerto Rico"="Puerto Rico","Russia"="Russia","Sao Tome"="Sao Tome","Scotland"="Scotland",
                                                        "Singapore"="Singapore","South Africa"="South Africa","South Korea"="South Korea","Spain"="Spain","St. Lucia"="St. Lucia",
                                                        "Suriname"="Suriname","Sweden"="Sweden","Switzerland"="Switzerland","U.K."="U.K.","U.S.A."="U.S.A.",
                                                        "Venezuela"="Venezuela","Vietnam"="Vietnam","Wales"="Wales"), selected = "Any"),
                     includeMarkdown("www/tables.md")
    ),
    
    conditionalPanel(condition="input.selectedtab==3",
                     selectInput("property", label = "Choose a category to filter average ratings by",
                                 choices = list("Company"="Company", "Cocoa Percent"="Cocoa Percent", "Location"="Location",
                                                "Broad Bean Origin"="Broad Bean Origin"),
                                 selected = "Cocoa Percent"),
                     includeMarkdown("www/visualization.md")
    ),
    
    tags$div(class="shoutout-container",
             tags$div(class="team", p("Made with ")),
             tags$div(class="team", icon("heart", lib="font-awesome")),
             tags$div(class="team", p(" by Team SPAM")))
    
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Documentation", value=1, icon=icon("book", lib="font-awesome"), includeMarkdown("www/docs.md")),
      tabPanel("Rated Companies", value=2, icon=icon("table", lib="font-awesome"), dataTableOutput("table")),
      tabPanel("Cacao Visualizations", value=3, icon=icon("bar-chart-o", lib="font-awesome"), plotOutput("distPlot")), 
      id = "selectedtab"
      )
  )
))