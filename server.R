library(shiny)
library(rpanama)


library("Rgraphviz")
setwd("D:/Study/R/Reactive/Reactive/")

graph <- read.csv("D:/Study/R/Reactive/Reactive/data/graphy.csv")
graph<-graph[-1]

panama <- read.csv("D:/Study/R/Reactive/Reactive/data/en.csv",stringsAsFactors = TRUE)
panama$id<-as.factor(panama$id)
# Define server logic required to summarize and view the selected
# dataset
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
    #Entities[grep(input$keyword,rownames(Entities)),]
    panama[grep(input$keyword,panama$text,ignore.case = TRUE),3]
    
  })
  
  # The output$view depends on both the actionLink clicked in reactive
  # expression, number of items set to 100
  
  output$view <- renderTable({
    head(unique(v$data), n=100)
  })
  
  output$plot <- renderPlot(
    
    {
      
      subpanama<-as.data.frame(panama[grep(input$keyword,panama$text,ignore.case = TRUE),])
      
      ids<-as.character(unique(subpanama$id))
      
      newrow<-c()
      for (id in ids)
      {
        tempana<-panama[panama$id==id,]
        temp<-as.character(tempana[grep("data-person-1-viz-publish",tempana$fieldname,ignore.case = TRUE),3])
        newrow<-c(newrow,temp)
      }
      
      
      story_id <- newrow[1]
      
      story <- graph[grep(paste0("viz-data/",story_id,".json"),graph$filename),]
      story[] <- lapply(story, as.character)
      
      nodenames <- c(story$node1,story$node2)
      
      Attrs<-list(graph=list(),node=list(fontcolor="red",fontsize="20",fixedsize=FALSE),edge=list(color="blue",fontcolor="black",fontsize="20",minlen="4"))
      eAttrs <- list()
      edgelist<-c()
      story_graph <- new("graphNEL", nodes=unique(nodenames),edgemode="directed")
      for (i in seq(1,nrow(story),by=1)) {
        row <- story[i,]
        story_graph <- addEdge(row$node1,row$node2, story_graph, 1)
        edgelabel <- row$edge
        names(edgelabel) <- paste0(row$node1,"~",row$node2)
        edgelist<-c(edgelist,edgelabel)
      }
      eAttrs$label <- edgelist
      
      
      
      plot(story_graph,attrs=Attrs,edgeAttrs=eAttrs,"dot")
    }
  )
})
