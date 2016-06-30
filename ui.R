library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Panama Search"),
  
  # Sidebar with controls to provide a caption, select a dataset,
  # and specify the number of observations to view. Note that
  # changes made to the caption in the textInput control are
  # updated in the output area immediately as you type
  sidebarLayout(
    sidebarPanel(
      textInput("keyword", "Search for stories", "Data Summary"),
      
      #selectInput("dataset", "Choose a dataset:", 
      #choices = c("Companies", "Countries", "People")),
      
      #numericInput("obs", "Number of observations to view:", 10),
      
      actionLink("countries", "Show invloved countries"),
      br(),
      br(),
      actionLink("companies", "Show involved companies"),
      br(),
      br(),
      actionLink("people", "Show involved people")
      
    ),
    
    
    # Show the caption, a summary of the dataset and an HTML 
    # table with the requested number of observations
    mainPanel(
      h3(textOutput("keyword", container = span)),
      
      verbatimTextOutput("summary"), 
      
      tableOutput("view")
      
    )
    
  )
))