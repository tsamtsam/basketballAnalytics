data <- read.csv(file="basketballStatsAnalysis.csv", header=TRUE, sep=",")
data = data[data$pos == "G" | data$pos == "F" | data$pos == "C", ]

partitions = list(fold1, fold2, fold3, fold4, fold5)

errorTest = c()
errorTrain = c()
library(MASS)
#Randomly shuffle the data
data<-data[sample(nrow(data)),]

#Create 5 equally size folds
folds <- cut(seq(1,nrow(data)),breaks=5,labels=FALSE)

#perform qda leaving out 1 partition each time and calculate the error
for(i in 1:5)
{
  
  #perform qda on the model
  testIndexes <- which(folds==i,arr.ind=TRUE)
  testData <- data[testIndexes, ]
  trainData <- data[-testIndexes, ]
  trainData$pos = factor(trainData$pos) #drop the mixed position
  testData$pos = factor(testData$pos) #drop the mixed position
  qda.fit = qda(pos~ ppg+ rpg+ftpercent, data = trainData)
  
  #calculate train error
  qda.predTr=predict(qda.fit , trainData)
  numErrorTrain = 0
  for(j in 1:nrow(trainData))
  {
    if (qda.predTr$class[j] != trainData$pos[j])
    {
      numErrorTrain = numErrorTrain + 1
    }
  }
  cvErrorTr = numErrorTrain / nrow(trainData)
  errorTrain = c(errorTrain, cvErrorTr)
  
  #calculate test error
  qda.predTe=predict(qda.fit , testData)
  numErrorTest = 0
  for(j in 1:nrow(partitions[[i]]))
  {
    print(testData$pos[j])
    if (qda.predTe$class[j] != testData$pos[j])
    {
      numErrorTest = numErrorTest + 1
    }
  }
  cvErrorTe = numErrorTest / nrow(partitions[[i]])
  errorTest = c(errorTest, cvErrorTe)
}

plot(errorTest, type="o", col="blue", ylim=c(0,1))
lines(errorTrain, type="o", col="red")
