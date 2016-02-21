library(shiny)
library(leaflet)
# Define UI for nursing home finder application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Find a Nursing Home Near You"),
    h4("This application takes your zip code as an input and the distance from that location you are willing to drive."),
    h4("Then as output it maps the nursing homes within the selected distance. The table gives the important data about those homes."),
    h4("Enter the zip code, choose a search radius, and then click Submit to populate the table and map."),
    h4("Please give the application a few seconds to load the data."),
    h4("The closest ten homes in your search radius are displayed."),
    h4("If you change either the zip code or search radius you must click Submit."),
    h4("If you use an non-existant zip code the application will display an error."),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("distance", "Maximum Distance in Miles:",
                   c(5,10,25,50),
                      selected = 5),
      br(),
      
      textInput("MyZipCode", 
                "Enter Your Zip Code:", 
                value = "01101"),
      submitButton("Check Zip Code")
    ),
    
    # Show a tabset that includes a plot and table view
    mainPanel(
      tabsetPanel(type = "tabs", 
                   tabPanel("Table", tableOutput("table"),
                           h3("Distance is from input Zip Code to the Nursing Home's Zip Code in miles."),
                           h3("Quality ratings are from 1 to 5 with 5 being the highest.")),
                  tabPanel("Map", leafletOutput("map"),
                           h3("Click on the markers to see the Nursing Home Names."),
                           h3("The red circle is your entered Zip Code."),
                           h4("Use either your mouse or the map controls to zoom."),
                           h4("Use your mouse to pan around the map."))
                    
      )
    )
  )
))