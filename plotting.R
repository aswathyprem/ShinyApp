library("Rgraphviz")
setwd("~/Desktop/panama-papers-dataset-2016-master/")

graph <- read.csv("graphy.csv")
graph<-graph[-1]

story_id <- "08cc5165"

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

