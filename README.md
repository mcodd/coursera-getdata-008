# coursera-getdata-008

The `run_analysis.R` script in this repo downloads and tidies the data
found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
The raw data is from accelerometers from the Samsung Galaxy S smartphone.

The CodeBook.md file here describes the tidy variables, the raw data, and the transformations performed to clean up the data.

### Execution instructions

Executing run_analysis.R will download and extract the data if that
has not already been done.  Subsequently, it loads the data and
then extracts only the measurements on the mean and standard deviation
for each measurement.  After tidying the data by inserting descriptive
activitiy names and variable names, it outputs the tidy dataset to a
file called `getdata-008-project-results.csv`.

### Files in the raw dataset

The raw dataset extracts into a directory called `UCI HAR Dataset`.  Within
that directory are the following files:

* `UCI HAR Dataset`
  * `README.txt` - a description of the raw dataset and how the data was gathered
  * `features.txt` - a list of the 561 variables gathered, mapping their numbers to feature names
  * `features_info.txt` - definitions and descriptions of the 561 variables found in `features.txt`
  * `activity_labels.txt` - a list of the 6 activities performed, mapping their numbers to activity name
  * test and train subdirectories - contain the raw data from the test and training datasets as described in the `README.txt` file

### Required libraries

The code was written and tested using R version 3.1.1.

To execute `run_analysis.R`, you will need the following libraries installed:

* `LaF`
* `data.table`
* `reshape2`

