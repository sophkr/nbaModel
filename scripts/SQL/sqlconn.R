install.packages("RMySQL")
install.packages("dbConnect")
library(RMySQL)
require(RMySQL)
con <- dbConnect(MySQL(), username="root", host="localhost", dbname="nbadata", password="", unix.sock="/Applications/MAMP/tmp/mysql/mysql.sock")
dbClearResult(dbListResults(con)[[1]])
dbListTables(con)


## when done run
dbDisconnect(con)


