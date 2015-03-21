library(plyr)

trainSet <- read.table("C:/Users/Thanasis/Desktop/UCI HAR Dataset/train/X_train.txt", quote="\"")
testSet <- read.table("C:/Users/Thanasis/Desktop/UCI HAR Dataset/test/X_test.txt", quote="\"")
testSetY <- read.table("C:/Users/Thanasis/Desktop/UCI HAR Dataset/test/y_test.txt", quote="\"")
trainSetY <- read.table("C:/Users/Thanasis/Desktop/UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_test <- read.table("C:/Users/Thanasis/Desktop/UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_train <- read.table("C:/Users/Thanasis/Desktop/UCI HAR Dataset/train/subject_train.txt", quote="\"")
activity_labels <- read.table("C:/Users/Thanasis/Desktop/UCI HAR Dataset/activity_labels.txt", quote="\"")


#merging the datasets
train<-cbind(trainSet, subject_train, trainSetY)
test<-cbind(testSet, subject_test, testSetY)
dataSet<-rbind(train, test)

#drops every column that does not include "means()" or "std()" in their names
featureNames <- read.table("C:/Users/Thanasis/Desktop/UCI HAR Dataset/features.txt", quote="\"")
rowsToSelect<-ifelse(grepl("mean()", featureNames$V2) | grepl("std()", featureNames$V2), TRUE, FALSE)
drop<-NULL
for(i in 1:561)
{
  if(rowsToSelect[i]==FALSE)
  {
    drop<-c(drop,paste0("V",i))
  }
}
dataSet<-dataSet[,!(names(dataSet) %in% drop)]

#substitutes the numbers, with descriptive activity names (as given in activity_labels)
dataSet$V1.2 <- factor(dataSet$V1.2,
                    levels = c(1,2,3,4,5,6),
                    labels = activity_labels[,2])


#Labels the column names with their descriptive names (as given in features.txt)
for(i in 1:nrow(featureNames))
{
  if(!(is.null(eval(parse(text=paste0("dataSet$V",i))))))
  {
    names(dataSet)[names(dataSet)==paste0("V",i)] <- paste0(featureNames[i,2])
  }
}
names(dataSet)[names(dataSet)=="V1.1"]<-"subject"
names(dataSet)[names(dataSet)=="V1.2"]<-"activity"


#Produces the aggregated, tidy dataset with the average of each variable for each activity and each subject
aggregatedDataSet <-ddply(dataSet, .(subject, activity), numcolwise(mean))



