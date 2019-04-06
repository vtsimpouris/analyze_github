owners = dataset[1,];
k = 1;
for(i in 1:length(unique(dataset[,2]))){
  rep = unique(dataset[,2])[i];
  split_rep = unlist(strsplit(rep, split="/", fixed = FALSE, perl = FALSE, useBytes = FALSE))[1];
  subDataset = dataset[(dataset[,2]==rep),];
  project_size = length(subDataset[,1]);
  for(j in 1:project_size){
    contr = subDataset[j,]
    if(contr$Contributor_login == split_rep){
      owners[k,] <-contr;
      k = k + 1;
      break;
    }
  }
}