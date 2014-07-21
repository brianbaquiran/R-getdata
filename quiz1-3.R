# Question 3
# Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
# 
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
#         dat 
# What is the value of:
#         sum(dat$Zip*dat$Ext,na.rm=T) 
# (original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

library(openxlsx)

q1.3 <- function () {
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
        datafile <- "data/q1-3.xlsx"
        if(!file.exists(datafile)) {
                download.file(url,datafile,method="curl")
        }
        
        d <- read.xlsx(datafile,colNames=FALSE,skipEmptyRows=FALSE)
        dat <- d[18:23,7:15]
        colnames(dat) <- dat[1,]
        dat <- dat[-1,]
        dat$Zip <- as.numeric(dat$Zip)
        dat$Ext <- as.numeric(dat$Ext)
        sum(dat$Zip*dat$Ext,na.rm=T) 
}