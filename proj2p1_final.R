init <- function() {
  #install.packages("mclust") # rand index
  #install.packages("fpc") # fpc
  #install.packages("dbscan") # fpc
  #install.packages("rgl") # scatterplot
  #install.packages("car") # scatterplot
  #install.packages("factoextra") # scatterplot
  #install.packages("ClusterR") #acuracy measure
  #install.packages("zeallot")
  
  if (!(require("zeallot")))
    print("Error in loading car package!!! Please check if installed")
  
  if (!(require("mclust"))) 
    print("Error in loading mclust package!!! Please check if installed correctly...")
  
  if (!(require("dbscan"))) 
    print("Error in loading mclust package!!! Please check if installed correctly...")
  
  if (!(require("fpc")))
    print("Error in loading dbscan package!!! Please check if installed correctly...")
  
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
  dataset <- read.csv(file="./dataset1.csv", header=TRUE, sep=",")
  data <- dataset[,1:3]
  labels <- dataset[,4]
  return(list(data,labels))
}

dataPreProc <- function(data) {
  return (na.omit(data))
}

findOptK <- function(data) {
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:15) wss[i] <- sum(kmeans(data,centers=i)$withinss)
  plot(1:15, wss, type="b", xlab="Number of Clusters",ylab="Within groups sum of squares")
}

myKmeans <- function(data) {
  kc <- kmeans(data, centers = 8, nstart = 25)
  return (kc)
}

myHierClust <- function(data) {
  hc <- hclust(dist(data, method = "euclidean"), method = "ward.D2")
  return (hc)
}

myDBScan <- function(data) {
  kNNdistplot(data, k =  8 )
  abline(h = 1.463, lty = 2)
  dc <- fpc::dbscan(data, eps = 1.463, MinPts = 8)  
  return (dc)
}

mySNNClust <- function(data) {
  kNNdistplot(data, k =  10 )
  abline(h = 1.8, lty = 2)
  gc <- dbscan::sNNclust(data, k = 10, eps = 1.8, minPts = 10,borderPoints = TRUE)
  return (gc)
}

accuracyMeasures <- function(predictedLabels, actualLabels) {
  accuracy <- external_validation(actualLabels, predictedLabels, method = "adjusted_rand_index", summary_stats = T)
  accuracy
}

plotResults <- function(data,predictedLabels) {
  open3d()
  scatter3d(x = data$x, y = data$y, z = data$z,surface=FALSE, grid = FALSE, point.col = predictedLabels)
}

plotOriginalClusters <- function(data,labels){
  open3d()
  scatter3d(x = data$x, y = data$y, z = data$z, surface=FALSE, grid = FALSE, point.col = labels)
}

plotDendogram <- function(results) {
  fviz_dend(results, k = 8, cex = 0.5, color_labels_by_k = TRUE, rect = TRUE )
}

clustering <- function(predicted,actual) {
  init()
  set.seed(6930)
  c(data,labels)%<-%readData()
  data <- dataPreProc(data)

  plotOriginalClusters(data,labels)
  
  # K-Means Clustering
  km_res <- myKmeans(data)
  print("Results of K-Means Clustering")
  accuracyMeasures(km_res$cluster,labels)
  plotResults(data,km_res$cluster)
  
  # Hierarchical Clustering
  hc_res <- myHierClust(data)
  predictedLabels <- cutree(hc_res, k = 8 )
  plotDendogram(hc_res)
  print("Results of Hierarchical Clustering")
  accuracyMeasures(predictedLabels,labels)
  plotResults(data,predictedLabels)
  
  # Density based Clustering
  db_res <- myDBScan(data)
  print("Results of Density Based Clustering")
  accuracyMeasures(db_res$cluster,labels)
  plotResults(data,db_res$cluster + 1)
  
  # Graph based Clustering
  snn_res <- mySNNClust(data)
  print("Results of Graph Based Clustering")
  accuracyMeasures(snn_res$cluster,labels)
  plotResults(data,snn_res$cluster + 1)
  
}
  
clustering()


