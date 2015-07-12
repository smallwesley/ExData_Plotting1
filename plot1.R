# ------------------------------------------------
# exdata-030 - Project: 1  
# Course: Exploratory Data Analysis
# Part: PLOT1.R
# Author: Wesley Small (smallwesley)
#
# Synopsis: 
#   + Create plots from the Electric power consumption dataset: 
#     household_power_consumption.txt;  
#   + PLOT1.R CREATES PLOT1.PNG
# Assumption: The dataset file zip downloaded; contents extracted 
#             This R code in the same relative folder as the dataset
# ------------------------------------------------

# SET WORKING DIRECTORY (UNCOMMENT IF NECESSARY; MODIFY ACCORDINGLY)
#setwd("/Users/smallwes/develop/academic/coursera/datascience/c4-exdata/project1")

# LOAD DATASET AS CVS DELIMITED BY ";"
projectDF <- read.csv("./household_power_consumption.txt",
                      stringsAsFactors = FALSE,
                      sep = ";", 
                      header = TRUE,
                      na.string = "?")

# PROCESS DATA.TABLE USING DPLYR
library(dplyr)
projectDT <- tbl_df(projectDF)
rm("projectDF")

# FILTER FOR QUALIFIED RECORDS
subsetDT <- projectDT %>% 
            filter(Date == "1/2/2007" | Date == "2/2/2007")
rm("projectDT")

# PLOT ACTIONS 
# A SET FRAME DEVICE
png(filename = "plot1.png", width = 480, height = 480)

# CREATING HISTOGRAM GRAPH
with(subsetDT,hist(Global_active_power, 
                   col = "red", 
                   main = "Global Active Power", 
                   xlab = "Global Active Power (kilowatts)"))

# CLOSE PNG DEVICE; WRITE GRAPHIC FILE TO WORKING DIRECTORY
dev.off()

