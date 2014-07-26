## 0: installations, environment etc.
if(!"data.table" %in% installed.packages()) install.packages("data.table")

#1. downloading and unzipping data set
if(!file.exists("./data/UCI HAR Dataset/README.txt")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="./data/Dataset.zip", method="auto")
  unzip("./data/Dataset.zip",exdir="./data")
}

#1. loading and corecting feautures columns' names

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
colNames[1:6] <- addXYZ("tBodyAcc")
colScrap <- append(colScrap, 41:46)
colNames[41:46] <- addXYZ("tGravityAcc")
colScrap <- append(colScrap,  81:86)
colNames[81:86] <- addXYZ("tBodyAccJerk")
colScrap <- append(colScrap,  121:126)
colNames[121:126] <- addXYZ("tBodyGyro")
colScrap <- append(colScrap,  161:166)
colNames[161:166] <- addXYZ("tBodyGyroJerk")
colScrap <- append(colScrap,  201:202)
colNames[201:202] <- addSdMn("tBodyAccMag")
colScrap <- append(colScrap,  214:215)
colNames[214:215] <- addSdMn("tGravityAccMag")
colScrap <- append(colScrap,  227:228)
colNames[227:228] <- addSdMn("tBodyAccJerkMag")
colScrap <- append(colScrap,  240:241)
colNames[240:241] <- addSdMn("tBodyGyroMag")
colScrap <- append(colScrap,  253:254)
colNames[253:254] <- addSdMn("tBodyGyroJerkMag")
colScrap <- append(colScrap,  266:271)
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
colNames[503:504] <- addSdMn("fBodyAccMag")
colScrap <- append(colScrap,  516:517)
colNames[516:517] <- addSdMn("fBodyBodyAccJerkMag")
colScrap <- append(colScrap,  529:530)
colNames[529:530] <- addSdMn("fBodyBodyGyroMag")
colScrap <- append(colScrap,  539)
colNames[539] <- addFreq("fBodyBodyGyroMag")
colScrap <- append(colScrap,  542:543)
colNames[542:543] <- addSdMn("fBodyBodyGyroJerkMag")
colScrap <- append(colScrap,  552)
colNames[552] <- addFreq("fBodyBodyGyroJerkMag")
colScrap <- append(colScrap,  555:561)
colNames[555] <- "angle.Gravity.tBodyAccMean"
colNames[556] <- "angle.GravityMean.tBodyAccJerkMean"
colNames[557] <- "angle.Gravity.tBodyGyroMean"
colNames[558] <- "angle.GravityMean.tBodyGyroJerkMean"
colNames[559] <- "angle.GravityMean.X"
colNames[560] <- "angle.GravityMean.Y"
colNames[561] <- "angle.GravityMean.Z"

#colNames

#1B. loading the training and the test set into R  

train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",
                    colClasses = "numeric", col.names=colNames)#, fill = T)#[,colScrap]
train <- subset(train, select = colScrap)

test <- read.table("./data/UCI HAR Dataset/test/X_test.txt",
                   colClasses = "numeric", col.names=colNames)#, fill = T)#[,colScrap]
test <- subset(test, select = colScrap)

#1C. loading activities labels and merging with train as a activity column
actLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=T,
                        fill = T)
actColTrain <- merge(actLabels, read.table("./data/UCI HAR Dataset/train/y_train.txt", colClasses="numeric", 
                                           fill=T), by.x="V1", by.y="V1", all=T )[,2]

actColTest <- merge(actLabels, read.table("./data/UCI HAR Dataset/test/y_test.txt", colClasses="numeric", 
                                          fill=T), by.x="V1", by.y="V1", all=T )[,2]

#1D. merging activity labels with test as an activity column (the last)
train <- cbind(train, activity=actColTrain)
test <- cbind(test, activity=actColTest)

#1E. loading and adding subjects' ids as the first column to train and test collections

train <- cbind(subject=read.table("./data/UCI HAR Dataset/train/subject_train.txt", colClasses="factor", 
                                  fill=T)$V1, train)
test <- cbind(subject=read.table("./data/UCI HAR Dataset/test/subject_test.txt", colClasses="factor", 
                                 fill=T)$V1, test)
#1F. a new tidy dataframe dt

# trn$testOrTrain <- "train"
# tst$testOrTrain <- "test"
dt <- rbind(train,test)

write.csv(dt, file = "./data/tidy.csv.txt", row.names = FALSE)