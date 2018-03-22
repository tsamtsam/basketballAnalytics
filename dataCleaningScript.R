data <- read.csv(file="~/Sports Analytics/basketball_players.csv", header=TRUE, sep=",")
players <- read.csv("~/Sports Analytics/basketball_master.csv", header=TRUE, sep=",")
colnames(data)[which(names(data) == "playerID")] <- "bioID"
cleanedData  = merge(data, players, by="bioID")


