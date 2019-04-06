cluster_features = c("commits_authored","issues_participated","issues_opened","issues_closed")

avg_cohesion = 0
avg_separation = 0
for(i in 1:20){
  cohesion = 0
  separation = 0
  for (j in 2:13){
    model = kmeans(na.omit(big_projects[,cluster_features]), centers = j)
    cohesion[j] <- model$tot.withinss
    separation[j] <- model$betweenss
  }
  avg_cohesion = (avg_cohesion + cohesion)/i
  avg_separation = (avg_separation + separation)/i
}  
plot(avg_cohesion[2:13],pch = 16,main = "Big projects Engineer roles Cohesion",xlab = "Number of Clusters",ylab = "Average Cohesion")
abline(v=7, col="black")
plot(avg_separation[2:13],pch = 16,main = "Big projects Engineer roles Separation",xlab = "Number of Clusters",ylab = "Average Separaion")
abline(v=7, col="black")

nu_clusters=8

model = kmeans(na.omit(big_projects[,cluster_features]), centers = nu_clusters)
#plot(medium_projects[,cluster_features],pch = 16,col = model$cluster)