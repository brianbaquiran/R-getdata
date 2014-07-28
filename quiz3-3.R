# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Load the educational data from this data set: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
# 
# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame? 
# 
# Original data sources: 
#         http://data.worldbank.org/data-catalog/GDP-ranking-table 
#       http://data.worldbank.org/data-catalog/ed-stats
library(plyr)
GDP_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
edu_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(GDP_url,"GDPdata.csv",method="curl")
download.file(edu_url,"edudata.csv",method="curl")

gdp_raw<-read.csv("GDPdata.csv",stringsAsFactors=FALSE,skip=4,nrows=231)
gdp <- gdp_raw[,c(1,2,4,5)]
colnames(gdp)<- c("CountryCode","ranking","economy","GDP_string")
gdp$GDP<-as.numeric(gsub(",","",gdp$GDP_string ))
education<-read.csv("edudata.csv")

gdp_educ <- merge(gdp,education,by.x="CountryCode",by.y="CountryCode")
gdp_educ_sorted<-arrange(gdp_educ,GDP)

# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
gdp_inc_groups <- gdp_educ[,c("ranking","Income.Group","GDP","CountryCode")]

# Either one of the two will give results
lapply((split(gdp_inc_groups,gdp_inc_groups$Income.Group)),function(x) {mean(x[[1]],na.rm=TRUE)})
ddply(gdp_inc_groups,"Income.Group",function(x){mean(x[["ranking"]],na.rm=TRUE)})

# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
# How many countries are Lower middle income but among the 38 nations with highest GDP?
gdp_inc_clean<- gdp_inc_groups[!is.na(gdp_inc_groups$ranking),]
gdp_inc_clean$quantile<-cut(gdp_inc_clean$ranking,breaks=5)

# Note that ranking is sorted according to highest GDP, so the lowest quantile has the highest GDP
table(gdp_inc_clean$Income.Group,gdp_inc_clean$quantile)