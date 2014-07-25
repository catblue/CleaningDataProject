# README
Peter Kurpinski  
Thursday, July 24, 2014  

# CleaningProject


This is a repository for the Project required for Getting and Cleaning Data classes by Coursera in July 2014. 

Purpose of the project is to prepare tidy data that can be used for later analysis. 

Apart from this very file and the README.md, the repository contains:

1. run_analysis.R; the script performing data cleaning  
2. CodeBookd.md; a codebook describing columns of the created tidy dataset 

and irrelevant for the reviewing, but important for me:
* Lab.R: experiments and notes necessary to produce run_analysis.R

Following is the log of actions that I undertook in order to create aimed tidy dataset:

1. script for downloading and unziping data into project subdirectory ./data
2. because of nothing simmilar available in RStudio I put the data into Excel spredsheet with 10 
tabs (train subset only, ignoring y and z axis but still it took 56 MB!!) in order to see how data is arranged.
3. after reading descriptions and doing some educated guessing :), I found out that, for example in the file "total_acc_x_train.txt":
  - each row represents 2.56 sek of recordings of acceleration of one of the subjects (pointed at by row in "subjetct_train.txt" file) along axis X.
  - type of activity performed during this 2.56sek is to be found in "y_train.txt" file
  - that that particular 2.56 has been used to calculate 561 various parameters (how they we computed was rougly mentioned in "features_info.txt"), names of which are to be found in file "features.txt"
4. At this moment I realized that I will not be interested in accelerations, nor in velocities, because the mediums are already calculated. So I will have to do following steps:

* load "body_acc_x-z_train.txt" and "body_gyro_x-z_train+test.txt" files

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
