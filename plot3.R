# ------------------------------------------------
# exdata-030 - Project: 1  
# Course: Exploratory Data Analysis
# Part: PLOT3.R
# Author: Wesley Small (smallwesley)
#
# Synopsis: 
#   + Create plots from the Electric power consumption dataset: 
#     household_power_consumption.txt;  
#   + PLOT3.R CREATES PLOT3.PNG
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

# PLOT ACTIONS 
# A SET FRAME DEVICE
png(filename = "plot3.png", width = 480, height = 480)

# PERFORM MULTIPLE PLOTS ON SAME GRAPH
with(subsetDT, plot(Timestamp, 
                     Sub_metering_1, 
                     type="l",
                     col = "black",
                     xlab = "",
                     ylab = "Energy sub metering"))
with(subsetDT, lines(Timestamp,
                     Sub_metering_2, 
                     col = "red"))
with(subsetDT, lines(Timestamp,
                     Sub_metering_3, 
                     col = "blue"))

# CREATE LEGEND
legend("topright",
       lty= 1,
       col = c("black","red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_2"))

# CLOSE PNG DEVICE; WRITE GRAPHIC FILE TO WORKING DIRECTORY
dev.off()


