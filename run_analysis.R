## Set the working directory
setwd("~/Documenten/R_DOCUMENTEN/Coursera_Repo")

## load necessary packages
library(data.table)

## TASK 1: MERGE THE TRAINING AND TEST SETS TO CREATE ONE DATA SET
## ____________________________________________________________________

## load the train data in 3 tables
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
labelsTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
dataTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

## load the test data in 3 tables
subjectTest <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
labelsTest <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
dataTest <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

## merge the 3 tables by row binding
subject <- rbind(subjectTrain, subjectTest)
labels <- rbind(labelsTrain, labelsTest)
data <- rbind(dataTrain, dataTest)

## set the variable names of subject and labels
setnames(subject, "V1", "subject")
setnames(labels, "V1", "activity")

## set the variable names of the data
# load the variable names
features <- read.table("UCI HAR Dataset/features.txt",head=FALSE)
# set the variable names
names(data) = features$V2

## merge the datasets
allDataSubject_Label <- cbind(subject,labels)
allData <- cbind(allDataSubject_Label,data)

## TASK 2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION
## _____________________________________________________________________

## define which columns have the word mean() or std() in them
subsetfeatures <- features$V2[grep("mean\\(\\)|std\\(\\)",features$V2)]

## subset 'data' leaving the names from subfeatures, the subject and the activity
columnnames <- c(as.character(subsetfeatures),"subject","activity")
allData_mean_std <- subset(allData,select=columnnames)



