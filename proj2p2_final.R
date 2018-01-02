init <- function() {
  #install.packages("mclust") # rand index
  #install.packages("rgl") # scatterplot
  #install.packages("car") # scatterplot
  #install.packages("factoextra") # scatterplot
  #install.packages("ClusterR") #acuracy measure
  
  if (!(require("mclust"))) 
    print("Error in loading mclust package!!! Please check if installed correctly...")
  
  if (!(require("rgl")))
    print("Error in loading rgl package!!! Please check if installed correctly...")
  
  if (!(require("car")))
    print("Error in loading car package!!! Please check if installed correctly...")
  
  if (!(require("ClusterR")))
    print("Error in loading car package!!! Please check if installed correctly...")
  
  if (!(require("factoextra")))
    print("Error in loading car package!!! Please check if installed")
}

readData <- function() {
  data <- read.csv(file="./dataset2.csv", header=TRUE, sep=",")
  return(data)
}

dataPreProc <- function(data) {
  return (na.omit(data))
}

findOptK <- function(data) {
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:15) wss[i] <- sum(kmeans(data,centers=i)$withinss)
  plot(1:15, wss, type="b", xlab="Number of Clusters",ylab="Within groups sum of squares")
}

myKmeans <- function(data,k) {
  kc <- kmeans(data, centers = k, nstart = 25)
  return (kc)
}

evaluateClust <- function(km_res) {
  print("Total Sum of Squares (TSS)")
  print(km_res$totss)
  print("Between Sum of Squares (BSS)")
  print(km_res$betweenss)
  print("BSS/TSS ratio")
  print(km_res$betweenss/km_res$totss)
}

  init()
  set.seed(6930)
  data <- readData()
  #data <- dataPreProc(data)
  findOptK(data) 
  km_res <- myKmeans(data,10)
  
  fviz_cluster(km_res, data = data, ellipse.type = "convex", palette = "jco", ggtheme = theme_minimal())
  
  evaluateClust(km_res)

