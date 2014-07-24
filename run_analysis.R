#0. downloading and unzipping data set
if(!file.exists("./UCI HAR Dataset/README.txt")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="./getdata-projectfiles-UCI HAR Dataset.zip", method="auto")
  unzip("getdata-projectfiles-UCI HAR Dataset.zip",exdir=".")
}

# ----------- 1. Merges the training and the test sets to create one data set.  ----------- 

#1A. loading features labels 
colNames <- read.table("./UCI HAR Dataset/features.txt", colClasses="character")$V2

#1B. loading the training and the test sub-sets into R  
trn <- read.table("./UCI HAR Dataset/train/X_train.txt",
                  colClasses = "numeric", col.names=colNames)
tst <- read.table("./UCI HAR Dataset/test/X_test.txt",
                  colClasses = "numeric", col.names=colNames)

#1C. loading activity labels and merging with the train activity column
aLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors=T)
tmp <- merge(aLabels, read.table("./UCI HAR Dataset/train/y_train.txt",colClasses="numeric"), 
             by.x="V1", by.y="V1", all=T )
trn$activity <- tmp$V2

#1D. loading and adding the activity test column
tmp <- merge(aLabels, read.table("./UCI HAR Dataset/test/y_test.txt", colClasses="numeric"), 
             by.x="V1", by.y="V1", all=T )
tst$activity <- tmp$V2

#1E. loading and adding subjects' ids as the last columns to train and test data sub-sets
tst$id <- read.table("./UCI HAR Dataset/test/subject_test.txt",colClasses="numeric")$V1 
trn$id <- read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses="numeric")$V1 

#1F. marking test and train records separately and merging sub-sets together into a new dataset
trn$testOrTrain <- "train"
tst$testOrTrain <- "test"

dt <- rbind(trn,tst)

dt <- transform(dt, testOrTrain=factor(testOrTrain), id=factor(id), activity=factor(activity))

trn <- NULL; tst <- NULL; tmp<-NULL; aLabels<-NULL; colNames<-NULL;

# ----------- 2. Extracts only the measurements on the mean and standard deviation 
#                for each measurement.                                            ----------- 

lab <- subset(dt,select=)

















# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for 
#    each activity and each subject. 

tds <- transform(dt)