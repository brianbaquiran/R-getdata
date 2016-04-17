#datadir <- "UCI HAR Dataset"
# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Download and unpack the dataset
# It's around 60MB. 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- basename(url)
if (! file.exists(filename)) {
  download.file(url, filename)
  unzip(filename)
  
}

# Load the two important files from the root of the data directory
# - 'activity_labels.txt': Links the class labels with their activity name.
# - 'features.txt': List of all features (described in features_info.txt)
activity_codes<-read.table(file="UCI HAR Dataset/activity_labels.txt", col.names=c("activity_id","activity_name"))
feature_codes <- read.table(file="UCI HAR Dataset/features.txt",col.names=c("feature_id","feature_name"),stringsAsFactors=FALSE)

# Set up a list to contain the two larger data.frames that will contain the training and test data sets
data_list=list()

# Process each of the two sets of data:
# there are two directories, 'test' and 'train'
for (set in c("test","train")) {

        # Set up the file paths for each set
        
        # First, the file that identifies the subject performing the action
        # - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
        subject_file <- paste("UCI HAR Dataset/",set,"/subject_",set,".txt",sep="")
        
        # The activity labels for each sample. These are the y_train.txt and y_test files
        activities_file <- paste("UCI HAR Dataset/",set,"/y_",set,".txt",sep="")
        
        # Finally the set of measurements for each subject/activity
        data_file <- paste("UCI HAR Dataset/",set,"/X_",set,".txt",sep="") 

        # Once the file paths are set up, we can load them in to some temporary variables
        # subject list
        subjects<-read.table(file=subject_file,col.names=c("subject_id"))
        # activity list
        subject_activities <- read.table(file=activities_file,col.names=c("activity_id"))
        # measurements
        subject_data <- read.table(file=data_file,col.names=feature_codes$feature_name)
        
        # I've found using col.names parameter in read.table results in mangled column names 
        # if the column names have special characters in them. This fixes the problem.
        colnames(subject_data) <- feature_codes$feature_name
        
        # Use merge to to join the activity names to the observations and cbind the columns together
        # The data.frame is saved as a list element, keyed by data set (test, train)
        data_list[[set]] <- cbind(subjects,merge(subject_activities,activity_codes),subject_data)
}
# combine the two data sets to a single data set
# which uses descriptive activity names to name the activities 
# in the data set (in the activity_name) column
full_data <- rbind(data_list[["train"]],data_list[["test"]])
observation_names <- names(full_data)[c(-1,-2,-3)]

# We're only interested in the mean and std measurements
mean_std_names <- grep("mean|std",observation_names, value=TRUE)

# Extract the subset of the data we're interested in
mean_std_data <- full_data[,c("subject_id","activity_name",mean_std_names)]

# Use ddply and apply to compute the means of each combination of subject+activity
library(dplyr)
tidy_data<-ddply(mean_std_data,c("subject_id","activity_name"), function(xx) {
        # columns 1-2 contain the subject_id and activity name 
        # so we only apply mean to columns 3-81
        apply(xx[3:81],2,mean)
})

write.table(tidy_data,"tidy_data.txt")
