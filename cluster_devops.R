devops$violations_added_per_loc = devops$violations_added/devops$tot_additions
devops$violations_eliminated_per_loc = devops$violations_eliminated/devops$tot_additions
cluster_features = c("issues_closed_per_day","violations_added_per_loc","violations_eliminated_per_loc","average_issues_comments_length","average_comments_per_issue","issues_participated")

devops[,c(cluster_features)] = scale(devops[,c(cluster_features)],scale=T,center = F)
devops = na.omit(devops[,c(cluster_features)])
pca_model <- prcomp(devops[,c(cluster_features)], center = F, scale = F)
#pca_model$sdev^2
pca_devops <- as.data.frame(predict(pca_model, devops)[, 1:3])

avg_cohesion = 0
avg_separation = 0
for(i in 1:20){
  cohesion = 0
  separation = 0
  for (j in 2:13){
    model = kmeans(na.omit(devops[,cluster_features]), centers = j)
    cohesion[j] <- model$tot.withinss
    separation[j] <- model$betweenss
  }
  avg_cohesion = (avg_cohesion + cohesion)/i
  avg_separation = (avg_separation + separation)/i
}
plot(avg_cohesion[2:13],pch = 16,main = "Devops Cohesion",xlab = "Number of Clusters",ylab = "Average Cohesion")
abline(v=7, col="black")
plot(avg_separation[2:13],pch = 16,main = "Devops Separation",xlab = "Number of Clusters",ylab = "Average Separaion")
abline(v=7, col="black")
nu_clusters = 8

model = kmeans(pca_devops, centers = nu_clusters)
