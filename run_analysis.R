#You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
rm(list=ls())
setwd("~/Desktop/CURSOS/GetCleanData/Project")

feat<- read.table("UCI HAR Dataset/features.txt")
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
for(i in 1:nrow(feat)) names(test_x)[i] <-as.character(feat[i,2])

subj <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subj) <- "subject"
test_ac <- read.table("UCI HAR Dataset/test/y_test.txt")
names(test_ac) <- "cod_act"
test <- cbind(subj,test_ac,test_x)
rm(list=c("subj","test_x","test_ac"))

train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
for(i in 1:nrow(feat)) names(train_x)[i] <-as.character(feat[i,2])

subj <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subj) <- "subject"
train_ac <- read.table("UCI HAR Dataset/train/y_train.txt")
names(train_ac) <- "cod_act"
train <- cbind(subj,train_ac,train_x)
rm(list=c("subj","train_x","train_ac","feat"))

predata1 <- rbind(train,test)
rm(list=c("train","test"))

act_names <- read.table("UCI HAR Dataset/activity_labels.txt")
names(act_names)[1] <- "cod_act"
library(plyr)
predata2 <- join(predata1,act_names,by="cod_act",type="left")
predata3 <- predata2[-2]
predata4 <- predata3[c(1,563,2:562)]
names(predata4)[2] <- "activity"

data<- predata4[,c(1:2,grep("(std|mean)",names(predata4)))]

rm(list=c("act_names","predata1","predata2","predata3","i","predata4"))

write.csv(data,file="data.csv")



