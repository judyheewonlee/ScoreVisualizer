# import libraries
library(shiny)

#Defining the shiny server
server <- shinyServer(function(input, output) {
  
  #Import data
  #ScoreVisualizer()
  
  #Clean data
  
  server <- shinyServer(function(input, output) {
    
    observeEvent(input$generate, {
      output$pdfview <- renderUI({
        shiny::pdf("www/sampleOutput.pdf")
        hist(rnorm(100))
        dev.off()
        tags$iframe(style="height:600px; width:100%", src="www/sampleOutput.pdf")
      })
    })
  })
  
  # define any reactive elements of the app
  
  #Close the server definition
})


#Defining the UI interface
ui <- shinyUI(fluidPage(
  
  titlePanel("Score Visualizer"),
  
  sidebarLayout(
    
    #Panel options for user
    sidebarPanel(
      textInput("caption", "Caption:", "Data Summary"),

      selectInput("dataset1", "Choose a reference alignment method:",
                  choices = c("MUSCLE", "ClustalW", "ClustalOmega")),

      selectInput("dataset2", "Choose a test alignment method:",
                  choices = c("MUSCLE", "ClustalW", "ClustalOmega")),

      checkboxInput("columnScore", "Show column score", FALSE),

      checkboxInput("sumScore", "Show sum-of-pairs score", FALSE),
      
      actionButton("generate", "Generate PDF")
      
    ),
    
    #beginning of main section
    mainPanel(
      uiOutput("pdfview")
    )
  )
))

#generic line that launches the app
shinyApp(ui = ui, server = server)