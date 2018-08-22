library(rvest)
library(DataCombine)
teams <- c("ATL", "BOS", "BRK", "CHO", "CHI", "CLE", "DAL", "DEN", "DET", 
           "GSW", "HOU", "IND", "LAL", "LAC", "MEM", "MIA", "MIL", "MIN", "NOP", 
           "NYK", "OKC", "ORL", "PHI", "PHO", "POR", "SAC", "SAS", "TOR", "UTA", 
           "WAS")

years <- c(2013, 2014, 2015, 2016, 2017)
urls <- c()
paths <- c()
cols <- c("Id", "G", "Date", "Home", "Opp", "Wins", "Tm", "Opper", "ORtg", 
          "DRtg", "Pace", "FTr", "3PAr", "TSP", "TRBP", "ASTP", "STLP", "BLKP", 
          "BL", "eFGP", "TOVP", "ORBP", "FT_FGA", "Bl1", "OppFGP", "OppTOVP", 
          "DRBP", "OppFT_FGA")

for (year in years)
{
  for (team in teams)
  {
    urls <- c(urls, sprintf("http://www.basketball-reference.com/teams/%s/%i/gamelog-advanced/#tgl_advanced::none", 
                            team, year))
    
    paths <- c(paths, sprintf("~/Desktop/github/nbamodel/data/AdvGL/%s/%s%iGL.csv", 
                              team, team, year))
    
    # update team urls for changed teamIDs
    if (team == "NOP" && year <= 2013)
    {
      urls <- gsub("NOP", "NOH", urls)
    } else if (team == "CHO" && year <= 2014)
    {
      urls <- gsub("CHO", "CHA", urls)
    }
    
  }
}


cleanData <- function(data)
{
  # drop empty columns
  drops <- c("BL", "Bl1")
  # delete split table rows that contain 'Advanced'
  data <- data[,!(names(data) %in% drops)]
  data <- data[!(data$ORtg %in% c("Advanced", "ORtg")),]
  data$Home <- sub("^$", "1", data$Home)
  ## find and replace the Wins column with binary values, Win= 1 & Loss= 0
  rep1 <- data.frame(from = c("W", "L"), to = c("1", "0"))
  data <-
    FindReplace(
      data = data,
      Var = "Wins",
      replaceData = rep1,
      from = "from",
      to = "to",
      exact = FALSE
    )
  # find and replace @ symbol in Home column and change to binary value 0 to signify away game
  rep2 <- data.frame(from = c("@"), to = c("0"))
  data <-
    FindReplace(
      data = data,
      Var = "Home",
      replaceData = rep2,
      from = "from",
      to = "to",
      exact = FALSE
    )
}

#scrape gamelogs in table format
getGameLogs <- function(urls)
{
  webpage <- read_html(urls)
  advancedGL <- html_nodes(webpage, "table")
  advancedGlTable <- html_table(advancedGL, header = FALSE)[[1]]
  data <- advancedGlTable[3:nrow(advancedGlTable), ]
  columnnames <- data[1, ]
  colnames(data) <- cols
  data <- cleanData(data)
}

#write the tables to csv files
i <- 1
while (i <= length(urls)) {
  data <- getGameLogs(urls[i])
  write.csv(data, file = paths[i], row.names = FALSE)
  i <- i + 1
  
}

