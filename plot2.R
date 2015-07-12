# ------------------------------------------------
# exdata-030 - Project: 1  
# Course: Exploratory Data Analysis
# Part: PLOT2.R
# Author: Wesley Small (smallwesley)
#
# Synopsis: 
#   + Create plots from the Electric power consumption dataset: 
#     household_power_consumption.txt;  
#   + PLOT2.R CREATES PLOT2.PNG
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

# PROCESS DATES WITH LUBRIDATE
library("lubridate")

# FILTER FOR QUALIFIED RECORDS & CREATE NEW TIMESTAMP COLUMN
subsetDT <- 
    projectDT %>% 
    filter((Date == "1/2/2007" | Date == "2/2/2007")) %>%
    mutate(Timestamp = dmy(Date) + hms(Time))
rm("projectDT")

# PLOT GENERATION ACTIONS

# 1. INIETIALIZE GRAPHIC DEVICE
png(filename = "plot2.png", width = 480, height = 480)

# 2. SET GRAPH PARAMS
par(mfrow = c(1,1), # SINGLE GRAPH ONLY
    bg=NA)          # BACKGROUND TRANSPARENT

# 3. GENERATE LINE GRAPH
with (subsetDT, plot(Timestamp, 
                     Global_active_power , 
                     type="l",
                     xlab = "",
                     ylab = "Global Active Power (kilowatts)"))

# 4. CLOSE PNG DEVICE; WRITE GRAPHIC FILE TO WORKING DIRECTORY
dev.off()

# CLEAN UP ENVIRONMENT
remove("subsetDT")
