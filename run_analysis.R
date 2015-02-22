library(plyr)
library(dplyr)

#Step 1 - Read and merge data
features = read.table("features.txt")
testlabels = read.table("test/y_test.txt")
testsubject = read.table("test/subject_test.txt")
test = read.table("test/X_test.txt",col.names=features[,2])
test = cbind(testlabels,testsubject,test)
trainlabels = read.table("train/y_train.txt")
trainsubject = read.table("train/subject_train.txt")
train = read.table("train/X_train.txt",col.names=features[,2])
train = cbind(trainlabels,trainsubject,train)
data = rbind(test,train)
rm(test,train)

#Step 2 - Extract Mean and StDev data
meanstd = grep("mean()|std()",colnames(data))
data = data[,c(1:2,meanstd)]

#Step 3 - Applies descriptive activity names
activitylabels = read.table("activity_labels.txt")
Activity = vector("character")
for (i in 1:length(data[,1])) {
        z = data[i,1]
        Activity[i] = as.character(activitylabels[as.numeric(z),2])
}
data = cbind(Activity,data)
data = select(data, -V1)

#Step 4 - Label the set with descriptive variable names
data = rename(data, Subject = V1.1) #all other variables named in step 1

#Step 5 - Create a tidy data set with average of each variable for each activity and subject
tidydata = aggregate(data[-(1:2)],data[(1:2)],mean)
write.table(tidydata,file="tidydata.txt",row.names=FALSE)
