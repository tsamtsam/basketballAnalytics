# read in cleaned data
data <- read.csv(file="basketballStatsAnalysis.csv", header=TRUE, sep=",")

#Create 10 equally size folds from sampling from the data
folds <- sample(folds, nrow(data))

#Perform 10 fold cross validation
partitions = c()
for(i in 1:10){
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
fold6 = data[partitions[[6]], ]
fold7 = data[partitions[[7]], ]
fold8 = data[partitions[[8]], ]
fold9 = data[partitions[[9]], ]
fold10 = data[partitions[[10]], ]
