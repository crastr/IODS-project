# Load the data sets (BPRS and RATS) into R using as the source the GitHub repository of MABS, where they are given in the wide form:
library(dplyr)
bprs <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header=T)

rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header=T)
