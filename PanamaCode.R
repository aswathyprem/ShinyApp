panama <- read.csv(file="panama-papers-dataset-2016-master/en.csv",head=TRUE,sep=",")
# Remove meta information (id=X)
panama <- subset(panama,id!="X")

# Remove certain fieldname rows: data-person-[1,2,3...]-image
# data-person-[1,2,3...]-viz-publish
# story-image-if-linked-person
# linked-perosn-image
# story-priority
# story-region-codes
# story-category-code

for (N in seq(1,9)) {
  en <- subset(en,fieldname!=paste0(c("data-person-"),c(N),c("-image")))
  en <- subset(en,fieldname!=paste0(c("data-person-"),c(N),c("-viz-publish")))
}

en <- subset(en,fieldname!="story-image-if-linked-person")
en <- subset(en,fieldname!="linked-person-image")
en <- subset(en,fieldname!="story-priority")
en <- subset(en,fieldname!="story-region-codes")
en <- subset(en,fieldname!="story-category-code")

