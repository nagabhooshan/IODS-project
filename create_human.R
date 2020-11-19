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