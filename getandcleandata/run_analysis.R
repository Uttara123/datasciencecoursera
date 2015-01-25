# create a directory to store merged data
if (!file.exists("all")) {
    dir.create("all")
}

if (!file.exists("all/Inertial\ Signals")) {
    dir.create("all/Inertial\ Signals")
}

#  merge X, subject and y  for test and train

dfall_X  <- rbind(read.table("test/X_test.txt") , read.table("train/X_train.txt"))
dfall_subject <- rbind(read.table("test/subject_test.txt"), read.table("train/subject_train.txt"))
dfall_activity <- rbind(read.table("test/y_test.txt"), read.table("train/y_train.txt"))

# now create corresponding files containing merged data in "all" directory

write.table(dfall_X,"all/X_all.txt")
write.table(dfall_subject, "all/subject_all.txt")
write.table(dfall_activity, "all/y_all.txt")

# now merge observations in sub directory Inertial Signals, its not really needed for the assignment results, but its being merged anyways


# for body acc
dfall_acc_x <- rbind ( read.table("test/Inertial\ Signals/body_acc_x_test.txt"),
                       read.table("train/Inertial\ Signals/body_acc_x_train.txt")
                    ) 

dfall_acc_y <- rbind ( read.table("test/Inertial\ Signals/body_acc_y_test.txt"),
                       read.table("train/Inertial\ Signals/body_acc_y_train.txt")
                    )

dfall_acc_z <- rbind ( read.table("test/Inertial\ Signals/body_acc_z_test.txt"),
                       read.table("train/Inertial\ Signals/body_acc_z_train.txt")
                    )
# for body gyro
dfall_gyro_x <- rbind ( read.table("test/Inertial\ Signals/body_gyro_x_test.txt"),
                       read.table("train/Inertial\ Signals/body_gyro_x_train.txt")
                    )

dfall_gyro_y <- rbind ( read.table("test/Inertial\ Signals/body_gyro_y_test.txt"),
                       read.table("train/Inertial\ Signals/body_gyro_y_train.txt")
                    )

dfall_gyro_z <- rbind ( read.table("test/Inertial\ Signals/body_gyro_z_test.txt"),
                       read.table("train/Inertial\ Signals/body_gyro_z_train.txt")
                    )
# for total acc

dfall_total_x <- rbind ( read.table("test/Inertial\ Signals/total_acc_x_test.txt"),
                        read.table("train/Inertial\ Signals/total_acc_x_train.txt")
                    )

dfall_total_y <- rbind ( read.table("test/Inertial\ Signals/total_acc_y_test.txt"),
                       read.table("train/Inertial\ Signals/total_acc_y_train.txt")
                    )

dfall_total_z <- rbind ( read.table("test/Inertial\ Signals/total_acc_z_test.txt"),
                       read.table("train/Inertial\ Signals/total_acc_z_train.txt")
                    )

# create all the files in the all/Inertial Signals directory
write.table(dfall_acc_x, "all/Inertial\ Signals/body_acc_x_test.txt")
write.table(dfall_acc_y, "all/Inertial\ Signals/body_acc_y_test.txt")
write.table(dfall_acc_z, "all/Inertial\ Signals/body_acc_z_test.txt")
write.table(dfall_gyro_x, "all/Inertial\ Signals/body_gyro_x_test.txt")
write.table(dfall_gyro_y, "all/Inertial\ Signals/body_gyro_y_test.txt")
write.table(dfall_gyro_z, "all/Inertial\ Signals/body_gyro_z_test.txt")
write.table(dfall_total_x, "all/Inertial\ Signals/total_acc_x_test.txt")
write.table(dfall_total_y, "all/Inertial\ Signals/total_acc_y_test.txt")
write.table(dfall_total_z, "all/Inertial\ Signals/total_acc_z_test.txt")


# read the merged X data
df1 <- read.table("all/X_all.txt")

# pick only the measurements that calculate mean or std
# names of the columns of df1 are  specified in features.txt, so read that and sub set those that contain std or mean while ignoring case

features <- read.table("features.txt")
c <- grep("mean",features$V2,ignore.case=T)
d <- grep("std", features$V2,ignore.case=T)
e <- rbind(features[c,], features[d,])
e <- sort(e$V1)
df1 <- df1[e]
saveColumnNames <- colnames(df1)

# so now df1 only contains those mean or std measurement columns

# merge activity and subject data to df1
df1[,"activity"] <- read.table("all/y_all.txt")
df1[,"subject"] <- read.table("all/subject_all.txt")

# label activities in merged set
acl <- read.table("activity_labels.txt")
df1$activity <- factor(df1$activity, levels = acl[, "V1"], labels = acl[, "V2"])

# add a column that is  a concatenation of column for activity and subject

df1$activity_subject <- interaction(df1$activity, df1$subject, sep ="_")

# create a data set for average of  measurements by activity_subject

df2 <- as.data.frame(tapply(df1[,1], df1$activity_subject, mean))
# below loop is over the columns that have measurements, so subtract 3 for activity, subject and activity_subject

id <- c(2:(ncol(df1)-3))
for ( i in seq_along(id) ) {
  df2  <- cbind(df2,as.data.frame(tapply(df1[,i], df1$activity_subject, mean)))
}

colnames(df2) <- saveColumnNames

# write this data out to disk
write.table(df2,"all/final.txt", row.name=FALSE)



