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
if (!"dplyr" %in% installed.packages()){ install.packages("dplyr")} 
library(dplyr)
projectDT <- tbl_df(projectDF)
rm("projectDF")

# FILTER FOR QUALIFIED RECORDS
subsetDT <- projectDT %>% 
            filter(Date == "1/2/2007" | Date == "2/2/2007")
rm("projectDT")

# PLOT GENERATION ACTIONS

# 1. INITIALIZE GRAPHIC DEVICE
png(filename = "plot1.png", width = 480, height = 480)

# 2. SET GRAPH PARAMS
par(mfrow = c(1,1), # SINGLE GRAPH ONLY
    bg=NA)          # BACKGROUND TRANSPARENT

# 3. GENERATE HISTOGRAM GRAPH
with(subsetDT,hist(Global_active_power, 
                   col = "red", 
                   main = "Global Active Power", 
                   xlab = "Global Active Power (kilowatts)"))

# CLOSE PNG DEVICE; WRITE GRAPHIC FILE TO WORKING DIRECTORY
dev.off()

# CLEAN UP ENVIRONMENT
remove("subsetDT")
