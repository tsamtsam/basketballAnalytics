#Read in csv files
data <- read.csv(file="~/basketballAnalytics/basketball_players.csv", header=TRUE, sep=",")
players <- read.csv("~/basketballAnalytics/basketball_master.csv", header=TRUE, sep=",")

#rename the player ID column name so that we can merge the two data frames
colnames(data)[which(names(data) == "playerID")] <- "bioID"
mergedData  = merge(data, players, by="bioID")

#create a vector of row numbers of the players who played less than 5 minutes,  
#took less than 100 free throws in a season, or played before the merger of the NBA 
excludePlayers = c()
for (row in 1:nrow(mergedData))
{
  if(mergedData$GP[row] == 0)
  {
    excludePlayers = c(excludePlayers, row)
  }
  else if (mergedData$minutes[row] / mergedData$GP[row] <= 5)
  {
    excludePlayers = c(excludePlayers, row)
  }
  else if(mergedData$fgAttempted[row] < 100)
  {
    excludePlayers = c(excludePlayers, row)
  }
  else if(mergedData$year[row] <= 1976)
  {
    excludePlayers = c(excludePlayers, row)
  }
}

#remove the excluded rows
cleanedData = mergedData[-excludePlayers, ]
write.csv(cleanedData, "basketballStatsCleaned.csv")





