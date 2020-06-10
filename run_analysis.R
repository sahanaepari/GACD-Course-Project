
  #merge data sets
  X <- rbind(X_train,X_test)
  Y <- rbind(Y_train,Y_test)
  subject <- rbind(subject_train,subject_test)
  merged_data <- cbind(subject,Y,X)
  
  #extract only mean + sd for each measurement
  tidy <- merged_data %>% select(subject, code,contains("mean"),contains("std"))
  
  #Uses descriptive activity names to name the activities in the data set
  tidy$code <- activities[tidy$code,2]
  
  #Appropriately labels the data set with descriptive variable names.
  names(tidy)[2] <- "activity"
  names(tidy) <- gsub("Acc","Accelerometer",names(tidy))
  names(tidy) <- gsub("Gyro","Gyroscope",names(tidy))
  names(tidy) <- gsub("Freq","Frequency",names(tidy))
  names(tidy) <- gsub("BodyBody","Body",names(tidy))
  names(tidy) <- gsub("Mag","Magnitude",names(tidy))
  names(tidy) <- gsub("\\.t","\\.Time",names(tidy))
  names(tidy) <- gsub("^t","Time",names(tidy))
  names(tidy) <- gsub("^f","Frequency",names(tidy))
  names(tidy) <- gsub("angle","Angle",names(tidy))
  names(tidy) <- gsub("gravity","Gravity",names(tidy))

  #From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  A <- group_by(tidy, subject, activity)
  final <- summarise_all(A,list(mean))
  write.table(final, "FinalData.txt", row.name=FALSE)  
  
    
    

  
  