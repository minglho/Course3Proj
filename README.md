# Running the script to process data

The script `run_analysis.R` contains the code for this course project and must be located in the working directory to run. The command `source("run_analysis.R")` downloads the [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) containing the raw data from the Internet to the working directory, unzips it, process it, and creates `meanByActSubj.txt` containing the processed data.

# Processing the raw data

## Raw data description

There are two sets of raw data to be processed and merged: A training and test set. Each set is processed separately and identically, and the two are merged into the data frame `df`.

For more elaborate infomtion about the raw data beyond what's described below, see `README.txt` in the downloaded zip file. 

For the raw data sets, each observation represents a sliding window of 2.56 sec, and each measurement variable represents a summary statistics of a sensor telemetry over a 2.56-sec time window. There are many summary statistics in the raw data sets, and we will extract only the variables that are either the mean or standard deviation of a sensor telemetry over a time window.

## Merging raw data files 

The training data set consists of three files, each without a header. The rows match across across these three files:
* `X_train.txt` contains the measurement variables described above. The names of the variables are found in the file `features.txt`. Only the needed columns in the file is read.
* `Y_train.txt` contains the code identifying the activity performed when the telemetry was taken. The codes and the corresponding activities they represent are stored in the file `activity_labels.txt`. 
* `subject_train.txt` contains the code identifying the subject.
The three files for the test data set are similarly named.

For each data set, the three files are merged together, retaining only the variables of interest for the assignment. It is also merged with `activity_labels.txt` using the activity code as the key to add activity names to the dataset.

### Transforming the variable names

The variable names in the raw data include the three characters for left parenthesis, right parenthesis, and hyphen. When reading these as a character vector used for the parameter `col.names` in `read.table()`, these three characters were turned into periods. To clean up, these periods were removed from the variable names, and the character strings "mean" and "sd" in the variable names were turned to uppercase for ease of reading.

## Creating a summarized data set

The output file `meanByActSubj.txt` summarizes the raw data by taking the mean of the subset of each measurement variable matching each activity and each subject. To facilitate this, we create in `df` the variable `Act_Subj` concatenating the variables `Activity` and `Subject`. 

We the split `df` into a list `s` of data frames by `df$Act_Subj`. For each data frame in `s`, we remove those variables that are not measurement variables to obtain only numerical values, so that the mean of each measurement variable can easily be taken using `apply()`. The results of applying `apply()` to each data frame in `s` are combined to form the data frame `avgdf`, which will be written out to `meanByActSubj.txt` with a header but without row names. We also split `names(s)` to form the variables `Activity` and `Subject` for the tidy data set `avgdf`. 

See `CodeBook.md` for a complete set of variables.
