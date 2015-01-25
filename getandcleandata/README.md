## directory to run the script from

This script should be run from the base directory of the data set, so if you unzipped the data for the course project and it created UCI HAR Datase directory, it should be run from this directory

## parameters
no parameters need be passed to the script

## flow
* creates a directory named "all" to store merged data
* merges each of X_ , y_ subject_ files from test and train directories
* writes merged files to directory 'all' as X_all.txt, y_all.txt and subject_all.txt
* sub directories for Inertial Signals are also created with corresponding merged files, but are not used any where
* reads the merged X data into df1
* reads the features.txt files and extracts only the rows that have in second column V2, names that have "mean" or "std", it ignores cases , so names with 'Mean' in them for example are also extracted
* subsets df1 to only include columns with names extracted in step above
* its saves off the columnnames that were extracted, these are saved because the tapply command later assigns column names that are too long and so these column names are restored, strictly speaking this step is not required, but improves readability of final data 
* so now df1 only contains  mean or std measurement columns
* add activity and subject data to df1
* label activities by reading there names from activity_lables.txt
* add a column that is  a concatenation of column for activity and subject
* create a data set df2 for average of  measurements by activity_subject
* for average, function "mean" is used
* restore column names
* write df2  out to disk




