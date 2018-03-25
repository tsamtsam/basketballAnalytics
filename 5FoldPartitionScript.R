# read in cleaned data
data <- read.csv(file="basketballStatsAnalysis.csv", header=TRUE, sep=",")

#Randomly shuffle the data
data<-data[sample(nrow(data)),]

#Create 5 equally size folds
folds <- cut(seq(1,nrow(data)),breaks=5,labels=FALSE)

#Perform 10 fold cross validation
partitions = c()
for(i in 1:5){
  #Segement your data by fold using the which() function 
  partitionIndexes <- which(folds==i,arr.ind=TRUE)
  partitions = append(partitions, list(partitionIndexes))
}

#create 10 data frames of each partition
fold1 = data[partitions[[1]], ]
fold2 = data[partitions[[2]], ]
fold3 = data[partitions[[3]], ]
fold4 = data[partitions[[4]], ]
fold5= data[partitions[[5]], ]
