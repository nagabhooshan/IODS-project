# Nagabhooshan Hegde, 05/11/2020 This file includes data wrangling and analysis
#Data wrangling
# read the data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Dimensions of the data
dim(lrn14)
# 183 observations of  60 variables

# Structure of the data
str(lrn14)
#Dataframe consists of 183 observations of 60 variables. It also shows structure of object 'learn14'

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)
# choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# see the stucture of the new dataset
str(learning2014)

# select rows where points is greater than zero
learning2014 <-filter(learning2014, Points > 0) 

#write data to csv and save in data folder
write.csv(learning2014, "C:\\Users\\nagab\\OneDrive\\Documents\\IODS-project\\IODS-project\\data\\learning2014.csv", row.names = FALSE)




#Analysis
#Read data from csv
newdata<- read.csv("C:\\Users\\nagab\\OneDrive\\Documents\\IODS-project\\IODS-project\\data\\learning2014.csv")

#Check structure of the data
str(newdata)
head(newdata)
#This dataset consists of 166 observations of 7 variables.
#Age      Age (in years) derived from the date of birth
#Attitude Global attitude toward statistics
#Points   Exam points
#gender   Gender: M (Male), F (Female)
#Original data included many questions that can be thought to measure the same dimension they were combined 
#deep Average of columns related to deep learning
#stra Average of columns related to strategic learning
#surf Average of columns related to surface learning

pairs(newdata[-1])

# access the GGally and ggplot2 libraries
library(GGally)
library(ggplot2)

# create a more advanced plot matrix with ggpairs()
p <- ggpairs(newdata, mapping = aes(col = gender, alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20)))

# draw the plot
p

# create an plot matrix with ggpairs()
ggpairs(newdata, lower = list(combo = wrap("facethist", bins = 20)))

# create a regression model with multiple explanatory variables
my_model2 <- lm(Points ~ Attitude + stra, data = newdata)

#summary
summary(my_model2)
plot(my_model2, which = c(1,2,5), par(mfrow = c(2,2)))
