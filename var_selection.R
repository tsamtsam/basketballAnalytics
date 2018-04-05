
data(iris)
library(MASS)
iris.d <- iris[,1:4]  # the data    
iris.c <- iris[,5]    # the classes 
sc_obj <- stepclass(iris.d, iris.c, "lda", start.vars = "Sepal.Width")
sc_obj
plot(sc_obj)

data <- read.csv(file="basketballStatsAnalysis.csv", header=TRUE, sep=",")

col = c(26:33,19)

data = data[data$pos == "G" | data$pos == "F" | data$pos == "C", ]
data$pos = factor(data$pos) #remove a few position

data = data[,col] # only keep the per 36 stats and ft and 3pt percentage and the position

model = stepclass(pos ~ ., data = data, method = "qda",improvement = 0.05,direction = "backward", criterion = "CR") #correctness rate

model
plot(model)

