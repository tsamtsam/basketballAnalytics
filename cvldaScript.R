data <- read.csv(file="basketballStatsAnalysis.csv", header=TRUE, sep=",")
data = data[data$pos == "G" | data$pos == "F" | data$pos == "C", ]
partitions = list(fold1, fold2, fold3, fold4, fold5, fold6, fold7, fold8, fold9, fold10)

errorTest = c()
errorTrain = c()
library(MASS)
#perform lda leaving out 1 partition each time and calculate the error
for(i in 1:10)
{
  
#perform lda on the model
tr = data[ !(data$bioID %in% partitions[[i]]$bioID), ]
lda.fit = lda(pos~ rpg+ftpercent, data = tr)

#calculate train error
lda.predTr=predict(lda.fit , tr)
numErrorTrain = 0
for(j in 1:nrow(tr))
{
  if (lda.predTr$class[j] != tr$pos[j])
  {
    numErrorTrain = numErrorTrain + 1
  }
}
cvErrorTr = numErrorTrain / nrow(tr)
errorTrain = c(errorTrain, cvErrorTr)

#calculate test error
lda.predTe=predict(lda.fit , partitions[[i]])
numErrorTest = 0
for(j in 1:nrow(partitions[[i]]))
{
  if (lda.predTe$class[j] != partitions[[i]]$pos[j])
  {
    numErrorTest = numErrorTest + 1
  }
}
cvErrorTe = numErrorTest / nrow(partitions[[i]])
errorTest = c(errorTest, cvErrorTe)
}

plot(errorTest, type="o", col="blue", ylim=c(0,1))
lines(errorTrain, type="o", col="red")
