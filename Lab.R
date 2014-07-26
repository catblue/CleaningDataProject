# 1. The explanation is as important as the script, so make sure you have the read me
# 2. have you combined the training and test x and y into one block, given them headings, 
#     and turned the numeric activities into something easier to read. 
#     Think of it as you data files are blocks of lego and you are working out how to clip 
#     them together to make a wall.
# 3. have you extracted some variables to do with mean and standard deviation from the full set. 
#     I am being non-specific here because in this assignment you are using you professional 
#     judgement about which variables to include and documenting your reasoning. 
#     There is no specific number of columns that is correct.
# 4. have you explained what those variables are and your criteria for picking them in the readMe
# 5. have you gotten the average of each variable for each combination of subject and activity 
#     and saved the data frame of this as a set of tidy data
# 6. have you give the variables English-like descriptive names describing the activity 
#     that the sensor is measuring? (this is a slightly, or indeed very, horribly worded 
#     part of the assignment)
# 7. remember that codebook you had to learn to use in the week 1 quiz, now it * is time to 
#     create your own describing those descriptive English named variables you decided to use. 
#     The codebook should go on github to. have you loaded up your current script, an up to 
#     date read me and the codebook to github?
# 8. and your tidy data to coursera- Important load in a text file of the data (or at least 
#     some kind of file). Do not try and copy and paste in all your tidy data. Very, very 
#     bad things might happen to your submission. Do not experiment to find out what, 
#     just trust me on this from previous experience. Add a file like it says in the 
#     instructions. Personally, I think it is a reasonable assumption to figure that 
#     anyone doing this course is able to deal with a tab delimited text file like you get 
#     by taking your data and doing write.table().

# https://class.coursera.org/getdata-003/forum/thread?thread_id=92



## 0: installations, environment etc.
if(!"data.table" %in% installed.packages()) install.packages("data.table")












#1. downloading and unzipping data set
# if(!file.exists("./data/README.txt")){
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", fileTemp)
# dt <- read.table(unz(fileTemp, "a1.dat"))
# unlink(temp)
# 
if(!file.exists("./data/UCI HAR Dataset/README.txt")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile="./data/Dataset.zip", method="auto")
  unzip("./data/Dataset.zip",exdir="./data")
}






#1. loading and corecting feautures columns' names

colNames <- read.table("./data/UCI HAR Dataset/features.txt",colClasses = "character")[,2]
#colScrap <- vector(mode = "logical",length = length(colNames))

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
library(data.table)
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",
                    colClasses = "numeric", col.names=colNames)#, fill = T)#[,colScrap]
train <- subset(train, select = colScrap)

test <- read.table("./data/UCI HAR Dataset/test/X_test.txt",
                    colClasses = "numeric", col.names=colNames)#, fill = T)#[,colScrap]
test <- subset(test, select = colScrap)


# library(data.table)
# trn <- fread("./data/UCI HAR Dataset/train/X_train.txt",
#                             header=FALSE,
#                             colClasses=rep("numeric",561)) doesn't work; throws an error in the middle of dataset..


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

#1D. loading and adding subjects' ids as the first column to train and test collections

train <- cbind(subject=read.table("./data/UCI HAR Dataset/train/subject_train.txt", colClasses="factor", 
                                  fill=T)$V1, train)
test <- cbind(subject=read.table("./data/UCI HAR Dataset/test/subject_test.txt", colClasses="factor", 
                                  fill=T)$V1, test)
#1F. marking test and train records separately and merging together into a new dataframe dt

# trn$testOrTrain <- "train"
# tst$testOrTrain <- "test"
dt <- rbind(train,test)

write.csv(dt, file = "./data/tidy.csv.txt", row.names = FALSE)













dt <- transform(dt, testOrTrain=factor(testOrTrain), id=factor(id), activity=factor(activity))
# dt$testOrTrain <- factor(dt$testOrTrain)
# dt$id <- factor(dt$id)
# dt$activity <- factor(dt$activity)

trn <- NULL; tst <- NULL
any(is.na(dt))
any(dt[1:561] > 1)
any(dt[1:561] < -1)
summary(dt)
all(colSums(is.na(dt))==0) #TRUE
hist(unlist(dt[1:561],use.names=F))

#====================================
#----------- Plots ------------
library(lattice)
#library(datasets)
#xyplot(Ozone ~ Wind, data=airquality)
p <- histogram(data=dt, ~ fBodyGyro.mean...Y | activity )
#p <- xyplot(Ozone ~ Wind | Month, data=airquality,layout=c(5,1))
print(p)


feat="fBodyGyro.mean...Y"

compL <- function(i,id = 0){
  if (id==0){
    p <- histogram(data=dt, ~ dt[[names(dt)[i]]] | activity,xlab=names(dt)[i] )
    print(p)
    
  } 
  else {
    #d=subset(dt,id==id)
    p <- histogram(data=dt, ~ dt[[names(dt)[i]]] | id ,xlab=names(dt)[i] )
    print(p)
  }
}


compB <- function(feat,act,id = 0){
  if (id==0){
    hist(dt[[feat]][dt$activity==act])  
    rug(dt[[feat]][dt$activity==act])
  } 
  else {
    hist(dt[[feat]][dt$activity==act & dt$id==id])  
    rug(dt[[feat]][dt$activity==act & dt$id==id])
  }
}

comp3("tBodyAccJerk.correlation...Y.Z","WALKING")

hist(dt$fBodyGyro.mean...Y[dt$activity=="WALKING_DOWNSTAIRS"])
rug(dt$fBodyGyro.mean...Y[dt$activity=="WALKING_DOWNSTAIRS"])

hist(dt$tBodyGyroMag.mean..)
rug(dt$tBodyGyroMag.mean..)

hist(dt$tBodyGyroMag.mean..[dt$id==2])
rug(dt$tBodyGyroMag.mean..[dt$id==2])

hist(dt$fBodyGyro.mean...Y[dt$id==2])
rug(dt$fBodyGyro.mean...Y[dt$id==2])


hist(dt$fBodyBodyGyroJerkMag.meanFreq..)




#============== looking into data organisation
sbjcts <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                     header=F, sep="", colClasses = "numeric", na.strings=" ", fill = T)

table(sbjcts)
length(sbjcts$V1)
length(unique(sbjcts$V1))

names(dt)



table(dt$activity)

table(dt$id,dt$activity)

with(dt,table(activity,id))



#dt$Time <- strptime(paste(eng$Date,eng$Time, sep=" "),format="%d/%m/%Y %H:%M:%S")
#dt$Date <- as.Date(eng$Date,format="%d/%m/%Y")
temp <- NULL




#----------- job --------------
# run_analysis.R that does the following: 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


#lab <- subset(dt,id==1:6 & activity=="WALKING", select=c(tBodyGyro-mean()-X,tBodyGyro-mean()-Y,tBodyGyro-mean()-Z))
lab <- subset(dt,as.numeric(id)>=1 & as.numeric(id)<=6 & activity=="WALKING", select=c(id,tBodyGyro.mean...X, tBodyGyro.mean...Y, tBodyGyro.mean...Z))




#----------- output -------------

write.table(dt, file="cleanSamsung.txt",sep = ",")




files_list <- list.files(inputfolder, pattern="*csv")
object_names <- gsub(".csv", "", files_list)
for (i in 1:length(files_list)){
f1 <- read.csv(paste(inputfolder, "/",files_list[i], sep=""), stringsAsFactors = FALSE)
assign(paste("tbl", object_names[i], sep=""), f1)
}
remove("f1","files_list","object_names")

