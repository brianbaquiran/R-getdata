datadir <- "UCI HAR Dataset"

activity_labels<-read.table(file="activity_labels.txt")
features <- read.table(file="features.txt",stringsAsFactors=FALSE)

# test
subject<-read.table(file="test/subject_test.txt")
colnames(subject) <- "subject"
#set <- read.table(file="test/X_test.txt")
activity_label <- read.table(file="test/y_test.txt")
activity_name <- mapvalues(as.character(activity_label$V1),as.character(activity_labels$V1),as.character(activity_labels$V2))
colnames(set) <- features$V2
#z <- data.frame(subject,activity=activity_label,activity_name,set)
z <- cbind(subject,activity=activity_label,activity_name,set)

colnames(z)<-c("subject","activity","activity_name",colnames(set))

subject2 <- read.table("train/subject_train.txt")
colnames(subject2) <- "subject"
#set2 <- read.table(file="train/X_train.txt")
colnames(set2) <- features$V2
activity_label2 <- read.table(file="train/y_train.txt")
activity_name2 <- mapvalues(as.character(activity_label2$V1),as.character(activity_labels$V1),as.character(activity_labels$V2))

z2 <- cbind(subject2,activity=activity_label2,activity_name=activity_name2,set2)
colnames(z2)<-c("subject","activity","activity_name",colnames(set))

z3 <- rbind(z,z2)
# Extracts only the measurements on the mean and standard deviation for each measurement. 
meanstd <- features[grep("mean()|std()",features$V2),2]
z4<-z3[,c("subject","activity_name",meanstd)]

