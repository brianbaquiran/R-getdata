# Read the XML data on Baltimore restaurants from here: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
# 
# How many restaurants have zipcode 21231?

q1.4 <- function() {
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
        datafile <- "data/q1q4.xml"
        
        if(!file.exists(datafile)) {
                download.file(url,datafile,method="curl")
        }
        library(XML)
        doc <-xmlTreeParse(datafile,useInternal=TRUE)
        rootNode <- xmlRoot(doc)
        zips <- xpathSApply(rootNode,"//zipcode", xmlValue)
        sum(zips == "21231")
}