# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# 
# and load the data into R. The code book, describing the variable names is here: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# 
# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. which(agricultureLogical) What are the first 3 values that result?

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(url,"ACS-survey.csv", method="curl")

acs_survey_data <- read.csv("ACS-survey.csv")

# We are interested in the AGS and ACR columns.
# According to the code book, the column AGS contains sales of agriculture products, 
# with the possible values:
# NA (less than 1 acre/GQ/vacant or more units in structure)
# 1 - None
# 2 - $ 1 - $ 999
# 3 - $ 1000 - $ 2499
# 4 - $ 2500 - $ 4999
# 5 - $ 5000 - $ 9999
# 6 - $10000+ 

# The ACR column contains the lot size, as follows:
# N/A - (GQ/not a one-family house or mobile home)
# 1 - House on less than one acre
# 2 - House on one to less than ten acres 
# 3 - House on ten or more acres

agricultureLocal <- (acs_survey_data$AGS == 6 & acs_survey_data$ACR == 3)
which(agricultureLocal)

