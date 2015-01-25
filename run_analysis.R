
## Run_Analysis.r code for Coursera project - Getting Data class

## Read the different test data files for activity,subject and observations for activity and subject
activity_test_ds <- read.table("./Getting Data class/UCI HAR Dataset/test/y_test.txt")
info_test_ds <- read.table("./Getting Data class/UCI HAR Dataset/test/x_test.txt")
subject_test_ds <- read.table("./Getting Data class/UCI HAR Dataset/test/subject_test.txt")

## Merge subject,activity and observation into one data frame and subset to get only mean and std deviation values
merged_test_ds <- cbind(subject_test_ds,activity_test_ds,info_test_ds)
subset_data_test <- merged_test_ds[,1:8]

## Assign descriptive names to the subset data
names(subset_data_test)[1:8] <- c("Subject","Activity","Body_Accl_Mean_X","Body_Accl_Mean_Y","Body_Accl_Mean_Z","Body_Accl_Std_Dev_X","Body_Accl_Std_Dev_Y","Body_Accl_Std_Dev_Z")

## Repeat the reading and merging for the train data set
activity_train_ds <- read.table("./Getting Data class/UCI HAR Dataset/train/y_train.txt")
info_train_ds <- read.table("./Getting Data class/UCI HAR Dataset/train/x_train.txt")
subject_train_ds <- read.table("./Getting Data class/UCI HAR Dataset/train/subject_train.txt")

merged_train_ds <- cbind(subject_train_ds,activity_train_ds,info_train_ds)
subset_data_train <- merged_train_ds[,1:8]
names(subset_data_train)[1:8] <- c("Subject","Activity","Body_Accl_Mean_X","Body_Accl_Mean_Y","Body_Accl_Mean_Z","Body_Accl_Std_Dev_X","Body_Accl_Std_Dev_Y","Body_Accl_Std_Dev_Z")


## Merge the test and train data into one data frame
full_merge <- rbind(subset_data_test,subset_data_train)

## Create a tidy data frame by getting mean of mean and std deviation and group by subject and activity
tidy_data <- ddply(full_merge,c('Subject','Activity'), function (x) c(mean_of_x = mean(x$Body_Accl_Mean_X), mean_of_y = mean(x$Body_Accl_Mean_Y), mean_of_z = mean(x$Body_Accl_Mean_Z), mean_std_x = mean(x$Body_Accl_Std_Dev_X), mean_std_y = mean(x$Body_Accl_Std_Dev_Y), mean_std_z = mean(x$Body_Accl_Std_Dev_Z)))

## Assign more descriptive column names
names(tidy_data)[1:8] <- c("Subject","Activity","Body_Accl_Mean_Of_mean_X","Body_Accl_Mean_of_mean_Y","Body_Accl_Mean_of_mean_Z","Body_Accl_Mean_of_Std_Dev_X","Body_Accl_Mean_of_Std_Dev_Y","Body_Accl_Mean_of_Std_Dev_Z")

## Write data to a file
write.table(tidy_data,"./Getting Data class/UCI HAR Dataset/tidy_data.txt")