#Rscript to read and modify the tables for the 3rd assignment

## Reading and looking at the dataframes

library(tidyr); library(dplyr)


student_mat <- read.csv("/home/alex/ods_course/IODS-project_R/data/student-mat.csv",sep = ";" ) 
glimpse(student_mat)
dim(student_mat)

student_por <- read.csv("/home/alex/ods_course/IODS-project_R/data/student-por.csv",sep = ";") 
dim(student_por)
glimpse(student_por)

## choosing the columns no to use for identification
diff_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")


## Modifying the dataframe according to specification
joiner_vec <- setdiff(colnames(por), diff_cols)

math_por <- inner_join(student_mat, student_por, by = joiner_vec, suffix = c(".math", ".por"))

str(math_por)
# 370 obs. of  39 variables
dim(math_por)
# the merged data contains 370 rows  39 columns
alc <- select(math_por,all_of(joiner_vec))

for(col_name in diff_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

alc <- mutate(alc, average_alc = (Dalc + Walc) / 2)

alc <- mutate(alc, high_use = average_alc > 2)
glimpse(alc)
#Rows: 370
#Columns: 35  
# All is fine
write_csv(alc, "/home/alex/ods_course/IODS-project_R/data/aa_alc.csv")

