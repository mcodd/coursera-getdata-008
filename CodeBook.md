# coursera-getdata-008 codebook

## Study Design

The `features.txt` and `activity_labels.txt` files were read in first in order
to store the feature names and variable names.  Since we were only interested
in mean and standard deviation variables, a regular expression was used to grep out
those variables from the features list.  The `LaF` library was used to efficiently open a handle to the large data sets and the load into memory only the mean and std variables that we needed.

The feature names were tidied up by doing the following transformations on their original names from the raw dataset:
* removing parenthesis
* replacing dashes with underscores - I chose not to remove all separators from the variable names due to their length in order to preserve readability.  However, underscores were substituted for dashes given that dashes can often get confused with the subtraction operator.
* Fixed typos where the string "BodyBody" was used instead of "Body"
* Replaced leading 't' with 'time' and 'f' with 'freq'
* made the variables all lowercase

Once we had a data frame of all the raw data and tidied variable names, we read in the subject and activity files.  These files (`subject_train` and `subject_test` as well as `y_train` and `y_test` respectively) were bound to the existing data frame as the first two columns.  At this point the data frame had all the information necessary to compute the averages we needed.

The averages of each variable for each activity and subject were found using the `reshape2` library's `melt` and `dcast` functions and then written out to a file named `getdata-008-project-results.csv`.

## Code Book

The following variables are found in the final `getdata-008-project-results.csv`
file.  Variables prefixed with 'time' are measured in the time domain where 'freq' are derived in the frequency domain (details of how measurements were derived in the raw data are described in the `features_info.txt` file found in the raw data set).

* **activityname** - the name of the activity being measured (e.g. WALKING, SITTING, etc)
* **subject** - the ID number of the test subject
* **timebodyacc_mean_x** - Mean body acceleration signal on X axis
* **timebodyacc_mean_y** - Mean body acceleration signal on Y axis
* **timebodyacc_mean_z** - Mean body acceleration signal on Z axis
* **timebodyacc_std_x** - Standard deviation body acceleration signal on X axis
* **timebodyacc_std_y** - Standard deviation body acceleration signal on Y axis
* **timebodyacc_std_z** - Standard deviation body acceleration signal on Z axis
* **timegravityacc_mean_x** - Mean gravity acceleration signal on X axis
* **timegravityacc_mean_y** - Mean gravity acceleration signal on Y axis
* **timegravityacc_mean_z** - Mean gravity acceleration signal on Z axis
* **timegravityacc_std_x** - Standard deviation gravity acceleration signal on X axis
* **timegravityacc_std_y** - Standard deviation gravity acceleration signal on Y axis
* **timegravityacc_std_z** - Standard deviation gravity acceleration signal on Z axis
* **timebodyaccjerk_mean_x** - Mean jerk for body acceleration on X axis
* **timebodyaccjerk_mean_y** - Mean jerk for body acceleration on Y axis
* **timebodyaccjerk_mean_z** - Mean jerk for body acceleration on Z axis
* **timebodyaccjerk_std_x** - Standard deviation of jerk for body acceleration on X axis
* **timebodyaccjerk_std_y** - Standard deviation of jerk for body acceleration on Y axis
* **timebodyaccjerk_std_z** - Standard deviation of jerk for body acceleration on Z axis
* **timebodygyro_mean_x** - Mean body gyroscopic signal on X axis
* **timebodygyro_mean_y** - Mean body gyroscopic signal on Y axis
* **timebodygyro_mean_z** - Mean body gyroscopic signal on Z axis
* **timebodygyro_std_x** - Standard deviation of body gyroscopic signal on X axis
* **timebodygyro_std_y** - Standard deviation of body gyroscopic signal on Y axis
* **timebodygyro_std_z** - Standard deviation of body gyroscopic signal on Z axis
* **timebodygyrojerk_mean_x** - Mean jerk of body gyroscopic signal on X axis
* **timebodygyrojerk_mean_y** - Mean jerk of body gyroscopic signal on Y axis
* **timebodygyrojerk_mean_z** - Mean jerk of body gyroscopic signal on Z axis
* **timebodygyrojerk_std_x** - Standard deviation of jerk for body gyroscopic signal on X axis
* **timebodygyrojerk_std_y** - Standard deviation of jerk for body gyroscopic signal on Y axis
* **timebodygyrojerk_std_z** - Standard deviation of jerk for body gyroscopic signal on Z axis
* **timebodyaccmag_mean** - Mean of magnitude of the three-dimensional signals for body acceleration
* **timebodyaccmag_std** - Standard deviation of magnitude of the three-dimensional signals for body acceleration
* **timegravityaccmag_mean** - Mean of magnitude of the three-dimensional gravity acceleration signals
* **timegravityaccmag_std** - Standard deviation of the magnitude of the three-dimensional gravity acceleration signals
* **timebodyaccjerkmag_mean** - Mean of the magnitude of jerk across the three-dimensional signals for body acceleration
* **timebodyaccjerkmag_std** - Standard deviation of the magnitude of jerk across the three-dimensional signals for body acceleration
* **timebodygyromag_mean** - Mean of magnitude of the three-dimensional body gyroscopic signals
* **timebodygyromag_std** - Standard deviation of magnitude of the three-dimensional body gyroscopic signals
* **timebodygyrojerkmag_mean** - Mean of magnitude of the three-dimensional jerk for body gyroscopic signals
* **timebodygyrojerkmag_std** - Standard deviation of magnitude of the three-dimensional jerk for body gyroscopic signals
* **freqbodyacc_mean_x** - Mean frequency of body acceleration signal on X axis
* **freqbodyacc_mean_y** - Mean frequency of body acceleration signal on Y axis
* **freqbodyacc_mean_z** - Mean frequency of body acceleration signal on Z axis
* **freqbodyacc_std_x** - Standard deviation of frequency of body acceleration signal on X axis
* **freqbodyacc_std_y** - Standard deviation of frequency of body acceleration signal on Y axis
* **freqbodyacc_std_z** - Standard deviation of frequency of body acceleration signal on Z axis
* **freqbodyaccjerk_mean_x** - Mean jerk of frequency for body acceleration on X axis
* **freqbodyaccjerk_mean_y** - Mean jerk of frequency for body acceleration on Y axis
* **freqbodyaccjerk_mean_z** - Mean jerk of frequency for body acceleration on Z axis
* **freqbodyaccjerk_std_x** - Standard deviation of frequency for body acceleration on X axis
* **freqbodyaccjerk_std_y** - Standard deviation of frequency for body acceleration on Y axis
* **freqbodyaccjerk_std_z** - Standard deviation of frequency for body acceleration on Z axis
* **freqbodygyro_mean_x** - Mean frequency of body gyroscopic signal on X axis
* **freqbodygyro_mean_y** - Mean frequency of body gyroscopic signal on Y axis
* **freqbodygyro_mean_z** - Mean frequency of body gyroscopic signal on Z axis
* **freqbodygyro_std_x** - Standard deviation of body gyroscopic signal on X axis
* **freqbodygyro_std_y** -  Standard deviation of body gyroscopic signal on Y axis
* **freqbodygyro_std_z** -  Standard deviation of body gyroscopic signal on Z axis
* **freqbodyaccmag_mean** - Mean magnitude of frequency across the three-dimensional signals for body acceleration
* **freqbodyaccmag_std** - Standard deviation of magnitude of frequency across the three-dimensional signals for body acceleration
* **freqbodyaccjerkmag_mean** - Mean frequency of the magnitude of jerk across the three-dimensional signals for body acceleration
* **freqbodyaccjerkmag_std** - Standard deviation frequency of the magnitude of jerk across the three-dimensional signals for body acceleration
* **freqbodygyromag_mean** - Mean frequency of magnitude of the three-dimensional body gyroscopic signals
* **freqbodygyromag_std** - Standard deviation of frequency of magnitude of the three-dimensional body gyroscopic signals
* **freqbodygyrojerkmag_mean** - Mean frequency of magnitude of the three-dimensional jerk for body gyroscopic signals
* **freqbodygyrojerkmag_std** - Standard deviation of frequency of magnitude of the three-dimensional jerk for body gyroscopic signals
