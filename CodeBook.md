# CodeBook
Peter Kurpinski  
Thursday, July 24, 2014  
# Code Book

This file describes the variables, the data, and any transformations that I performed to clean up the data.

### The source of the data

It is about wearable computing. The data represents data collected from the accelerometers from the Samsung Galaxy S smartphone. 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities:

1. WALKING 
2. WALKING_UPSTAIRS 
3. WALKING_DOWNSTAIRS 
4. SITTING 
5. STANDING 
6. LAYING 

wearing a smartphone on the waist. The embedded sensors, an accelerometer and gyroscope, provided acceleration and angular velocity 3D vectors at a constant rate of 50Hz. 
The type of activity performed in time has been labeled manually.

The rough sensor signals were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 

The acceleration signal, which has gravitational and body motion components, was separated into body acceleration and gravity. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

### Cleaning the data:

Work performed to clean up the data 1. First step was to recognize what was present in the rough data files 2. and how it was structured. 3. In order to achieve it I read and makes notes on a) Data Science, Wearable Computing and the Battle for the Throne as Worlds Top Sports Brand (which was a waste of time from the tas point of wiev) b)Human Activity Recognition Using Smartphones Data Set on both ucsi site aqnd univ site. Still 561 features vector not described c) previewing files structure and descriptions. There are 3 types of files in the data set a) signal: with 128 columns b) train/test: with 561 columns c) description: features.txt with train/test columns names, 4. Then I made a new pot of tea and started thinking about a structure of tidy data set 5.


### Columns

there are 72 columns in the datatset

 [,1] "activity" , names of activities: WALKING,	WALKING_UPSTAIRS,	WALKING_DOWNSTAIRS,
 SITTING, STANDING,	LAYING                              
 [,2] "subject" , numbers: 1 - 30
 
 Time domain measurements
 [,3] "tBodyAcc.Mean.X" mean of x axis component of body acceleration,   m/s^2                      
 [,4] "tBodyAcc.Mean.Y" mean of y axis component of body acceleration,                      
 [,5] "tBodyAcc.Mean.Z" mean of z axis component of body acceleration,
 
 [,6] "tBodyAcc.StDev.X"  standard deviation of x axis component of body acceleration,  m/s^2                    
 [,7] "tBodyAcc.StDev.Y"  standard deviation of y axis component of body acceleration,                       
 [,8] "tBodyAcc.StDev.Z"  standard deviation of z axis component of body acceleration,
 
 [,9] "tBodyAccJerk.Mean.X" mean of x axis component of jerk of body acceleration, m/s^3                    
[,10] "tBodyAccJerk.Mean.Y" mean of y axis component of jerk of body acceleration                   
[,11] "tBodyAccJerk.Mean.Z" mean of z axis component of jerk of body acceleration

[,12] "tBodyAccJerk.StDev.X" standard deviation of x axis component of jerk of body acceleration,  m/s^3                
[,13] "tBodyAccJerk.StDev.Y" standard deviation of y axis component of jerk of body acceleration,                  
[,14] "tBodyAccJerk.StDev.Z" standard deviation of z axis component of jerk of body acceleration,                  

[,15] "tBodyGyro.Mean.X" mean of x axis component of body velocity,  m/s                    
[,16] "tBodyGyro.Mean.Y" mean of y axis component of body velocity,                      
[,17] "tBodyGyro.Mean.Z" mean of z axis component of body velocity,                      

[,18] "tBodyGyro.StDev.X"  standard deviation of x axis component of body velocity,  m/s                    
[,19] "tBodyGyro.StDev.Y"  standard deviation of y axis component of body velocity,                    
[,20] "tBodyGyro.StDev.Z"  standard deviation of z axis component of body velocity,                    

[,21] "tBodyGyroJerk.Mean.X" mean of x axis component of jerk of body ,  m/s^3                  
[,22] "tBodyGyroJerk.Mean.Y" mean of y axis component of jerk of body,                  
[,23] "tBodyGyroJerk.Mean.Z" mean of z axis component of jerk of body,

[24] "tBodyGyroJerk.StDev.X" I have no clue, jerk of velocity!???                
[25] "tBodyGyroJerk.StDev.Y"                  
[26] "tBodyGyroJerk.StDev.Z"

[27] "tBodyAcc.Mag.Mean" range (max-min)  of mean body acceleration                     
[28] "tBodyAcc.Mag.StDev" range (max-min)  of standard deviation of  body acceleration

[29] "tBodyAccJerk.Mag.Mean" range (max-min)  of standard deviation of  body acceleration
[30] "tBodyAccJerk.Mag.StDev" 

[31] "tBodyGyro.Mag.Mean"                     
[32] "tBodyGyro.Mag.StDev"  

[33] "tBodyGyroJerk.Mag.Mean"                 
[34] "tBodyGyroJerk.Mag.StDev" 

Frequency domain variables (after FFT processing)
[35] "fBodyAcc.Mean.X"   mean frequency of x component of body accelaration, Hz                       
[36] "fBodyAcc.Mean.Y"                        
[37] "fBodyAcc.Mean.Z"                        
[38] "fBodyAcc.StDev.X"                       
[39] "fBodyAcc.StDev.Y"                       
[40] "fBodyAcc.StDev.Z"                       
[41] "fBodyAccJerk.Mean.X"                    
[42] "fBodyAccJerk.Mean.Y"                    
[43] "fBodyAccJerk.Mean.Z"                    
[44] "fBodyAccJerk.StDev.X"                   
[45] "fBodyAccJerk.StDev.Y"                   
[46] "fBodyAccJerk.StDev.Z"                   
[47] "fBodyAccJerk.MeanFreq.X"                
[48] "fBodyAccJerk.MeanFreq.Y"                
[49] "fBodyAccJerk.MeanFreq.Z"                
[50] "fBodyGyro.Mean.X"                       
[51] "fBodyGyro.Mean.Y"                       
[52] "fBodyGyro.Mean.Z"                       
[53] "fBodyGyro.StDev.X"                      
[54] "fBodyGyro.StDev.Y"                      
[55] "fBodyGyro.StDev.Z"                      
[56] "fBodyGyro.MeanFreq.X"                   
[57] "fBodyGyro.MeanFreq.Y"                   
[58] "fBodyGyro.MeanFreq.Z"                   
[59] "fBodyAcc.Mag.Mean"                      
[60] "fBodyAcc.Mag.StDev"                     
[61] "fBodyBodyAccJerk.Mag.Mean"              
[62] "fBodyBodyAccJerk.Mag.StDev"             
[63] "fBodyBodyGyro.Mag.Mean"                 
[64] "fBodyBodyGyro.Mag.StDev"                
[65] "fBodyBodyGyro.Mag.MeanFreq" 

Angles between vectors and gravitation
[66] "angleBetw.Gravity.tBodyAccMean"  Angle between gravity vector and mean body accelaration, rad       
[67] "angleBetw.GravityMean.tBodyAccJerkMean" 
[68] "angleBetw.Gravity.tBodyGyroMean"        
[69] "angleBetw.GravityMean.tBodyGyroJerkMean"
[70] "angleBetw.GravityMean.X"  angle between x axis of the coordinate system attached to the recording device and the gravity vector, rad            
[71] "angleBetw.GravityMean.Y"    y axis            
[72] "angleBetw.GravityMean.Z" z axis

