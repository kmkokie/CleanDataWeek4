##This script takes data collected from the accelerometers from the Samsung 
##Galaxy S smartphone.  It then performs the following tasks on the dataset.
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for 
##     each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set 
##     with the average of each variable for each activity and each subject.

library(dplyr)
library(data.table)

##download and unzip dataset file
if(!file.exists("./data")){dir.create("./data")}
dataZipUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataZipUrl,destfile="./data/DataFiles.zip",method="cur")
unzip(zipfile="./data/DataFiles.zip",exdir="./data")

##confirm the new data structure and obtain a list of target files
list.files("./data")

dataDir = file.path("./data/UCI HAR Dataset")
files = list.files(dataDir, recursive=TRUE)
files

##read test data
xtest <- read.table(file.path(dataDir,"test","X_test.txt"), header = FALSE)
ytest <- read.table(file.path(dataDir,"test","y_test.txt"), header = FALSE)
subjectTest <- read.table(file.path(dataDir,"test","subject_test.txt"), header = FALSE)

##read train data
xtrain <- read.table(file.path(dataDir,"train","X_train.txt"), header = FALSE)
ytrain <- read.table(file.path(dataDir,"train","y_train.txt"), header = FALSE)
subjectTrain <- read.table(file.path(dataDir,"train","subject_train.txt"), header = FALSE)

##read lookup tables
activityLabels <- read.table(file.path(dataDir,"activity_labels.txt"), header = FALSE)
features <- read.table(file.path(dataDir,"features.txt"), header = FALSE)

##create meaningful column names for the new datasets
## x files contain rows for each of the values in the features data set
## y files contain activity ids
## subject files contain subject ids
colnames(xtest) = features[,2]
colnames(ytest) = "activityId"
colnames(subjectTest) = "subjectId"

colnames(xtrain) = features[,2]
colnames(ytrain) = "activityId"
colnames(subjectTrain) = "subjectId"

colnames(activityLabels) = c("activityId","activity")

## Step 1 Completion:  merge training and test data sets
## build the test and train datasets and then merge them together
## test/train = y (activity type) + subject + x (measurements)
testSet <- cbind(ytest,subjectTest,xtest)
trainSet <- cbind(ytrain, subjectTrain, xtrain)
completeSet <- rbind(trainSet,testSet)

## STEP 2:  Extract the mean and standard deviation of each measurement 
## list of colnames = each mesaurement
colNames <- colnames(completeSet)
## identify colnames that = activityId, subjectId or contain "mean" or "std"
meanAndStd <- (grepl("activityId", colNames) |
                       grepl("subjectId",colNames)|
                       grepl("mean()", colNames)|grepl("std()",colNames))

##subset dataset by the columns meeting the criteria above
meanStdSet <-completeSet[,meanAndStd ==TRUE]

## STEP 3:  Add descriptive activity names to the dataset
## merge Mean/STD data set with the activity names data set
namesMeanStdSet <- merge(activityLabels,meanStdSet, by="activityId", all.x=TRUE)

## STEP 5:  Create an independent tidy data set w/ avg for each 
## var/activity/subject
tidySet <- namesMeanStdSet[,-1]
## group by activitId/subjectId; calc mean across all numeric columns and 
## reorder dataset in order of activityId/subjectId
tidySet <-tidySet %>% 
        group_by(activity,subjectId) %>%
        summarize(across(where(is.numeric), \(x) mean(x,na.rm=TRUE)), .groups="keep") %>%
        arrange(activity, subjectId)

## write tidy output to working directory
write.table(tidySet,"tidySet.txt",row.names=FALSE)