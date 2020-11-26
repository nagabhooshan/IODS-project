library(dplyr)
#Set working directory
setwd("C:\\Users\\nagab\\OneDrive\\Documents\\IODS-project\\IODS-project")
# Read Human development data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

# Read Gender inequality data
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Explore the data sets:
str(hd)
dim(hd)
summary(hd)

str(gii)
dim(gii)
summary(gii)

# Rename the columns:
colnames(hd) <- c("Rank", "Cntry", "HDIindex", "Expctd.Life", "Expctd.Edu", "Mean.Edu", "GNIindx", "GNIrank-HDIrank")
head(hd)

colnames(gii) <- c("Rank", "Cntry", "GIIindex", "MtrnalMortality", "AdolBirth", "WomanRep.Parliament", "Edu2.Fe", "Edu2.Ma", "Labour.Fe", "Labour.Ma")
head(gii)

# Create 2 variables to "Gender Inequility":
gii <- mutate(gii, "edu2F/edu2M" = gii$Edu2.Fe / gii$Edu2.Ma)
gii <- mutate(gii, "labF/labM" = gii$Labour.Fe / gii$Labour.Ma)
head(gii)

# Join by country:
human <- inner_join(hd, gii, by = "Cntry", suffix = c(".hd", ".gii"))
dim(human)
head(human)

# Write CSV file
write.csv(human, file ="Data/human.csv", row.names = FALSE)

#Week 5 Data wrangling
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep=",", header=TRUE)
str(human)
names(human)
summary(human)
#Mutate the data: GNI from string to numeric
library(tidyr)
library(stringr)
human$GNI=str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric

#Exclude unneeded variables
human <- dplyr::select(human, one_of("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"))

#Remove all rows with missing values
human <- filter(human, complete.cases(human) == TRUE)
str(human)

# Look at the last 10 observations of human:
tail(human, 10)

# choose everything except last 7 observations:
last <- nrow(human) - 7
human <- human[1:last, ]

# Add countries as rownames and remove country variable
rownames(human) <- human$Country
human <- dplyr::select(human, -Country)
dim(human)

write.csv(human, file ="Data/human.csv", row.names = TRUE)
