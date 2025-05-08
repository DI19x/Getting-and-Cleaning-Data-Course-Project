library(dplyr)

# 0) Loading the Data
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# 1) Merge the Training and Test Sets to Create 1 Data Set
alltrain <- cbind(x_train, y_train, subject_train)
alltest <- cbind(x_test, y_test, subject_test)
finaldata <- rbind(alltrain, alltest)

# 2) Extracts Only the Measurements on the Mean and Standard Deviation for Each Measurement
TidyData <- finaldata %>% select(subject, code, contains("mean"), contains("std"))

# 3) Uses Descriptive Activity Names to Name the Activities in the Data Set
TidyData$code <- activities[TidyData$code, 2]

# 4) Appropriately Labels the Data Set with Descriptive Variable Names
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

# 5) From the Data Set in Step 4, Creates a Second, Independent Tidy Data Set with the Average of Each Variable for Each Activity and Subject
FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

# 6) Upload Data Set as a Text File
write.table(FinalData, "FinalData.txt", row.name=FALSE)