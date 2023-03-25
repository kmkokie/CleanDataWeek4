CodeBook Description
This document is a codebook that provides descriptions of the variables, the data, and all transformations and work performed to tidy the data.



##The Data Source

Source data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description of the dataset from the source website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

##The data

The dataset includes the following files :

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

##The following files are available for the train and test data. Their descriptions are equivalent.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

##LIBRARIES USED
- dplyr

##VARIABLES USED
- dataZipUrl = url for source data file to download 
- dataDir = directory where data (zip and unzipped) is stored
- files = list of files included in the data download
- xtest = table to store contents of X_test.txt
- ytest = table to store contents of y_test.txt
- subjectTest = table to store contents of subject_test.txt
- xtrain = table to store contents of X_train.txt
- ytrain = table to store contents of y_train.txt
- subjectTrain = table to store contents of subject_train.txt
- activityLabels = table to store contents of activity_labels.txt
- features = table to store contents of features.txt"
- testSet = complete set of test data (subject+x+y)
- trainSet = complete set of training data (subject+x+y)
- completeSet = combined set of test and training data
- colNames = list of column in the complete data set
- meanAndStd = logical vector to identify columns that are activityId, subjectID or contain mean() or std() 
- meanStdSet= subset dataset of the desired columns  
- namesMeanStdSet = data set containing activity id, activity name, subject id and mean and std related columns
- tidySet = final "clean" data set that contains the avg for each mean/std measurement by activity id/subject id sorted by activity id and subject id

##Transformation Specifics
SCRIPT OVERVIEW
The script performs the following setps to achieve the assignment goals:
1.  Download source zip file (to data folder of working directory)
2.  Unzip file (to data folder of working directory)
3.  Load required files (readfile for x/y/subject test and train files; features and activity_labels)
4.  Define informative column names (columnames using features data set for measurement variables and )
5.  Build test and training sets (cbind source files subject+x+y)
6.  Merge test and training sets (rbind the individual test and training sets)
7.  Create subset with mean and std columns (columns that contain any of the following literals "activityId","subjectId","mean()","std()" using grepl across the columNames of the dataset)
8.  Merge activity labels to add meaningful activity names to data set (merge mean and std data sets with activity labels on activityId)
9.  Tidy data starting by removing activityId
10. Group data by activity and subjectId (group by activity and subjectId)
11. Calculate mean for mean and std measurements (summarize the mean across all numeric columns with the activity and subjectId group by)
12. Order data set by activity and subjectId (order_by)
13. Print tidy data to file (tidySet.txt written to local directory)
