## Using data from the UC Irvine Machine Learning Repository, this script will produce a histogram
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

## Create a subset of the data.frame power where the rows contain data from Feb 1, 2007 and Feb 2, 2007 only
powerSet <- power[grep("^(1/2/2007|2/2/2007)",power$Date),]

## Open a png file device and store a histogram of Global Active Power (kw) in a 480 x 480 frame
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 10, type = c("windows"))

hist(powerSet$Global_active_power, main = "Global Active Power",xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()

####### END OF SCRIPT #######
