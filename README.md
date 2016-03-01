This is the course project for the Getting and Cleaning Data Coursera course (Week 4). The R script, run_analysis.R, follows the following steps:

1) Since the dataset is already downloaded to the local system, so we straight go to the step of loading the activity and feature info.
2) Data on mean and standard deviation is extracted.
3) Then we import both the training and test datasets, with only those columns which reflect a mean or standard deviation as we have extracted in the previous step.
4) Then we merge those 2 datasets (test and training) using a row bind, and name the columns as per requirement.
5) Convert the activity and subject columns into factors
6) At the end, we create a tidy dataset that consists of the average (mean) value of each variable for each subject and activity.

The end result is shown in the file tidy.txt.

