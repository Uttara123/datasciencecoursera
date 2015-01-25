
* directory 'all' : created in the base directory to store merged data
* features.txt in 'all' : contains the subset of features for mean and std that were created by using commands outside of the script but using the same code logic  used in run_analysis.R
**   features <- read.table("features.txt")
**   c <- grep("mean",features$V2,ignore.case=T)
**   d <- grep("std", features$V2,ignore.case=T)
**   e <- rbind(features[c,], features[d,])
**   e <- sort(e$V1)
**   g <- features[features$V1 %in% e, ]
**   write.table("all/features.txt", g, row.name=F)
* dfall_X : contains merged data for  X_test.txt and X_train.txt
* dfall_subject : contains merged data for subject_test.txt and subject_traint.txt
* dfall_activity : contains merged data for y_test.txt and y_train.txt

* variables with following pattern names contain coresponding merged data for Inetrtial Signals ( not really required, but script does this anyways)
** dfall_acc..  
** dfall_gyro..
** dfall_total..

* df1 : after all the merges and adjustments and manipulation, contains all the "mean" and "std" measurements of merged data and additional 3 columns for (1) activity that are labelled, (2) subject and (3) concatenated activity and subject
* df2 : contains  average of measurements by activity_subject, so it has average measurements for each combination of activity and subject, for  example, WALKING_2 denotes walking for subject 2 and since there are 6 unique activities and 30 unique subjects there 180  (6 X 30 ) unique combinations

* final.txt : is the file name to which final data is written to.




