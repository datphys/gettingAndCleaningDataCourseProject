# Getting and cleaning data course project
### Dataset
Data in project represent data collected from the accelerometters from Samsung Galaxy S smatphone. A full description is available at the site where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### codeBook.md
Descrite the variables in the dataframe ```data``` create in run_analysis.R

### run_analysis.R
Main process of script does

1. Merges the training and test set to create one data set store in ```data```
2. Extracts only the measurements on the mean and standard deviation for each measurement store in ```meanStdData``` 
3. Use descriptive activity names to name the activities in data set
4. Appropriate labels the data set with descriptive variable names
5. From the data set ```data``` create ```tidyData5``` with te average of eact variables of eact activity and eact volunteer, write to 'tidyData5.txt'