# Question 5
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
# 
# using the fread() command load the data into an R object
# DT 
# Which of the following is the fastest way to calculate the average value of the variable
# pwgtp15 
# broken down by sex using the data.table package?
library(data.table)
q1.5 <- function() {
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
        datafile <- "data/ACS2006.csv"
        if (!file.exists(datafile)) {
                download.file(url,datafile,method="curl")
        }
        
        acs <- read.csv(datafile)
}