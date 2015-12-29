### This file produces 
### 1. the data frame `df` that is the merged data set satisfying
###    the project spec.
### 2. the data frame `avgdf` whose columns are the average of 
###    the correpsonding columns in `df` for each activity and 
###    each subject.

#### Code to produce `df`

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
colClasses = rep("NULL", nrow(dfF))
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
    
    
    cbind(dfSubj, dfData, Activity = dfLabels$Activity)
}

## Data frame `df` is the training and test sets merged ----
## with the specified columns, descriptive variable names,
## and descriptive activity names.
df <- rbind(getMergedFile("test"),getMergedFile("train"))
varNames = names(df)
varNames <- gsub("\\.", "", varNames)
varNames <- gsub("mean", "MEAN", varNames)
varNames <- gsub("std", "STD", varNames)
names(df) <- varNames

#### Code to product `avgdf`

library(dplyr)

df <- mutate(df, Act_Subj = paste(as.character(Activity),
                            as.character(Subject),
                            sep = "."))
# s is a list of data frames, where each matches a combination
# of activity and subject.
s <- split(df,df$Act_Subj) 
s <- lapply(s, function(elt) { # Remove non-numeric columns
        elt$Subject <- NULL
        elt$Activity <- NULL
        elt$Act_Subj <- NULL
        elt
     })

# s is a list of dataframes.
# Why is it that the following works:
#    apply(s[[1]], 2, mean)
# but not 
#    lapply(s, apply, MARGIN = 2, FUN = mean)

avgdf <- NULL
for(i in 1:length(s)) {
    # Build `avgdf` by averaging every column for each 
    # data frame in `s`, and add the result as a row to `avgdf`.
    avgdf <- rbind(avgdf, apply(s[[i]], 2, mean))
}
# Add descriptive column names.
avgdf <- data.frame(avgdf, row.names = names(s))

# Get Acitivity and Subject columns for tidy data set.
id <- names(s)
Act <- NULL
Subj <- NULL
for (i in 1:length(id)) {
    varList <- strsplit(id[i],"\\.")
    Act <- c(Act, varList[[1]][1])
    Subj <- c(Subj, varList[[1]][2])
}

# Add Acitivity and Subject columns for tidy data set.
avgdf <- data.frame(Activity = Act, Subject = Subj, avgdf)

write.table(avgdf, file = "meanByActSubj.txt", 
            row.names = FALSE, quote = FALSE)