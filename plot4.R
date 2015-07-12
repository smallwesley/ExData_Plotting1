# ------------------------------------------------
# exdata-030 - Project: 1  
# Course: Exploratory Data Analysis
# Part: PLOT4.R
# Author: Wesley Small (smallwesley)
#
# Synopsis: 
#   + Create plots from the Electric power consumption dataset: 
#     household_power_consumption.txt;  
#   + PLOT4.R CREATES PLOT4.PNG
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

# 1. INITIALIZE GRAPHIC DEVICE
png(filename = "plot4.png", width = 480, height = 480)

# 2. CONFIGURE GRAPH PARAMETERS
par(mfrow = c(2,2),        # SET 2 by 2 GRID
    mar = c(4,4,2,1),      # SET MARGINS PER GRAPH
    oma = c(1, 1, 1, 1),   # SET OUTER MARGINS
    bg=NA)                 # BACKGROUND TRANSPARENT

# 3. GENERATE PLOTS
# PLOT 1: UPPER LEFT
with (subsetDT, plot(Timestamp, 
                     Global_active_power , 
                     type="l",
                     xlab = "",
                     ylab = "Global Active Power"))

# PLOT 2: UPPER RIGHT
with (subsetDT, plot(Timestamp, 
                     Voltage , 
                     type="l",
                     xlab = "datetime",
                     ylab = "Voltage"))

# PLOT 3: LOWER LEFT
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
legend("topright",
       lty = 1,
       bty = "n",
       col = c("black","red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_2"))

# PLOT 4: LOWER RIGHT
with (subsetDT, plot(Timestamp, 
                     Global_reactive_power, 
                     type="l",
                     xlab = "datetime",
                     ylab = "Global_reactive_power"))

# CLOSE PNG DEVICE; WRITE GRAPHIC FILE TO WORKING DIRECTORY
dev.off()

# CLEAN UP ENVIRONMENT
remove("subsetDT")