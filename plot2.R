## Using data from the UC Irvine Machine Learning Repository, this script will produce a timeseries plot
## of the Global Active Power data from the dataset found in the variable 'url1' below.
## timeframe = hourly data from Feb 1, 2007 through Feb 2, 2007
## Details about the data can be found at:
## https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption

## Set the working dir to location of the zip file
setwd("~/Brian/R Learning Files/Exploratory Data Analysis/Assign1")

## Download the zip file, unzip the file, and extract the text file containing the data
## Name of file is: household_power_consumption.txt
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url1, destfile = "power_dataset.zip", mode = "wb")
unzip(zipfile = "power_dataset.zip")
powerFile <- dir(pattern = ".txt")

## Load the data in R
# Specify the class of the 9 variables in the dataset
powerClasses <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")

# Using the 'fread' command to load the data, so we need the data.table package
library(data.table, verbose = FALSE, quietly = TRUE)

# Load powerFile into a data.frame using fread
power <- fread(
  input = powerFile,
  sep = ";",
  header = TRUE,
  na.strings = "?",
  stringsAsFactors=FALSE,
  colClasses = powerClasses,
  showProgress = FALSE,
  data.table = FALSE
)

## Create a subset of the data.frame 'power' where the rows contain data from Feb 1, 2007 and Feb 2, 2007 only
powerSet <- power[grep("^(1/2/2007|2/2/2007)",power$Date),]

## Convert the Date from character class to Date class
powerSet$Date <- as.Date(powerSet$Date, format = "%d/%m/%Y")

## Create a temporary variable that stores the combo of Date and Time data
powerDateTime <- with(powerSet, paste(Date,Time))

## Create a new DateTime variable whose class is Date and insert it into the 'powerSet' subset 
DateTime <- strptime(powerDateTime, "%Y-%m-%d %H:%M:%S")

powerSet <- cbind(powerSet[1:2],DateTime, powerSet[3:9])


## Open a png file device and store a timeseries line plot of Global Active Power (kw)
## over Feb 1,2007 and Feb 2, 2007 in a 480 x 480 frame
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 10, type = c("windows"))

with(powerSet, plot(Global_active_power~DateTime, type = "l", xlab="", ylab = "Global Active Power (kilowatts)"))

dev.off()

####### END OF SCRIPT #######
