##Readme

####The entire code for the analysis is included in the run_analysis.R script.

The script initially imports all the data needed from my local folder.

Afterwards, using the cbind function, the "subject" and "activity" features are appended to the train and test data sets. Finally, the two data sets are binded into one, using the rbind function.

Next, using a combination of ifelse() and the grepl() functions, the script finds the columns that include "std()" or "mean()" (which represent measurements on the mean and standard deviation for each measurement) in their names (names as described in "features.txt") and drops every other column from the table.

Next, the numbers in the "activity" feature, are substituted by descriptive activity names (as given in activity_labels.txt). Also, the feature names, which till now had the V1,V2... form, are substituted by their descriptive names, as given in features.txt.

Finally, using the ddply function from the plyr package, the final aggregated data set is produced, consisted by the average of each variable for each activity and each subject.
