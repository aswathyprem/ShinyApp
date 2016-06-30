library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Panama Search"),
  
  # Sidebar with controls to provide a search box, and links to display data from rpanama,
  
  sidebarLayout(
    sidebarPanel(
      textInput("keyword", "Search for stories", NULL),
      
      
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
      #displays the keyword searched
      
      h3(textOutput("keyword", container = span)),
      
      #Display the tabular output
      tabsetPanel(type = "tabs", 
                  
                  tabPanel("Summary", verbatimTextOutput("summary")), 
                  tabPanel("Table", tableOutput("view")),
                  tabPanel("Plot", plotOutput("plot")) 
      )
      
      
      #verbatimTextOutput("summary"), 
      
      #tableOutput("view")
      
    )
    
  )
))
