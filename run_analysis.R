#Download the file to our environment
filename <- "Coursera_DS3_Final.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
# We download the final dataset zip

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
# TEST #
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
# TRAIN #
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")



#Merges the training and the test sets to create one data set.

x_data <- rbind(x_train, x_test) # one object
y_data <- rbind(y_train, y_test) # one object
subject <- rbind(subject_train, subject_test) # one object
Merged_Data <- cbind(subject, y_data, x_data) # One object of the three

#Extracts only the measurements on the mean and standard deviation for each measurement.
library(dplyr)
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std")) # Get the mean and the st desviation

#Uses descriptive activity names to name the activities in the data set.

TidyData$code <- activities[TidyData$code, 2]
#Appropriately labels the data set with descriptive variable names.
# In this step we only have to change the names of the variables, using the gsub() function ( ?gsub)
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))



#From the data set in this step , creates a second, independent tidy data set with 
# the average of each variable for each activity and each sub.

# Finally, we can write the tidy_dataset-txt using the following function, with the help of  %>% operator:
tidy_dataset <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(tidy_dataset, "tidy_dataset", row.name=FALSE)

str(tidy_dataset)
dim(tidy_dataset) # 180 obs  and 88 variables
summary(tidy_dataset) #we can check that we haven't got any strange value'
