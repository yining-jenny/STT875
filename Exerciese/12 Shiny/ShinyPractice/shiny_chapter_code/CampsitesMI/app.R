# app.R
# CampsitesMI

library(shiny)
library(maps)
library(ggplot2)

sites <- read.csv("http://blue.for.msu.edu/FOR875/data/Michigan_State_Park_Campgrounds.csv")

ui <- fluidPage(
  
  titlePanel("Michigan Campsite Search"),
  
  sidebarLayout(
    sidebarPanel(
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
      plotOutput("plot1"),
      br(),
      htmlOutput("text1")
    )
  )
)

server <- function(input, output) {
  
  output$text1 <- renderText({
    
    sites1 <- subset(sites, 
                     TOTAL_SITE >= input$rangeNum[1] & 
                       TOTAL_SITE <= input$rangeNum[2] &
                       Camp_type == input$type &
                       if(input$ada){ ADA_SITES > 0 } else {ADA_SITES >= 0})
    
    if(nrow(sites1) > 0){
      outStr <- "<ul>"
      for(site in sites1$FACILITY){
        outStr <- paste0(outStr,"<li>",site,"</li>")
      }
      outStr <- paste0(outStr,"</ul>")
    } else {
      outStr <- ""
    }
    
    paste("<p>There are",
          nrow(sites1), 
          "campgrounds that match your search:</p>", 
          outStr)
    
  })
  
  output$plot1 <- renderPlot({
    sites1 <- subset(sites, 
                     TOTAL_SITE >= input$rangeNum[1] &
                       TOTAL_SITE <= input$rangeNum[2] &
                       Camp_type == input$type &
                       if(input$ada){ ADA_SITES > 0 } else {ADA_SITES >= 0})
    
    miMap <- map_data("state", region = "michigan")
    plt <- ggplot() +
      geom_polygon(data=miMap, aes(x=long,y=lat,group=group), colour="black", fill="gray") +
      coord_fixed(ratio = 1)
    
    if(nrow(sites1) > 0){
      plt <- plt + geom_point(data = sites1,aes(x=Long,y=Lat), colour="red")
    } 
    
    plot(plt)
    
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
