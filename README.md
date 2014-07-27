# README
Peter Kurpinski  
Thursday, July 24, 2014  

# CleaningProject


This is a repository for the Project required for Getting and Cleaning Data classes by Coursera in July 2014. 

Purpose of the project is to prepare tidy data that can be used for later analysis. 

Apart from this very file and the README.md, the repository contains:

1. run_analysis.R; the script performing data cleaning  
2. CodeBookd.md; a codebook describing columns of the created tidy dataset 
3. and irrelevant for the reviewing, but important for me:
  - Lab.R: experiments and notes necessary to produce run_analysis.R

Following, is the log of actions that I undertook in order to create aimed tidy dataset:

1. I wrote and run a piece of script to download and unzip data into project subdirectory ./data

2. Because of nothing similar available in RStudio I put the data into Excel spreadsheet. It took 10 tabs (train data subset for X only, ignored Y and Z axis, but still it took 56 MB!!) in order to see how data looks like and generally familiarize with it...

3. after reading descriptions and doing some educated guesses :), I found out that, 
on example of the file "total_acc_x_train.txt":
  - each row represents 2.56 sek of recordings of acceleration of one subject (pointed at by the subject identifier in the corresponding  row of "subject_train.txt" file).
  - type of the activity performed during measurement for the row (2.56sek period) is to be found in "y_train.txt", in the similar way as subject id was stored.
  - that this particular 2.56 measurement has been used to calculate massive set of 561 various parameters (the way how they we computed was roughly sketched in "features_info.txt"). The subset referring 2.56sek row was stored in corresponding row of "X_train.txt". The names of columns were put in "features.txt".

4. At that moment I realized that I will not be interested in rough accelerations, or in velocities from gyro, because their mediums and sd are already calculated and stored in X_train|test.txt. I will be needing only following:
  * "X_train|test.txt"
  * "y_train|test.txt"
  * "subject_train|test.txt"
  * "fautures.txt" file

5. I started with loading "features" and manually changed some column names making them "tidier" It took me over 2 hours! Also I created a vector indexing columns that supposed to be used in the tidier dataset. 

The most valuable seemed to me measurements regarding actual movement and position. that's why I rejected, in spite of being on mean or sd the gravitation part of acceleration. I left though the angles in order to have reference vertical vector. 

So in I composed my dataset out of 3D vectors of velocity, acceleration and jerk. 
I added info about angles (columns 555-561) because it contained information on vertical position of the body of a subject. 

6. Then I loaded train and the test sets from  X_train.txt, test.txt. I applied column index vector to stay with smaller and "more maneuverable" datatsets.

7. I loaded names of the activities from "activity_labels.txt" and set names to this miniscule datasets to use numeric indexes as a reference column for merging.

I decided to leave the names of activities in upper case as they were originally...
 
8. I loaded and "cbind-ed" activities and subject numbers with train and test datatsets. And "rbind-ed" them into one bigger dataset.

9.-10 There were only two things to do left: 
to "create a second, independent tidy data set with the average of each variable for each activity and each subject"
and save it in a tab delimited text file.
So I did it and started writing this record of my pains and efforts 
;)
 
 I am leaving the description of what was supposed to do below, for you... 
 
 it was always there...
 
 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
