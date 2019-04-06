cluster_features = c("average_issues_comments_length","average_comments_per_issue","issues_participated","issues_opened")
ops[,c(cluster_features)] = scale(ops[,c(cluster_features)],scale=T,center = F)

avg_cohesion = 0
avg_separation = 0
for(i in 1:20){
  cohesion = 0
  separation = 0
  for (j in 2:13){
    model = kmeans(na.omit(ops[,cluster_features]), centers = j)
    cohesion[j] <- model$tot.withinss
    separation[j] <- model$betweenss
  }
  avg_cohesion = (avg_cohesion + cohesion)/i
  avg_separation = (avg_separation + separation)/i
}
plot(avg_cohesion[2:13],pch = 16,main = "ops Cohesion",xlab = "Number of Clusters",ylab = "Average Cohesion")
abline(v=8, col="black")
plot(avg_separation[2:13],pch = 16,main = "ops Separation",xlab = "Number of Clusters",ylab = "Average Separaion")
abline(v=8, col="black")

nu_clusters = 9

model = kmeans(na.omit(ops[,cluster_features]), centers = nu_clusters)
