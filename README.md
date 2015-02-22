Data Source

The set of data for human activity recognition was provided by the University of California, Irvine and accessed at their Machine Learning Repository at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

==============================================================================================
Study Design

The data set is a database built from the recordings of 30 subjects performing routine daily activities while carrying a waist-mounted smartphone with embedded inertial sensors.
The subjects were all within 19-48 years of age, and each performed six activities (walking, walking upstairs, walking downstairs, sitting, standing, and laying) while wearing a Samsung Galaxy SII).
The embedded accelerometer and gyroscope captured 3-axial linear acceleration and angular velocity measurements at 50Hz intervals.  The dataset was randomly partitioned into a training set and test set, although the two were combined for this analysis.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

==============================================================================================
Code Book

The "Activity" variable indicates which of the six activities the signal was measuring.  The "Subject" variable indicates which of the 30 subjects the measurement applies to.

The rest of the variables follow this pattern:
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

For each subject and activity, the averages of the mean and standard deviation were calculated and appear at the end of the variable name.

==============================================================================================
Description of 'run_analysis.R' Script

The two packages required to run this script are 'plyr' (for the 'aggregate' command) and the related 'dplyr' (for 'select' and 'rename')
Step 1 reads in all of the required text files required for the tidy data set.  The 'features.txt' file contains the variable names for each parameter in the 'test' and 'train' set, while the "labels" sets contain the activities associated with each measurement and the "subject" sets contain the associated subject.  Column binding those sets, and the row binding the test and train sets create one data set for the entire database.  Finally the "rm" command clears the old, separate data frames from the workspace to conserve memory.
Step 2 uses the "grep" command to extract an index of all parameters which contain mean or standard deviation measurements.  The data frame is then subsetted to only include those columns, as well as the activities and subjects in the first two columns.
Step 3 creates a vector which converts the numerical code representing the activity with its text description, and then replaces that column with the new vector.
Step 4 renames the subject column "subject".  It was not necessary to rename the measurements because those names were already read into the data frame with the 'col.names' argument in Step 1.
Step 5 uses the "aggregate" function to perform a function over a set of factors.  In this case, for each combination of subject and activity in the first two columns, the mean of each other variable was calculated and a new data frame was created with those means.
