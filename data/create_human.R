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
                      FM_LFPR_Ratio = F_LFPR/M_LFPR)

#Merging gii and hd by country

human_data <- inner_join(hd, gii, by="Country")
glimpse(human_data)

write_csv(human_data, file="/home/alex/ods_course/IODS-project_R/data/human.csv")

dim(human_data)
## The data transformed for the previous assignment contains 195 rows with  18 columns
str(human_data)

# # Only the second columns in a character - country names, all the rest are numeric
# These are the descritions, a more detailed information can be found here: https://hdr.undp.org/data-center/documentation-and-downloads, first and second table.
# HDI_rank: "HDI Rank" in the first table, indicating the country's global ranking based on the Human Development Index.
# 
# Country: The name of the country being evaluated, present in both tables.
# 
# HDI: "Human Development Index (HDI) Value" in the first table, measuring average achievement in key human development dimensions.
# 
# LifeExp_B: "Life Expectancy at Birth (years)" from the first table, showing the average number of years a newborn is expected to live under current mortality rates.
# 
# EduExp: "Expected Years of Schooling (years)" in the first table, estimating total years of schooling a child is expected to receive.
# 
# EduMean: "Mean Years of Schooling (years)" in the first table, representing the average years of education received by people aged 25 and older.
# 
# GNI_C: "Gross National Income (GNI) Per Capita (2017 PPP $)" from the first table, indicating the average income of a country's citizens, adjusted to purchasing power parity.
# 
# GNI_C_HDIrank: "GNI Per Capita Rank Minus HDI Rank" from the first table, showing the difference between the country's GNI per capita rank and its HDI rank.
# 
# GII_Rank: The ranking of the country in the Gender Inequality Index, part of the second table.
# 
# GII: "Gender Inequality Index" from the second table, measuring gender disparities in reproductive health, empowerment, and economic activity.
# 
# MMRatio: "Maternal Mortality Ratio" from the second table, indicating the number of maternal deaths per 100,000 live births.
# 
# AdBRate: "Adolescent Birth Rate" from the second table, referring to the number of births per 1,000 women aged 15-19.
# 
# RP_p: "Share of Seats in Parliament" in the second table, representing the percentage of parliamentary seats held by women.
# 
# F_2ED_p and M_2ED_p: The percentage of the female and male population, respectively, with at least some secondary education, as indicated in the second table.
# 
# F_LFPR and M_LFPR: The "Labor Force Participation Rate" for females and males, respectively, from the second table.
# 
# FM_2ED_Ratio: A metric comparing the ratio of females to males with at least some secondary education.
# FM_LFPR_Ratio: A metric comparing the ratio of females to males labor force.

### Keeping only the interesting variables

human_data_ <- human_data %>% dplyr::select(all_of(c("Country", "FM_2ED_Ratio", "FM_LFPR_Ratio", "EduExp", "LifeExp_B", "GNI_C", "MMRatio", "AdBRate", "RP_p")))
### Keeping only complete cases

human_data_ <- filter(human_data_, complete.cases(human_data_)==T)

### Keeping only countries, not regions 

human_data_ <- human_data_[c(1:155),]
### Rewriting the data in the folder
write_csv(human_data_, file="/home/alex/ods_course/IODS-project_R/data/human.csv")

