library(DataCombine)
library(rvest)
library(lubridate)
getSchedule<- function(month){
  
  url <- sprintf("http://www.basketball-reference.com/leagues/NBA_2018_games-%s.html", month)
  webpage <- read_html(url)
  stats <- html_table(webpage)
  data<-data.frame(stats)
  colnames(data)<- c("date", "start_time", "away_team", "drop", "home_team", "drop1", "drop2", "drop3", "drop4")
  drops <- c("drop", "drop1", "drop2", "drop3", "drop4")
  data<-data[, !(names(data) %in% drops)]
  Replaces <- data.frame(from = c(",", " "), to = c("/", ""))
  data_clean <- FindReplace(data = data, Var = "date", replaceData = Replaces, from = "from", to = "to", exact = FALSE)
  data_clean$date<-format(as.Date(data_clean$date, "%a/%b%d/%Y"))
  data_clean$start_time<-format(strptime(data_clean$start_time, "%I:%M %p"))
  data_clean$start_time<-strftime(data_clean$start_time, format="%H:%M:%S")
  data_clean
  
}
##example
november<- getSchedule("november")
today <- Sys.Date()
#print todays date to ensure function is working
today
todays_games<-november[which(november$date == today), ]
todays_games

