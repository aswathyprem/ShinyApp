library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Panama Search"),
  
  # Sidebar with controls to provide a search box, and links to display data from rpanama,
  
  sidebarLayout(
    sidebarPanel(
      textInput("keyword", "Search for stories", "Data Summary"),
      
      actionLink("countries", "Show invloved countries"),
      br(),
      br(),
      actionLink("companies", "Show involved companies"),
      br(),
      br(),
      actionLink("people", "Show involved people")
      
    ),
    
    
  
    mainPanel(
      #displays the keyword searched
      h3(textOutput("keyword", container = span)),
      
      #Displays data for the keyword
      verbatimTextOutput("summary"), 
      
      #Displays data based on the links clicked
      tableOutput("view")
      
    )
    
  )
))
