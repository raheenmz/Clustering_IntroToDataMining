# Clustering_IntroToDataMining

This goal of this project was to increasing familiarity with data clustering packages available in R. 

It uses the following clustering techniques:
1) K-means
2) Hierarchical
3) DBSCAN
4) Shared Nearest Neighbor

Instructions to run file:

1) Set working directory to Raheen_Mazgaonkar_47144316 (This is required as the script references to the excel sheet present in this folder. 
							If different excel has to be loaded please change path in readData())

2) Install the following packages (using install.packages(), code for this is present but commented in script to avoid reinstallation) 
   i) stats  (for k-means and hclust)
  ii) fpc    (for dbscan)
 iii) dbscan (for sNNclust)
  iv) ClusterR (for accuracy measure)
   v) mclust  (for adjusted rand index)
  vi) rgl   (for scatterplot)
 vii) car   (for scatterplot)
viii) factoextra ( for dendogram and scatterplot)
  ix) zeallot (for getting multiple output from function)

3) For dataset1, run proj2p1_final.R from source. 
   Note: 
   i) Each plot gets over-written on the previous one. So in case it is required to view dendogram or kNNdist plots, run each clustering separately. 
   ii) RGL is used for scatterplots, it doesn't display title but displays a number indicating order of display. 
	Order in which scatterplots are displayed is Original labels, K-means, Hierachical, Density-based and Graph-based. 
  iii) Plotting dendogram will take considerable time.

4) For dataset2, run proj2p2_final.R from source.
   Note: 
   i) Plotting final clusters will take considerable amount of time even after processing has stopped.
