library(shiny)
library(datasets)

# Define server logic required to summarize and view the selected
# dataset
shinyServer(function(input, output) {
  
  v <- reactiveValues(data = NULL)
  
  observeEvent(input$countries,{
    v$data <- Entities[17]
  })
  
  observeEvent(input$companies,{
    
    v$data <- Entities[1]
    
  })
  
  observeEvent(input$people,{
    
    v$data <- Officers[1]
    
  })
  
  # The output$caption is computed based on a reactive expression
  # that returns input$caption. When the user changes the
  # "caption" field:
  #
  #  1) This function is automatically called to recompute the 
  #     output 
  #  2) The new caption is pushed back to the browser for 
  #     re-display
  # 
  # Note that because the data-oriented reactive expressions
  # below don't depend on input$keyword, those expressions are
  # NOT called when input$caption changes.
  output$keyword <- renderText({
    input$keyword
  })
  
  # The output$summary depends on the serch keyword in reactive
  # expression, so will be re-executed whenever keyword is
  # invalidated
  # (i.e. whenever the input$keyword changes)
  output$summary <- renderPrint({
    Entities[grep(input$keyword,rownames(Entities)),]
  })
  
  # The output$view depends on both the databaseInput reactive
  # expression, number of items set to 100
  
  output$view <- renderTable({
    head(unique(v$data), n=100)
  })
  
})