require(tidyverse)
library(tidyverse)
require(readr)
library(readr)

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")

# Dimensions
dim(hd)
# Summaries
summary(hd)
# Show structure
str(hd) 


gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Dimensions
dim(gii)
# Summaries
summary(gii)
# Show structure
str(gii) 

# The names are long and not usable, they should be shortened

colnames(hd)
colnames(hd)<-c("HDI_rank","Country","HDI","LifeExp_B","EduExp","EduMean","GNI_C","GNI_C_HDIrank")


colnames(gii)
colnames(gii)<-c("GII_Rank", "Country", "GII", "MMRatio", "AdBRate", "RP_p", "F_2ED_p", "M_2ED_p", "F_LFPR", "M_LFPR")


gii <- gii %>% mutate(FM_2ED_Ratio = F_2ED_p/M_2ED_p,
                      FM_2ED_Ratio = F_LFPR/M_LFPR)

#Merging gii and hd by country

human_data <- inner_join(hd, gii, by="Country")
glimpse(human_data)

write_csv(human_data, file="/home/alex/ods_course/IODS-project_R/data/human.csv")
