library(rvest)
getPerMinLeaders <- function(year) 
{
  url <-
    sprintf("http://www.basketball-reference.com/leagues/NBA_%i_per_minute.html",
            year)
  web <- read_html(url)
  per_min <- html_nodes(web, 'table')
  per_m <- html_table(per_min)[[1]]
  print(per_m)
}

#getPerMinLeaders(2017)

