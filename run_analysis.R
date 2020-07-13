library(tidyverse)

# Download data
if(!dir.exists('data')) {
    dir.create('data')
    url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    temp <- tempfile()
    download.file(url, temp)
    unzip(temp, exdir = 'data')
    unlink(temp)
}

# Construct file path
uciDatasetPath <- file.path('data', 'UCI HAR Dataset')
xTrainPath <- file.path(uciDatasetPath, 'train', 'X_train.txt')
yTrainPath <- file.path(uciDatasetPath, 'train', 'y_train.txt')
subjectTrainPath <- file.path(uciDatasetPath, 'train', 'subject_train.txt')
subjectTestPath <- file.path(uciDatasetPath, 'test', 'subject_test.txt')
xTestPath <- file.path(uciDatasetPath, 'test', 'X_test.txt')
yTestPath <- file.path(uciDatasetPath, 'test', 'y_test.txt')
colNamesPath <- file.path(uciDatasetPath, 'features.txt')
activityLabelsPath <- file.path(uciDatasetPath, 'activity_labels.txt')

# Load train data
xTrain <- read_table(xTrainPath, col_names = FALSE)
yTrain <- read_table(yTrainPath, col_names = 'activity')
# Load test data
xTest <- read_table(xTestPath, col_names = FALSE)
yTest <- read_table(yTestPath, col_names = 'activity')
# Load subject data
volunteerTrain <- read_table(subjectTrainPath, col_names = 'volunteer')
volunteerTest <- read_table(subjectTestPath, col_names = 'volunteer')
# Read variable names
cNames <- read_lines(colNamesPath)
# Read activity labels
activityLabels <- read_lines(activityLabelsPath)

# Delete numbers and spaces at the beginning of the string
# variable names and activityLabels
cNames <- str_remove(cNames, '^\\d+\\s')
activityLabels <- str_remove(activityLabels, '^\\d+\\s')
# Remove '()' and ')' at and of variable names
cNames <- str_remove_all(cNames, '\\(\\)|\\)$')
# Replace ',' '(' ')' '-' with '_'
cNames <- str_replace_all(cNames, ',|\\(|\\)|-', '_')
# Make valid variable names
cNames <- make.names(cNames, unique = TRUE)


# Write list of variable names to codeBook.md
# content <- sapply(cNames, function(name) {str_c(name, '  ')})
# write_lines(content, 'codeBook.md', append = TRUE)


# Merges x , y, volunteers data
xData <- rbind(xTrain, xTest)
yData <- rbind(yTrain, yTest)
volunteer <- rbind(volunteerTrain, volunteerTest)

# Rename of variable in xData with cNames
names(xData) <- cNames

# Add activity labels to yData with activity variables
yData <- yData %>%
    mutate(activity = activityLabels[activity])

# Merges all data
data <- cbind(volunteer, yData, xData)

# Find variable names have 
index <- str_detect(cNames, 'mean|std')
# Extracts measurements on the mean and standard deviation
meanStdData <- data %>%
    select(volunteer, activity, cNames[index])

tidyData5 <- data %>%
    group_by(volunteer, activity) %>%
    summarise_all(mean)
write.table(tidyData5, 'tidyData5.txt', row.names = FALSE)
