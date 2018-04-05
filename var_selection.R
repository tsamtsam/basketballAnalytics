data <- read.csv(file="basketballStatsAnalysis.csv", header=TRUE, sep=",")

col = c(26:33,19)

data = data[data$pos == "G" | data$pos == "F" | data$pos == "C", ]
data$pos = factor(data$pos) #remove a few position
data = data[,col] # only keep the per 36 stats and ft and 3pt percentage and the position
data<-data[sample(nrow(data)),] #randomize the data

backward_qda = stepclass(pos ~ ., data = data, method = "qda",
                     improvement = 0.001,direction = "backward", criterion = "CR") #correctness rate

backward_lda = stepclass(pos ~ ., data = data, method = "lda",
                         improvement = 0.001,direction = "backward", criterion = "CR",fold = 10) #correctness rate

forward_qda = stepclass(pos ~ ., data = data, method = "qda",
                         improvement = 0.001,direction = "forward", criterion = "CR",fold = 10) #correctness rate


forward_lda = stepclass(pos ~ ., data = data, method = "lda",
                         improvement = 0.001,direction = "forward", criterion = "CR",fold = 10) #correctness rate

both_lda = stepclass(pos ~ ., data = data, method = "lda",
                        improvement = 0.001,direction = "both", criterion = "CR",fold = 10)

both_qda = stepclass(pos ~ ., data = data, method = "qda",
                        improvement = 0.001,direction = "both", criterion = "CR",fold = 10)

forward_lda
forward_qda
backward_lda
backward_qda
both_lda
both_qda

# Observation:
#   For both the forward_lda and qda, they start with adding rp36 and then bp36. After that, they add ap36 and sp36
#   For the backward_qda, they dropped the ft percent and three percent. The backward lda kept everything.
#   For all the method, their CR are around 0.85 with 0.1% improvement.