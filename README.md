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
3. after reading descriptions and doing some educated guesses :), I found out that, on example of the file "total_acc_x_train.txt":
  - each row represents 2.56 sek of recordings of acceleration of one of the subjects (pointed at by the subject identifier in coressponding row of "subject_train.txt" file).
  - type of activity performed during that 2.56sek period is to be found in "y_train.txt" file in similar way as subject id.
  - that this particular 2.56 measurement has been used to calculate 561 various parameters (how they we computed was rougly mentioned in "features_info.txt"), grouped in "X_train.txt". The names of computed parameters are to be found in the file "features.txt"
4. At that moment I realized that I will not be interested in accelerations, nor in velocities, because their mediums and sd are already calculated, So I will will need only:
  * "X_train.txt"
  * "y_train.txt"
  * "subject_train.txt"
  * and respectively "test" files
  * "fautures.txt" file
5. I started with loading "features" and manualy have changed some column names making them "tidy". Also I created a logical vector indexing columns that I decided to extract from original measurements. Decision I took noticing that mean and sd  parameters actually describing movemement of subjects together: 3D vectors of velocity, acceleration and jerk. I added the very interesting info about angles (columns 555-561) because it contained information on vertical position of the body of a subject. However angles between averaged vectors are not required mediums or standard deviations...

  have to do following steps:

* load "body_acc_x-z_train.txt" and "body_gyro_x-z_train+test.txt" files

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
