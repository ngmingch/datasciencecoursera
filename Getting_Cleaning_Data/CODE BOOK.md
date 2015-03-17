How the tidy data sets are derived
===================================
1. The data in the subject_train.txt, X_train.txt and y_train.txt files are joined to form the training set. 

2. The data in the subject_test.txt, X_test.txt and y_test.txt files are joined to form the test set.

3. The training and test sets are then row blinded to form one data set. A new field is added to differentiate then training and test records.

4. Then variables containing the words “mean” and “std” are then extracted to form the data in x_combined_meanstd.txt

5. Group the data table by activity and subject.

6. Summarise each variable to obtain the average (i.e. mean) of the values in the data table. The data in x_combined_meanstd_average.txt is derived.

List of Variables
==================
activity
subject
ave-tBodyAcc-mean()-X
ave-tBodyAcc-mean()-Y
ave-tBodyAcc-mean()-Z
ave-tGravityAcc-mean()-X
ave-tGravityAcc-mean()-Y
ave-tGravityAcc-mean()-Z
ave-tBodyAccJerk-mean()-X
ave-tBodyAccJerk-mean()-Y
ave-tBodyAccJerk-mean()-Z
ave-tBodyGyro-mean()-X
ave-tBodyGyro-mean()-Y
ave-tBodyGyro-mean()-Z
ave-tBodyGyroJerk-mean()-X
ave-tBodyGyroJerk-mean()-Y
ave-tBodyGyroJerk-mean()-Z
ave-tBodyAccMag-mean()
ave-tGravityAccMag-mean()
ave-tBodyAccJerkMag-mean()
ave-tBodyGyroMag-mean()
ave-tBodyGyroJerkMag-mean()
ave-fBodyAcc-mean()-X
ave-fBodyAcc-mean()-Y
ave-fBodyAcc-mean()-Z
ave-fBodyAcc-meanFreq()-X
ave-fBodyAcc-meanFreq()-Y
ave-fBodyAcc-meanFreq()-Z
ave-fBodyAccJerk-mean()-X
ave-fBodyAccJerk-mean()-Y
ave-fBodyAccJerk-mean()-Z
ave-fBodyAccJerk-meanFreq()-X
ave-fBodyAccJerk-meanFreq()-Y
ave-fBodyAccJerk-meanFreq()-Z
ave-fBodyGyro-mean()-X
ave-fBodyGyro-mean()-Y
ave-fBodyGyro-mean()-Z
ave-fBodyGyro-meanFreq()-X
ave-fBodyGyro-meanFreq()-Y
ave-fBodyGyro-meanFreq()-Z
ave-fBodyAccMag-mean()
ave-fBodyAccMag-meanFreq()
ave-fBodyBodyAccJerkMag-mean()
ave-fBodyBodyAccJerkMag-meanFreq()
ave-fBodyBodyGyroMag-mean()
ave-fBodyBodyGyroMag-meanFreq()
ave-fBodyBodyGyroJerkMag-mean()
ave-fBodyBodyGyroJerkMag-meanFreq()
ave-angle(tBodyAccMean,gravity)
ave-angle(tBodyAccJerkMean),gravityMean)
ave-angle(tBodyGyroMean,gravityMean)
ave-angle(tBodyGyroJerkMean,gravityMean)
ave-angle(X,gravityMean)
ave-angle(Y,gravityMean)
ave-angle(Z,gravityMean)
ave-tBodyAcc-std()-X
ave-tBodyAcc-std()-Y
ave-tBodyAcc-std()-Z
ave-tGravityAcc-std()-X
ave-tGravityAcc-std()-Y
ave-tGravityAcc-std()-Z
ave-tBodyAccJerk-std()-X
ave-tBodyAccJerk-std()-Y
ave-tBodyAccJerk-std()-Z
ave-tBodyGyro-std()-X
ave-tBodyGyro-std()-Y
ave-tBodyGyro-std()-Z
ave-tBodyGyroJerk-std()-X
ave-tBodyGyroJerk-std()-Y
ave-tBodyGyroJerk-std()-Z
ave-tBodyAccMag-std()
ave-tGravityAccMag-std()
ave-tBodyAccJerkMag-std()
ave-tBodyGyroMag-std()
ave-tBodyGyroJerkMag-std()
ave-fBodyAcc-std()-X
ave-fBodyAcc-std()-Y
ave-fBodyAcc-std()-Z
ave-fBodyAccJerk-std()-X
ave-fBodyAccJerk-std()-Y
ave-fBodyAccJerk-std()-Z
ave-fBodyGyro-std()-X
ave-fBodyGyro-std()-Y
ave-fBodyGyro-std()-Z
ave-fBodyAccMag-std()
ave-fBodyBodyAccJerkMag-std()
ave-fBodyBodyGyroMag-std()
ave-fBodyBodyGyroJerkMag-std()
