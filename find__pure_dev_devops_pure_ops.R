plot(density(dataset$commits_authored),xlim = c(0,1),main = "commits distribution",xlab="commits authored")
abline(v=0.25, col="purple")
abline(v=0.1, col="purple")
devs = filter(dataset,dataset$commits_authored > 0.25)
ops = filter(dataset,dataset$commits_authored < 0.1)

devs$additions_per_commit = devs$tot_additions/devs$tot_commits
plot(density(devs$additions_per_commit),xlim = c(0, 200),main = "average code lines per commit distribution",xlab = "lines of code/commits")
abline(v=5, col="purple")
#we need an average of at least 5 lines of code per commit to classify someone as developer/coder
devs = filter(devs,devs$additions_per_commit > 5)

#pure devs have low participation on project's issues/features et and devops have some or high participation 
plot(density(na.omit(devs$issues_participated)),xlim = c(0,7),main = "dev/devops issues participation distribution")
abline(v= 0.4, col="purple")
abline(v= 1, col="purple")
devops = filter(devs,devs$issues_participated > 1)
devs = filter(devs,devs$issues_participated < 0.4)
