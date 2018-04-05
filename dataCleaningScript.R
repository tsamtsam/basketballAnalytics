#Read in csv files
data <- read.csv(file="basketball_players.csv", header=TRUE, sep=",")
players <- read.csv("basketball_master.csv", header=TRUE, sep=",")

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
  else if(mergedData$year[row] <= 1978) # take in at least 1979-1980 season where 3pt first began
  {
    excludePlayers = c(excludePlayers, row)
  }
}

#remove the excluded rows
cleanedData = mergedData[-excludePlayers, ]

#trim down the data selecting only necessarry columns for model
analysisData = subset(cleanedData,select = c(bioID,GP,year,minutes,points,rebounds,assists,steals,blocks,
                                             turnovers,PF,fgAttempted,fgMade,ftAttempted,ftMade,
                                             threeAttempted,threeMade,pos))

#add in new columns calculating per game stats and FT%
analysisData$ppg <- analysisData$points/analysisData$GP
analysisData$rpg <- analysisData$rebounds/analysisData$GP
analysisData$apg <- analysisData$assists/analysisData$GP
analysisData$spg <- analysisData$steals/analysisData$GP
analysisData$bpg <- analysisData$blocks/analysisData$GP
analysisData$tpg <- analysisData$turnovers/analysisData$GP
analysisData$ftpercent <- ifelse(analysisData$ftAttempted != 0,analysisData$ftMade/analysisData$ftAttempted,0)
analysisData$threepercent <- ifelse(analysisData$threeAttempted != 0,analysisData$threeMade/analysisData$threeAttempted,0)

#add in new columns calculating per 36 minutes stats and FT%
analysisData$pp36 <- analysisData$points/analysisData$minutes
analysisData$rp36 <- analysisData$rebounds/analysisData$minutes
analysisData$ap36 <- analysisData$assists/analysisData$minutes
analysisData$sp36 <- analysisData$steals/analysisData$minutes
analysisData$bp36 <- analysisData$blocks/analysisData$minutes
analysisData$tp36 <- analysisData$turnovers/analysisData$minutes

#remove rows with no position
analysisData = analysisData[!(is.na(analysisData$pos)), ]



#export data frame to csv
write.csv(analysisData, "basketballStatsAnalysis.csv")