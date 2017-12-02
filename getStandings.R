library(rvest)
getStandings <- function(year) 
{
  url <-
    sprintf("http://www.basketball-reference.com/leagues/NBA_%i_standings.html",
            year)
  web <- read_html(url)
  standings <- html_nodes(web, 'table')
  eastStand <- html_table(standings)[[1]]
  print(eastStand)
  westStand <- html_table(standings)[[2]]
  print(westStand)
}

#getStandings(2017)
