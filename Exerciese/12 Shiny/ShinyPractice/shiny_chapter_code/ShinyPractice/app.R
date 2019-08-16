
library(shiny)

names.df <- read.csv("http://blue.for.msu.edu/FOR875/data/name_list.csv")

# Define UI
ui <- fluidPage(
  titlePanel("Random Names Age Analysis"),
  sidebarLayout(
    sidebarPanel(
      # Dropdown selection for Male/Female
      selectInput(inputId = "sexInput", label = "Sex:",
                  choices = c("Female" = "F", 
                              "Male" = "M", 
                              "Both" = "B"))
    ),
    mainPanel(plotOutput("histogram"))
  )
)

# Define server logic
server <- function(input, output) {

  output$histogram <- renderPlot({

    if(input$sexInput != "B"){
      subset.names.df <- subset(names.df, Sex == input$sexInput)
    } else {
      subset.names.df <- names.df
    }
    
    ages <- subset.names.df$Age
    
    # draw the histogram with the specified 20 bins
    hist(ages, col = 'darkgray', border = 'white')
  })

}

# Create Shiny app
shinyApp(ui = ui, server = server)
