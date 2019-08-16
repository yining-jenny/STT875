# app.R
# CampsitesMI - Leaflet

library(shiny)
library(leaflet)
library(htmltools)

sites <- read.csv("Michigan_State_Park_Campgrounds.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Michigan Campsite Search"),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      # slider input for number of campsites
      sliderInput("rangeNum",
                  label = "Number of campsites:",
                  min = 0,
                  max = 420,
                  value = c(0,420),
                  step=20
      ),
      
      selectInput("type",
                  label = "Type of campsites:",
                  levels(sites$Camp_type)
      ),
      
      checkboxInput("ada",
                    label = "ADA Sites Available:",
                    FALSE)
      
      
    ),
    
    
    mainPanel(
      # Show the map of campgrounds
      leafletOutput("plot1"),
      br(),
      # Show the text list of campgrounds
      htmlOutput("text1")
    )
  )
)


server <- function(input, output) {
  sites <- read.csv("Michigan_State_Park_Campgrounds.csv")
  
  output$text1 <- renderText({
    # create a subset of campsites based on inputs
    sites1 <- subset(sites, 
                     TOTAL_SITE >= input$rangeNum[1] & 
                       TOTAL_SITE <= input$rangeNum[2] &
                       Camp_type == input$type &
                       if(input$ada){ ADA_SITES > 0 } else {ADA_SITES >= 0})
    # create an HTML-formatted character string to be output
    outStr <- "<ul>"
    for(site in sites1$FACILITY){
      outStr <- paste0(outStr,"<li>",site,"</li>")
    }
    outStr <- paste0(outStr,"</ul>")
    
    # 
    paste("<p>There are",
          nrow(sites1), 
          "campgrounds that match your search:</p>", 
          outStr)
    
  })
  
  output$plot1 <- renderLeaflet({
    # create a subset of campsites based on inputs
    sites1 <- subset(sites, 
                     TOTAL_SITE >= input$rangeNum[1] &
                       TOTAL_SITE <= input$rangeNum[2] &
                       Camp_type == input$type &
                       if(input$ada){ ADA_SITES > 0 } else {ADA_SITES >= 0})
    
    if(nrow(sites1) > 0){
      leaflet(sites1) %>% addTiles()  %>% 
        addCircleMarkers(lng = ~Long, lat = ~Lat, 
                         radius = 5,
                         color = "red",
                         label = mapply(function(x,y) {
                           HTML(sprintf('<em>%s</em><br>%s site(s)', 
                                        htmlEscape(x), 
                                        htmlEscape(y)))}, 
                           sites1$FACILITY,sites1$TOTAL_SITE, SIMPLIFY = F)
        )
    } else {
      leaflet() %>% addTiles() %>%
        setView( -84.5555, 42.7325,   zoom = 7)
    }
    
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
