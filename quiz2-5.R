# Question 5
# Read this data set into R and report the sum of the numbers in the fourth column. 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
# 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
# 
# (Hint this is a fixed width file format)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

download.file(url,"quiz2-5.tbl",method="curl")
x <- read.fwf("quiz2-5.tbl",skip=4,widths=c(12,7,4,9,4,9,4,9,4))
sum(x[,4])