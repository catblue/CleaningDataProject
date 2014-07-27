## installations, environment etc.
if(!"plyr" %in% installed.packages()) install.packages("plyr")


#0. ----- downloading and un-zipping data set
if(!file.exists("./data/UCI HAR Dataset/README.txt")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="./data/Dataset.zip", method="auto")
  unzip("./data/Dataset.zip",exdir="./data")
}

#1. ----- loading features names to modify accordding to the CodeBook 
colNames <- read.table("./data/UCI HAR Dataset/features.txt",colClasses = "character")[,2]

addXYZ <- function(name){
  c(paste(name,".Mean.X",sep = ""),
    paste(name,".Mean.Y",sep = ""),
    paste(name,".Mean.Z",sep = ""),
    paste(name,".StDev.X",sep = ""),
    paste(name,".StDev.Y",sep = ""),
    paste(name,".StDev.Z",sep = "") )
}
addSdMn <- function(name){
  c(paste(name,".Mean",sep = ""),
    paste(name,".StDev",sep = ""))
}
addMeanFreqXYZ <- function(name){
  c(paste(name,".MeanFreq.X",sep = ""),
    paste(name,".MeanFreq.Y",sep = ""),
    paste(name,".MeanFreq.Z",sep = ""))
}
addFreq <- function(name) paste(name,".MeanFreq",sep = "")

colScrap = vector(mode="integer")
colScrap <- 1:6
# ----- time domain variables
colNames[1:6] <- addXYZ("tBodyAcc")
# colScrap <- append(colScrap, 41:46)
# colNames[41:46] <- addXYZ("tGravityAcc")
colScrap <- append(colScrap,  81:86)
colNames[81:86] <- addXYZ("tBodyAccJerk")
colScrap <- append(colScrap,  121:126)
colNames[121:126] <- addXYZ("tBodyGyro")
colScrap <- append(colScrap,  161:166)
colNames[161:166] <- addXYZ("tBodyGyroJerk")
colScrap <- append(colScrap,  201:202)
colNames[201:202] <- addSdMn("tBodyAcc.Mag")
# colScrap <- append(colScrap,  214:215)
# colNames[214:215] <- addSdMn("tGravityAcc.Mag")
colScrap <- append(colScrap,  227:228)
colNames[227:228] <- addSdMn("tBodyAccJerk.Mag")
colScrap <- append(colScrap,  240:241)
colNames[240:241] <- addSdMn("tBodyGyro.Mag")
colScrap <- append(colScrap,  253:254)
colNames[253:254] <- addSdMn("tBodyGyroJerk.Mag")
colScrap <- append(colScrap,  266:271)
# ----- frequency  domain variables
colNames[266:271] <- addXYZ("fBodyAcc")
colScrap <- append(colScrap,  345:350)
colNames[345:350] <- addXYZ("fBodyAccJerk")
colScrap <- append(colScrap,  373:375)
colNames[373:375] <- addMeanFreqXYZ("fBodyAccJerk")
colScrap <- append(colScrap,  424:429)
colNames[424:429] <- addXYZ("fBodyGyro")
colScrap <- append(colScrap,  452:454)
colNames[452:454] <- addMeanFreqXYZ("fBodyGyro")
colScrap <- append(colScrap,  503:504)
colNames[503:504] <- addSdMn("fBodyAcc.Mag")
colScrap <- append(colScrap,  516:517)
colNames[516:517] <- addSdMn("fBodyBodyAccJerk.Mag")
colScrap <- append(colScrap,  529:530)
colNames[529:530] <- addSdMn("fBodyBodyGyro.Mag")
colScrap <- append(colScrap,  539)
colNames[539] <- addFreq("fBodyBodyGyro.Mag")
# colScrap <- append(colScrap,  542:543)
# colNames[542:543] <- addSdMn("fBodyBodyGyroJerk.Mag")
# colScrap <- append(colScrap,  552)
# colNames[552] <- addFreq("fBodyBodyGyroJerk.Mag")
# ----- angular variables
colScrap <- append(colScrap,  555:561)
colNames[555] <- "angleBetw.Gravity.tBodyAccMean"
colNames[556] <- "angleBetw.GravityMean.tBodyAccJerkMean"
colNames[557] <- "angleBetw.Gravity.tBodyGyroMean"
colNames[558] <- "angleBetw.GravityMean.tBodyGyroJerkMean"
# ----- position of the recording device ref to the gravity vector
colNames[559] <- "angleBetw.GravityMean.X"
colNames[560] <- "angleBetw.GravityMean.Y"
colNames[561] <- "angleBetw.GravityMean.Z"

#colNames

#1B. ----- loading the train and the test sets and extracting mean/sd columns  

train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",
                    colClasses = "numeric", col.names=colNames)
train <- subset(train, select = colScrap)

test <- read.table("./data/UCI HAR Dataset/test/X_test.txt",
                   colClasses = "numeric", col.names=colNames)
test <- subset(test, select = colScrap)


#1C. ----- loading activities' labels
actLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", 
                        stringsAsFactors=T)#fill = T)
names(actLabels) = c("idActiv","activity")

#1D. ----- loading and merging activity columns with test and train
trainActCol <- read.table("./data/UCI HAR Dataset/train/y_train.txt", colClasses="numeric")[,1]
testActCol <- read.table("./data/UCI HAR Dataset/test/y_test.txt", colClasses="numeric")[,1]
train <- cbind(idActiv=trainActCol, train)
test <- cbind(idActiv=testActCol, test)

#1E. ----- loading and adding subjects' ids as the first column to train and test
train <- cbind(subject=read.table("./data/UCI HAR Dataset/train/subject_train.txt", 
                                  colClasses="integer")[,1], train)
test <- cbind(subject=read.table("./data/UCI HAR Dataset/test/subject_test.txt", 
                                 colClasses="integer")[,1], test)

#2. ----- merging test and train data into a new dataframe
dt <- rbind(train,test)
train = NULL
test = NULL

#5A. -----  taking average of each variable for each combination of subject and activity
tidy <- aggregate(subset(dt, select=c(-subject,-idActiv)), 
                  by=list(dt$subject,dt$idActiv), FUN = mean)
names(tidy)[1:2] <- c("subject","idActiv")
tidy <- merge(x=actLabels, y=tidy, by="idActiv", all=T )
tidy$idActiv <- NULL

#5B. ----- saving the data frame of this as a set of tidy data
write.table(tidy, file = "./data/myTidyDataSet.txt", sep = "\t", row.names = FALSE)

