rm(list = ls())
library(dplyr)
library(cluster)
setwd("C:/Users/tsimp/Desktop/PR/")
dataset = read.csv("dataset.csv", sep=';', header = TRUE, na.strings = c("NA"),
                   colClasses = c("character", "character", "numeric", "numeric", "integer", "integer",
                                  "integer", "numeric", "numeric", "integer", "integer", "integer", "integer",
                                  "integer", "integer", "numeric", "integer", "integer", "integer", "integer",
                                  "integer", "integer", "integer", "integer", "integer", "integer", "integer"))
rep_names = unique(dataset[,c("repository_name")])
unscaled_commits = dataset$commits_authored

for (i in 1:length(rep_names)){
  project = filter(dataset,dataset$repository_name == rep_names[i])
  tot_commits = sum(project$commits_authored)
  tot_issues = sum(project$issues_opened)
  dataset[dataset$repository_name == rep_names[i],c("tot_commits")] = tot_commits
  dataset[dataset$repository_name == rep_names[i],c("commits_authored")] = scale(project$commits_authored,center = F,scale = T)
  dataset[dataset$repository_name == rep_names[i],c("issues_opened")] = scale(project$issues_opened,center = F,scale = T)
  dataset[dataset$repository_name == rep_names[i],c("issues_closed")] = scale(project$issues_closed,center = F,scale = T)
  dataset[dataset$repository_name == rep_names[i],c("issues_participated")] = scale(project$issues_participated,center = F,scale = T)
}

dataset$active_commits = unscaled_commits/dataset$tot_commits
plot(density(dataset$active_commits),xlim = c(0,0.1))
abline(v=0.01, col="purple")
plot(density(na.omit(dataset$issues_participated)),xlim = c(0,0.7))
abline(v=0.1, col="purple")
dataset = dataset[(dataset$active_commits > 0.01)|(dataset$issues_participated > 0.1),]

#General model

source("general_clustering.R")
for(i in 1:nu_clusters){
  boxplot(dataset[model$cluster == i,cluster_features],ylim = c(0,4),main = "Main dataset",xlab = "engineer group characteristics")
}

for (i in 1:length(rep_names)){
  project = filter(dataset,dataset$repository_name == rep_names[i])
  dataset[dataset$repository_name == rep_names[i],c("nu_active_engineers")] = nrow(project)
}
dataset = dataset[order(-dataset$nu_active_engineers),]
plot(density(unique(dataset$nu_active_engineers)),xlab = "Number of engineers",main = "project size distribution")
abline(v=7, col="purple")
abline(v=22, col="purple")

small_projects = filter(dataset,dataset$nu_active_engineers <= 7)
medium_projects = filter(dataset,dataset$nu_active_engineers > 7)
medium_projects = filter(medium_projects,medium_projects$nu_active_engineers <= 22)
big_projects =  filter(dataset,dataset$nu_active_engineers > 22)


source("cluster_roles_small_size_projects.R")
for(i in 1:nu_clusters){
  limit = max(na.omit(small_projects[model$cluster == i,cluster_features]))
  boxplot(small_projects[model$cluster == i,cluster_features],ylim = c(0,limit),main = "Small projects group",xlab = "engineer group characteristics")
}
source("cluster_roles_medium_size_projects.R")
for(i in 1:nu_clusters){
  limit = max(na.omit(medium_projects[model$cluster == i,cluster_features]))
  boxplot(medium_projects[model$cluster == i,cluster_features],ylim = c(0,limit),main = "Medium projects group",xlab = "engineer group characteristics")
}
source("cluster_roles_big_size_projects.R")
for(i in 1:nu_clusters){
  limit = max(na.omit(big_projects[model$cluster == i,cluster_features]))
  boxplot(big_projects[model$cluster == i,cluster_features],ylim = c(0,limit),main = "Big projects group",xlab = "engineer group characteristics")
}


#Special models

source("find_owners.R")
source("cluster_owners.R")
for(i in 1:nu_clusters){
  limit = max(na.omit(owners[model$cluster == i,cluster_features]))
  boxplot(owners[model$cluster == i,cluster_features],ylim = c(0,limit),main = "Project owners group",xlab = "owner-engineer group characteristics")
}

source("find__pure_dev_devops_pure_ops.R")
source("cluster_devs.R")
for(i in 1:nu_clusters){
  limit = max(na.omit(devs[model$cluster == i,cluster_features]))
  boxplot(devs[model$cluster == i,cluster_features],ylim = c(0,limit),main = "Developers group",xlab = "Developer group characteristics")
}
source("cluster_devops.R")
for(i in 1:nu_clusters){
  boxplot(devops[model$cluster == i,cluster_features],ylim = c(0,5),main = "Devops group",xlab = "Devops group characteristics")
}
source("cluster_ops.R")
for(i in 1:nu_clusters){
  boxplot(ops[model$cluster == i,cluster_features],ylim = c(0,2),main = "ops group",xlab = "Ops group characteristics")
}















