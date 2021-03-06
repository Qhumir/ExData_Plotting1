#########################################################################
#   Exploratory Data Analysis - Course Project 1
#########################################################################

########################## Libraries
library(dplyr)


########################## Data

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download data only if it doesn't exist
if(!file.exists("./data.zip")){
  download.file(url,destfile="./data.zip")
  unzip("./data.zip")
}

# Read data
data <- read.table("household_power_consumption.txt", sep=";",
                   header=TRUE, na.strings = "?")

# Clean Data
data <- data %>% 
  mutate( # Convert the Date and Time variables to Date/Time classes in R
    DateTime = strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"),
    Date = as.Date(Date,"%d/%m/%Y")
    ) %>%
  filter(  #Use only data from the dates 2007-02-01 and 2007-02-02
    Date == as.Date("2007-02-01") & Date == as.Date("2007-02-02") 
    )


########################## Plotting

# This line of code allows that the abbreviations of the days appears in English
Sys.setlocale(category = "LC_ALL", locale = "english")

png("plot3.png",width = 480, height = 480, unit = "px")

plot(data$DateTime,data$Sub_metering_1,
     type = "l", xlab = NA,
     ylab = "Energy sub metering")
lines(data$DateTime,data$Sub_metering_2,
     type = "l", xlab = NA, col= "red")
lines(data$DateTime,data$Sub_metering_3,
      type = "l", xlab = NA, col= "blue")
legend("topright", lty = 1,col = c("black","blue", "red"),
  legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()





