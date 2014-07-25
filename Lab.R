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






#1A. loading features labels 
tmp <- read.table("./UCI HAR Dataset/features.txt",
                  colClasses = "character", fill = T)
ftLabels <- tmp$V2

#1B. loading the training and the test set into R  
trn <- read.table("./UCI HAR Dataset/train/X_train.txt",
                  colClasses = "numeric", col.names=ftLabels, fill = T)
# library(data.table)
# trn <- as.data.frame(fread("./UCI HAR Dataset/train/X_train.txt",
#                            header=FALSE,
#                            colClasses=rep("numeric",561)))
tst <- read.table("./UCI HAR Dataset/test/X_test.txt",
                  colClasses = "numeric", col.names=ftLabels, fill = T)

#1C. loading activities labels and merging with train as a activity column
lbls <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=T,
                         fill = T)
tmp <- merge(lbls, read.table("./UCI HAR Dataset/train/y_train.txt", colClasses="numeric", 
                              fill=T), by.x="V1", by.y="V1", all=T )
trn$activity <- tmp$V2

#1D. merging activity labels with test as an activity column (the last)
tmp <- merge(lbls, read.table("./UCI HAR Dataset/test/y_test.txt", colClasses="numeric", 
                              fill=T), by.x="V1", by.y="V1", all=T )
tst$activity <- tmp$V2

#1E. loading and adding subjects' ids as the last columns to train and test collections
tst$id <- read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses="numeric", 
                                fill=T)$V1
trn$id <- read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses="numeric", 
                                fill=T)$V1

#1F. marking test and train records separately and merging together into a new dataframe dt

trn$testOrTrain <- "train"
tst$testOrTrain <- "test"
dt <- rbind(trn,tst)

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

