# The Shiny integration of Score Visualizer Package

# import libraries
library(shiny)

# Defining the shiny server
server <- shinyServer(function(input, output) {
  observeEvent(input$generate, {
    # Retrieve Inputs from user
    inFileRef <- input$reference
    inFileCom <- input$compare
    userFileName <- input$filename

    if (is.null(inFileRef) || is.null(inFileCom)) {
      output$missingFile <- renderText({
        "Please upload required FASTA files!"
      })
      return(NULL)
    }
    
    scoreValues <- input$scores
    sumScore <- ("sum" %in% scoreValues)
    colScore <- ("col" %in% scoreValues)
    
    # Run ScoreVisualizer on input files
    ScoreVisualizer::ScoreVisualizer(inFileRef$datapath, inFileCom$datapath,
                    SP = sumScore, CS = colScore,
                    fileName = userFileName)
    
    output$success <- renderText({
      "Successfully generated the PDF!"
    })
    
    # Display the PDF file using pdfview
    addResourcePath("pdfs", system.file("ShinyApp/www", package = "ScoreVisualizer"))
    pdfFilePath <- paste("pdfs/",
                         userFileName, ".pdf",
                         sep = "")

    output$pdfview <- renderUI({
      tags$iframe(style="height:600px; width:100%", 
                  src = paste("pdfs/", userFileName, 
                        ".pdf",
                        sep = ""))
    })
  })
})
  

# Defining the UI interface
ui <- shinyUI(fluidPage(
  
  titlePanel("Score Visualizer"),
  
  sidebarLayout(
    
    # Panel options for user
    sidebarPanel(
      # Title of file input
      textInput("filename", "File Name:", "Result"),

      # Input: Select a reference fasta file 
      fileInput("reference", "Choose Reference Alignment FASTA File",
                multiple = TRUE,
                accept = c(".fasta")),
      
      # Input: Select a comparison fasta file
      fileInput("compare", "Choose Test Alignment FASTA File",
                multiple = TRUE,
                accept = c(".fasta")),
      
      checkboxGroupInput("scores", "Scores to show:",
                         c("Column Score" = "col",
                           "Sum-of-Pairs Score" = "sum")),
      
      actionButton("generate", "Generate PDF")
      
    ),
    
    # Main panel definitions
    mainPanel(
      textOutput("missingFile"),
      textOutput("success"),
      uiOutput("pdfview")
    )
  )
))

# Launching the app
shinyApp(ui = ui, server = server)


# [END]
