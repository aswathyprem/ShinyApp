library(jsonlite)
library(plyr)

setwd("~/Desktop/panama-papers-dataset-2016-master/")

graph <- data.frame(filename=as.character(),node1=as.character(),edge=as.character(),node2=as.character())

#colnames(graph)<-c("node1","edge","node2")
jsonfiles <- Sys.glob("viz-data/*.json")

jsonlist <- vector("list", length(jsonfiles))
nodes <- data.frame()
edges <- data.frame()

i <- 1
filenames_nodes<-c()
filenames_edges<-c()
for (file in jsonfiles) {
  jsonlist[[i]] <- fromJSON(txt=file, flatten=TRUE)
  temp <- jsonlist[[i]]

  if (nrow(nodes)==0) {
    nodes <- as.data.frame(temp[[1]])
    filenames_nodes<-append(filenames_nodes,rep_len(file,nrow(temp[[1]])))
  }
  else {
    nodes <- rbind.fill(nodes,temp[[1]])
    filenames_nodes<-append(filenames_nodes,rep_len(file,nrow(temp[[1]])))
  }
  
  if (nrow(edges)==0) {
    edges <- as.data.frame(temp[[2]])
    filenames_edges<-append(filenames_edges,rep_len(file,nrow(temp[[2]])))
  }
  else {
    edges <- rbind.fill(edges,temp[[2]])
    filenames_edges<-append(filenames_edges,rep_len(file,nrow(temp[[2]])))
  }
  
  i <- i + 1
}

nodes<-cbind(json=filenames_nodes,nodes)
#nodes <- nodes[1:10,]
edges<-cbind(json=filenames_edges,edges)
#edges <- edges[1:10,]

for (i in seq(1,nrow(nodes),by=1)) {
  row_node_source <- nodes[i,]
  for (j in seq(1,nrow(edges),by=1)) {
    row_edge <- edges[j,]
    if (row_node_source$id == row_edge$source) {
      for (k in seq(1,nrow(nodes),by=1)) {
        row_node_target <- nodes[k,]
        if (row_node_target$id == row_edge$target) {
          row <- data.frame(filename=row_node_source$json,node1=row_node_source$label,edge=row_edge$label,node2=row_node_target$label)
#          colnames(graph)<-c("node1","edge","node2")
          graph <- rbind(graph,row)
        }
      }
    }
  }
}

write.csv(graph,"graphy.csv")