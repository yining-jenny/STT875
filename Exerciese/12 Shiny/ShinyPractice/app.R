# title: app.R
# author: Yining Chen
# date: 8/14/2019

# CampsitesMI

library(shiny)
library(maps)
library(htmltools)
library(ggplot2)


sites <- read.csv("http://blue.for.msu.edu/FOR875/data/Michigan_State_Park_Campgrounds.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Michigan Campsite Search"),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      # specify a range of campsites desired in the campground
      sliderInput(inputId = "rangeNum",
                  label = "Number of campsites:",
                  min = 0,
                  max = 420,
                  value = c(0,420),
                  step=20
      ),
      
      # selcet type of campsites 
      selectInput(inputId = "type",
                  label = "Type of campsites:",
                  levels(sites$Camp_type)
      ),
      
      # see only compgroudns with ADA sites available
      checkboxInput(inputId = "ada",
                    label = "ADA Sites Available:",
                    FALSE
      ),
      
      # TODO 12.4: Add an additional search parameter of district checkboxes
      checkboxGroupInput(
        inputId = "district",
        label = "Choose district(s):", 
        choices = c("Baraga", "Bay City", "Cadillac", "Gaylord", "Plainwell", "Pontiac", "Roscommon", "Rose Lake"),
        selected = c("Baraga", "Bay City", "Cadillac", "Gaylord", "Plainwell", "Pontiac", "Roscommon", "Rose Lake")  
      )
    ),
    
    mainPanel(
      # Show the map of campgrounds
      plotOutput("plot1"),    
      br(),
      # Show the text list of campgrounds
      htmlOutput("text1")   
    )
  )
)

# Define server logic for Michigan Campgrounds
server <- function(input, output) {
  
  # create a character string of HTML code to print the bulleted list of available sites
  output$text1 <- renderText({
    # create a subset of campsites based on inputs
    sites1 <- subset(sites, 
                     TOTAL_SITE >= input$rangeNum[1] & 
                       TOTAL_SITE <= input$rangeNum[2] &
                       Camp_type == input$type &
                       if(input$ada){ ADA_SITES > 0 } else {ADA_SITES >= 0} & 
                       DISTRICT %in% input$district)
    
    # create an HTML-formatted character string to be output
    if(nrow(sites1) > 0){
      outStr <- "<ul>"
      # TODO 12.3: the number of sites is displayed after the campground name
      for(i in 1:nrow(sites1)){
        outStr <- paste0(outStr,"<li>",sites1$FACILITY[i], ": ", sites1$TOTAL_SITE[i], "</li>")
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
  
  
  # create a ggplot2 map of Michigan with campground markers
  output$plot1 <- renderPlot({
    # create a subset of campsites based on inputs
    sites1 <- subset(sites, 
                     TOTAL_SITE >= input$rangeNum[1] &
                       TOTAL_SITE <= input$rangeNum[2] &
                       Camp_type == input$type &
                       if(input$ada){ ADA_SITES > 0 } else {ADA_SITES >= 0})
    
    miMap <- map_data("state", region = "michigan")
    plt <- ggplot() +
      geom_polygon(data=miMap, aes(x=long,y=lat,group=group), colour="black", fill="gray") +
      coord_fixed(ratio = 1)
    
    # TODO 12.1& 12.2: update map output with marker sizes and colors
    if(nrow(sites1) > 0){
      plt <- plt + geom_point(data = sites1,aes(x=Long,y=Lat, color= COUNTY , size = TOTAL_SITE))
    } 
    
    plot(plt)
    
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
