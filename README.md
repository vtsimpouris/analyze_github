# analyze_GitHub
Data analysis on GitHub users using R.
The purpose of this project is to analyze a dataset of the 240 most stared projects on GitHub. The analysis should
succesffuly idenitfy the key developers behind each project and their roles in it.
### Prerequisites
R language
* [R-download](https://www.r-project.org/)

R packages
* [R-dplyr](https://www.rdocumentation.org/packages/dplyr/versions/0.7.8)
* [R-cluster](https://www.rdocumentation.org/packages/cluster/versions/2.0.7-1)
## Running the tests
Run the file main.R using your R interface.
Make sure to change your folder path at the top of the main.R file.
Also make sure you have all the source files and the dataset inside the main.R folder.
## System overview
![alt text](https://github.com/vtsimpouris/analyze_github/blob/master/flow.PNG)
## Results
Some results are presented below. For furthur details see the report.pdf

The following is a distribution of the projects based on the people working on them:
![alt text](https://github.com/vtsimpouris/analyze_github/blob/master/project_distr.jpg)

Clustering using kmeans was used to idenitfy different groups inside the dataset.
The following graph shows the cohesion measured for diiferent number of clusters. The line 
shows the optimal number.
![alt text](https://github.com/vtsimpouris/analyze_github/blob/master/small.jpg)

Table of the groups found:

![alt text](https://github.com/vtsimpouris/analyze_github/blob/master/clusters.PNG)

An analysis on the Developer group qualities:
![alt text](https://github.com/vtsimpouris/analyze_github/blob/master/table.PNG)
