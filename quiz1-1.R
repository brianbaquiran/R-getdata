# Quiz 1: Question 1
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# 
# and load the data into R. The code book, describing the variable names is here: 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# 
# How many properties are worth $1,000,000 or more?
getPoshProperties <- function() {
        datafile <- "data/q1-1.csv"
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
        setwd("/Users/RR/Code/getdata")
        if(!file.exists(datafile)) {
                download.file(url,"data/q1-1.csv",method="curl")        
        } else {
                ## print("data file already exists, not downloading")
        }
        
        d <- read.csv(datafile)
        poshProperties <- sum(d$VAL == 24, na.rm=TRUE)
}
