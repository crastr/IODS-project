# Load the data sets (BPRS and RATS) into R using as the source the GitHub repository of MABS, where they are given in the wide form:

library(tidyverse)
bprs <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = T)

rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T)


write.csv(x = bprs,"/home/alex/ods_course/IODS-project_R/data/bprs.csv")
write.csv(x = rats,"/home/alex/ods_course/IODS-project_R/data/rats.csv")

glimpse(bprs)
# bprs contains 40 rows and 11 columns, in wide format

glimpse(rats)

# rats  contains 16 rows and 13 columns, this is the data of 16 rats wwith consecutive measurements

bprs <- bprs %>% mutate(treatment = factor(treatment), subject = factor(subject))
str(bprs)
rats <- rats %>% mutate(ID = factor(ID), Group = factor(Group))
str(rats)


bprs_long <- pivot_longer(bprs, cols=-c(treatment, subject), names_to = "weeks", values_to = "pbrs")
bprs_long$week <- as.numeric(gsub(x=bprs_long$weeks,pattern = "week",replacement = ""))

summary(bprs_long)
rats_long <- pivot_longer(rats, cols=-c(ID, Group), names_to = "WD", values_to = "Weight")
rats_long$Time <- as.numeric(gsub(x=rats_long$WD,pattern = "WD",replacement = ""))
summary(rats_long)

str(bprs)
str(bprs_long)
dim(bprs)
dim(bprs_long)
summary(bprs)
summary(bprs_long)

str(rats)
str(rats_long)
dim(rats)
dim(rats_long)
summary(rats)
summary(rats_long)

# There are obvious differences, previously there were multiple columns for each subject. Each week or timepoint had their own column, which is usefull for some applications, like filling in the table, but not so useful for others, like plotting the table. 
# It is sometimes more useful to have the same variable (like weight) in a single column rather than multiple.


write_csv(x = bprs_long,"/home/alex/ods_course/IODS-project_R/data/bprs_long.csv")
write_csv(x = rats_long,"/home/alex/ods_course/IODS-project_R/data/rats_long.csv")
