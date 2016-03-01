## Loading activity labels and features

setwd("/Getting and Cleaning Data/Week 4/getdata-projectfiles-UCI HAR Dataset (1)/UCI HAR Dataset")

activityLabels <- read.table("activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("features.txt")
features[,2] <- as.character(features[,2])


## Extracting only the data on mean and standard deviation

featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)


## Importing the datasets

setwd("/Getting and Cleaning Data/Week 4/getdata-projectfiles-UCI HAR Dataset (1)/UCI HAR Dataset/train")

train <- read.table("X_train.txt")[featuresWanted]
trainActivities <- read.table("y_train.txt")
trainSubjects <- read.table("subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

setwd("/Getting and Cleaning Data/Week 4/getdata-projectfiles-UCI HAR Dataset (1)/UCI HAR Dataset/test")

test <- read.table("X_test.txt")[featuresWanted]
testActivities <- read.table("y_test.txt")
testSubjects <- read.table("subject_test.txt")
test <- cbind(testSubjects, testActivities, test)


## Merging datasets and adding labels

allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featuresWanted.names)


## Converting activities & subjects into factors

library(reshape2)

allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
