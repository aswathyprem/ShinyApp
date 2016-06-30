library(shiny)

# Define server logic required to summarize and view the selected
shinyServer(function(input, output) {
  
  v <- reactiveValues(data = NULL)
  
  # List the countries from rpanama dataset
  observeEvent(input$countries,{
    v$data <- Entities[17]
  })
  
  # List the companies from rpanama dataset
  observeEvent(input$companies,{
    
    v$data <- Entities[1]
    
  })
  
  # List the involved people from rpanam dataset
  observeEvent(input$people,{
    
    v$data <- Officers[1]
    
  })
  
 #output$keyword takes the input$keyword and displays the serach results
  output$keyword <- renderText({
    input$keyword
  })
  
 #output$summary takes the input$keyword and displays the serach results
  output$summary <- renderPrint({
    Entities[grep(input$keyword,rownames(Entities)),]
  })
  
  # The output$view depends on both the actionLink clicked in reactive
  # expression, number of items set to 100
  
  output$view <- renderTable({
    head(unique(v$data), n=100)
  })
  
})
