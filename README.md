R-getdata
=========

### Course Project - Tidy Data Set
* The script does not download raw data. [Download the data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) from the project and unzip. It will create a UCI HAR Dataset directory, with subdirectories beneath.
* [run_analysis.R](run_analysis.R) must be run one directory above the UCI HAR Dataset directory. It will perform the following actions: 
    1. The script will load the list of activities and features used in the datasets
    2. There are two datasets included in the zip file: a training dataset and a test dataset. 
    3. For each of the two datasets included in the zip file, the script will load the subject list, activity list, and measurement data. These will be merged with the activity names to create two data frames. 
    4. The two data frames will be combined into a single large data frame containing both the test and training data
    5. Since we are only interested in the mean and standard deviation measurements, a list of columns containing these measurements is built
    6. A subset of the data containing only the subject, activity name, and columns of interest is extracted
    7. The subset of data is summarized by subject and activity. Each measurement is averaged for each subject-activity combination.
    8. The data frame *tidy_data* contains the summarized data.
* Refer to the [Code Book](CodeBook.md) for a list of columns in the final data set.
