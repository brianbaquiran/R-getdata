# Question 2
# The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. Download the American Community Survey data and load it into an R object called
# acs
# 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
# 
# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

install.package("sqldf")
library(sqldf)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url,"acs.csv",method="curl")
acs <- read.csv("acs.csv")

# Create temporary SQLite DB and load data into it from data frame acs
res <- sqldf("select pwgtp from acs where AGEP < 50", drv="SQLite")
