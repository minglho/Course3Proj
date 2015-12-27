# Download zipped data file if it does not exist, and extract. ----
zipname = "UCI_HAR.zip"
if (!file.exists(zipname)) {
    trainingURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(trainingURL, destfile = zipname)
}
if (!file.exists("UCI HAR Dataset")) unzip(zipname)

# Creating mask to extract columns with "mean()" and "std()" ----
# in the variable name.

dfF <- ## Read data frame of features
    read.table("UCI HAR Dataset/features.txt") 
colMask <- grepl("mean\\(\\)",dfF[,2]) | grepl("std\\(\\)",dfF[,2])
colClasses = rep("NULL", n)
colClasses[colMask] <- "numeric"

# Create table of activity labels
dfActLabels <- read.table("UCI HAR Dataset/activity_labels.txt",
                         col.names = c("Code","Activity"))


getMergedFile <- function (case) {
## Preconditin: 'case' is either "train" or "test"
## Postcondition: return data frame for 'case' compliant with 
##     project specs: 
##     1. Only measurements of mean and std for each measurement.
##     2. Use descriptive activity names. 
##     3. Use descriptive variable names.  
    
    # Set up data file paths
    if (!(case == "train" | case == "test")) stop()
    dataFile = paste("UCI HAR Dataset/",case,"/X_",case,".txt",sep = "")
    labelFile = paste("UCI HAR Dataset/",case,"/Y_",case,".txt",sep = "")
    subjFile = paste("UCI HAR Dataset/",case,"/subject_",case,".txt",sep = "")
    
    # Read in data tables
    dfData <- read.table(dataFile, colClasses = colClasses,
                         col.names = dfF[,2])
    dfLabels <- read.table(labelFile, col.names = "Code")
    dfLabels <- merge(dfLabels, dfActLabels)
    dfSubj <- read.table(subjFile, col.names = "Subject")
    
    
    cbind(dfsubj, dfData, dfLabels$Activity)
}

## Data frame `df` is the training and test sets merged ----
## with the specified columns, descriptive variable names,
## and descriptive activity names.
df <- rbind(getMergedFile("test"),getMergedFile("train"))



