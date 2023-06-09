# CleanDataWeek4
JHU Getting and Cleaning Data Week 4 Project


# Assignment

Create one R script called run_analysis.R that does the following. 
1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names. 
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Final Output
The tidySet.txt text file containing the average for each mean and std measurement by actvity and student 

# Data to be Used

Data to be used in this project is data collected from the accelerometers from the Samsung Galaxy S smartphone.

Data Source:
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
Data Description:
 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

# Script Overview
The run_analysis.R script performs the following setps to achieve the assignment goals:
1.  Downloads source zip file (to data folder of working directory)
2.  Unzips file (to data folder of working directory)
3.  Loads required files (readfile for x/y/subject test and train files; features and activity_labels)
4.  Defines informative column names (columnames using features data set for measurement variables and )
5.  Builds test and training sets (cbind source files subject+x+y)
6.  Merges test and training sets (rbind the individual test and training sets)
7.  Creates subset with mean and std columns (columns that contain any of the following literals "activityId","subjectId","mean()","std()" using grepl across the columNames of the dataset)
8.  Merges activity labels to add meaningful activity names to data set (merge mean and std data sets with activity labels on activityId)
9.  Tidies data starting by removing activityId
10. Groups data by activity and subjectId (group by activity and subjectId)
11. Calculates mean for mean and std measurements (summarize the mean across all numeric columns with the activity and subjectId group by)
12. Orders data set by activity and subjectId (order_by)
13. Prints tidy data to file (tidySet.txt written to local directory)

