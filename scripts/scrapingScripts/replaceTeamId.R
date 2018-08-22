setwd("~/nbamodel/data")
teamIds<- read.csv("NbaTeams.csv")
teams<-c("Atlanta Hawks","Brooklyn Nets","Boston Celtics","Charlotte Hornets","Chicago Bulls","Cleveland Cavaliers","Dallas Mavericks","Denver Nuggets",
"Detroit Pistons","Golden State Warriors","Houston Rockets","Indiana Pacers","Los Angeles Clippers","Los Angeles Lakers", "Memphis Grizzlies",
"Miami Heat","Minnesota Timberwolves", "New Orleans Pelicans", "New York Knicks", "Oklahoma City Thunder","Orlando Magic","Philadelphia 76ers",
"Phoenix Suns","Portland Trailblazers","Sacramento Kings","San Antonio Spurs",
"Toronto Raptors","Utah Jazz","Washington Wizards")
df
new <- todays_games  # create a copy of df
# using lapply, loop over columns and match values to the look up table. store in "new".
new[] <- sapply(new, function(x) teamIds$teamId[match(x, teamIds$teamName)])
new
