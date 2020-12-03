library(dplyr)
library(tidyr)

#Read data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep = " ", header = TRUE)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = '\t', header = TRUE)

#Check BPRS data
View(BPRS)
colnames(BPRS)
str(BPRS) 
summary(BPRS)

#Convert the categorical variable to factor
BPRS$subject <- factor(BPRS$subject)
BPRS$treatment <- factor(BPRS$treatment)

str(BPRS)

#Convert the data set to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

#Chech the data  now
View(BPRSL)
glimpse(BPRSL)



#Check the RATS data
View(RATS)
colnames(RATS)
str(RATS) 
summary(RATS)


#Convert the categorical variables to factors
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

glimpse(RATS)

#Convert data to long form

RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

View(RATSL)
glimpse(RATSL) 

# Save the analysis datasets
write.csv(BPRSL, file="BPRSL.csv")
write.csv(RATSL, file="RATSL.csv")

#Wide format is where we have a single row for every data point with multiple columns to hold the values of various attributes. Long format is where, for each data point we have as many rows as the number of attributes and each row contains the value of a particular attribute for a given data point.

