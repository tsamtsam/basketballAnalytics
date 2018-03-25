data <- read.csv(file="basketballStatsAnalysis.csv", header=TRUE, sep=",")
data = data[data$pos == "G" | data$pos == "F" | data$pos == "C", ]

#shuffle rows
data<-data[sample(nrow(data)),]

#Create 10 equally size folds
folds <- cut(seq(1,nrow(data)),breaks=10,labels=FALSE)

errorTestLda = c()
errorTrainLda = c()
errorTestLr = c()
errorTrainLr = c()

library(MASS)
#perform lda leaving out 1 partition each time and calculate the error
for(i in 1:10)
{
  
testIndexes <- which(folds==i,arr.ind=TRUE)
testData <- data[testIndexes, ]
tr <- data[-testIndexes, ]

#perform lda and logistical regression on the model
lda.fit = lda(pos~ftpercent+rpg, data = tr)

#calculate train error
lda.predTr=predict(lda.fit , tr)
numErrorTrainLda = 0

for(j in 1:nrow(tr))
{
  if (lda.predTr$class[j] != tr$pos[j])
  {
    numErrorTrainLda = numErrorTrainLda + 1
  }
}
cvErrorTrLda = numErrorTrainLda / nrow(tr)
errorTrainLda = c(errorTrainLda, cvErrorTrLda)


#calculate test error
lda.predTe=predict(lda.fit , testData)
numErrorTestLda = 0

for(j in 1:nrow(testData))
{
  if (lda.predTe$class[j] != testData$pos[j])
  {
    numErrorTestLda = numErrorTestLda + 1
  }
}
cvErrorTeLda = numErrorTestLda / nrow(testData)
errorTestLda = c(errorTestLda, cvErrorTeLda)
}

plot(errorTestLda, type="o", col="blue", ylim=c(0,1))
lines(errorTrainLda, type="o", col="red")
