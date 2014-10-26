# getdata-008
# project requirements:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with
#    the average of each variable for each activity and each subject.

# the LaF library allows us to quickly obtain a handle on the large fixed-width
# files in this data set.  Using read.fwf takes too long.
library(LaF)
library(data.table)

# first download and unzip the data if we haven't already
local_file<-"getdata-projectfiles-UCI-HAR-Dataset.zip"
remote_file_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
unzip_directory<-"UCI HAR Dataset"
if (!file.exists(local_file)) {
    download.file(remote_file_url,destfile=local_file,method="curl")
}
if(!file.exists(unzip_directory)) {
    unzip(local_file)
}

####
# get feature names and activity names into vectors
feature_names_df<-fread(paste(unzip_directory,"/features.txt", sep = ""))
feature_names<-feature_names_df$V2
activity_names_df<-fread(paste(unzip_directory,"/activity_labels.txt", sep =""))
activity_names<-activity_names_df$V2

####
# part 2 of the project requires us to select only the mean and std measurements,
# so get a list of which indexes those are in the features list
feature_names_mean_std_idx<-grep("mean\\(|std\\(",feature_names)

####
# part 4 requires us to tidy up the variable names, so we'll clean that
# up here.
# first remove the ()'s
feature_names<-gsub("\\(\\)","",feature_names)
# replace - with _ as we do not want to confuse the subtraction operator with
# variable names.  We will not be forcing all lower-case or removing the separator
# entirely because that makes the variables too long and unreadable.
feature_names<-gsub("-","_",feature_names)
# now fix the incorrectly-named variables with the dupe string BodyBody in them
feature_names<-gsub("BodyBody","Body",feature_names)
# replace initial "t" with "time" and "f" with "freq" to be more descriptive
feature_names<-sub("^t","time",feature_names)
feature_names<-sub("^f","freq",feature_names)
# now make it all lowercase
feature_names<-tolower(feature_names)

####
# Merge the training and the test sets to create one data frame, including named
# activities (as a factor) and a column for the subject.
# This next section effectively deals with parts 1-4 of the project.  We take care
# of test data first then repeat for training data before combining them at the end.
####
# read in the fixed-width X_test.txt file and label the columns appropriately
# based on the names in the features.txt file read in and tidied up
# above (part 4 of the project)
test_data_handle<-laf_open_fwf(paste(unzip_directory,"/test/X_test.txt",sep = ""),
                        column_widths=c(rep(16,561)),
                        column_types=rep("numeric", 561),
                        column_names=feature_names)
# create a data frame called test_data that includes only the mean/std variables
# we care about (part 2 of the project)
test_data<-test_data_handle[,feature_names_mean_std_idx]
# create a column in test_data with the integer representing the subject
test_subjects<-fread(paste(unzip_directory,"/test/subject_test.txt",sep=""),
                     data.table=FALSE)
test_data<-cbind("subject"=test_subjects$V1,test_data)
# create a factor column in the dataframe using the activity names (part 3 of
# the project)
test_activities<-fread(paste(unzip_directory,"/test/y_test.txt",sep=""),
                       data.table=FALSE)
test_data<-cbind("activityname"=cut(test_activities$V1,6,labels=activity_names),
                  test_data)

# now we do the same with train data that we just did with the test data above
train_data_handle<-laf_open_fwf(paste(unzip_directory,"/train/X_train.txt",sep = ""),
                        column_widths=c(rep(16,561)),
                        column_types=rep("numeric", 561),
                        column_names=feature_names)
train_data<-train_data_handle[,feature_names_mean_std_idx]
train_subjects<-fread(paste(unzip_directory,"/train/subject_train.txt",sep=""),
                      data.table=FALSE)
train_data<-cbind("subject"=train_subjects$V1,train_data)
train_activities<-fread(paste(unzip_directory,"/train/y_train.txt",sep=""),
                        data.table=FALSE)
train_data<-cbind("activityname"=cut(train_activities$V1,6,labels=activity_names),
                  train_data)

# now merge the two sets (train and test) into a single dataframe (part 1
# of the project)
all_data<-rbind(test_data,train_data)

####
# part 5 - create an independent tidy data set with the average of each
# variable for each activity and each subject
library(reshape2)
all_data_melt<-melt(all_data,id=c("subject","activityname"))
all_data_cast<-dcast(all_data_melt, activityname + subject ~ variable, mean)
# write out the table for uploading a project deliverable
write.table(all_data_cast, file="getdata-008-project-results.txt",sep=" ",
            row.names = FALSE)
