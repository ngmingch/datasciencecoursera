## This script assumes your working directory is "UCI HAR Dataset

## Load libraries
library (dplyr)
library (tidyr)

## Read features, activity and subject lists
features_set<-read.table("./features.txt")
activity_set<-read.table("./activity_labels.txt")
names(activity_set)<-c("activity_id", "activity")

## Read training and test data sets
x_train_df<-read.table("./train/X_train.txt")
names(x_train_df)<-features_set[,2]
x_train_subj_set <-read.table("./train/subject_train.txt")
x_train_act_set <-read.table("./train/y_train.txt")
x_train_df["set_type"]="training"
x_train_df["subject"]=x_train_subj_set
x_train_df["activity_id"]=x_train_act_set

x_test_df<-read.table("./test/X_test.txt")
names(x_test_df)<-features_set[,2]
x_test_subj_set <-read.table("./test/subject_test.txt")
x_test_act_set <-read.table("./test/y_test.txt")
x_test_df["set_type"]="test"
x_test_df["subject"]=x_test_subj_set
x_test_df["activity_id"]=x_test_act_set

## Combine training and test data sets
x_combined_df<-rbind(x_train_df, x_test_df)

## Join with activity and subject lists
x_combined_df<-left_join(activity_set, x_combined_df)

## Extracts columns with means and standard deviations
x_combined_dt<-tbl_df(x_combined_df)
x_combined_meanstd_dt<-select(x_combined_dt, c(activity, subject, set_type, contains("mean"), contains ("std")))

## Group by activity and subject
x_combined_meanstd_dt<-arrange(x_combined_meanstd_dt, activity, subject, set_type)
by_act_subj <- group_by(x_combined_meanstd_dt, activity, subject)
by_act_subj_average <- summarise_each(by_act_subj, funs(mean), -activity, -subject, -set_type)

## Write to files
write.table(x_combined_meanstd_dt, "./x_combined_meanstd.txt", row.name=FALSE, col.name=FALSE)
write.table(by_act_subj_average, "./x_combined_meanstd_average.txt", row.name=FALSE, col.name=FALSE)
