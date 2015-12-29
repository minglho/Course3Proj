# Code book for `meanByActSubj.txt` 

## Data description

The space-delimited file `meanByActSubj.txt` contains a header. It is the result of processing the [raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) obtained from [this site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Each observation of the raw data is a 2.54-sec sliding window. Sensor telemetries were taken over the time window. The data about each time window include the subject from whom the telemtries were taken, the activity that the subject performed, and summary statistics of the various telemetries over the time window (e.g. mean of the y-components of the body acceleration sampled at 50 Hz over the 2.54-sec window, standard deviation of the z-component of the body gyroscope).

In `meanByActSubj.txt`, each observation represents a subject performing a specific activity. Each variable represents the mean of the subset of the corresponding variable in the raw data that match the given subject performing the specified activity. In `meanByActSubj.txt`, only the summary statistics of mean and standard deviations from the raw data is included. Refer to `features_info.txt` in the zip file containing the raw data for the variables in there. 

## List of variables
* Activity: 6 levels: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS and WALKING_UPSTAIRS. It is the type of activity performed when the corresponding measurements were taken
* Subject: Code used to identify the subjects, ranging from 1 to 30.

The following variables have counterparts in the raw data. The range for them are -1 to 1.

* tBodyAccMEANX
* tBodyAccMEANY
* tBodyAccMEANZ
* tBodyAccSTDX
* tBodyAccSTDY
* tBodyAccSTDZ
* tGravityAccMEANX
* tGravityAccMEANY
* tGravityAccMEANZ
* tGravityAccSTDX
* tGravityAccSTDY
* tGravityAccSTDZ
* tBodyAccJerkMEANX
* tBodyAccJerkMEANY
* tBodyAccJerkMEANZ
* tBodyAccJerkSTDX
* tBodyAccJerkSTDY
* tBodyAccJerkSTDZ
* tBodyGyroMEANX
* tBodyGyroMEANY
* tBodyGyroMEANZ
* tBodyGyroSTDX
* tBodyGyroSTDY
* tBodyGyroSTDZ
* tBodyGyroJerkMEANX
* tBodyGyroJerkMEANY
* tBodyGyroJerkMEANZ
* tBodyGyroJerkSTDX
* tBodyGyroJerkSTDY
* tBodyGyroJerkSTDZ
* tBodyAccMagMEAN
* tBodyAccMagSTD
* tGravityAccMagMEAN
* tGravityAccMagSTD
* tBodyAccJerkMagMEAN
* tBodyAccJerkMagSTD
* tBodyGyroMagMEAN
* tBodyGyroMagSTD
* tBodyGyroJerkMagMEAN
* tBodyGyroJerkMagSTD
* fBodyAccMEANX
* fBodyAccMEANY
* fBodyAccMEANZ
* fBodyAccSTDX
* fBodyAccSTDY
* fBodyAccSTDZ
* fBodyAccJerkMEANX
* fBodyAccJerkMEANY
* fBodyAccJerkMEANZ
* fBodyAccJerkSTDX
* fBodyAccJerkSTDY
* fBodyAccJerkSTDZ
* fBodyGyroMEANX
* fBodyGyroMEANY
* fBodyGyroMEANZ
* fBodyGyroSTDX
* fBodyGyroSTDY
* fBodyGyroSTDZ
* fBodyAccMagMEAN
* fBodyAccMagSTD
* fBodyBodyAccJerkMagMEAN
* fBodyBodyAccJerkMagSTD
* fBodyBodyGyroMagMEAN
* fBodyBodyGyroMagSTD
* fBodyBodyGyroJerkMagMEAN
* fBodyBodyGyroJerkMagSTD
