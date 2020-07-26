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

png("plot1.png",width = 480, height = 480, unit = "px")
  hist(data$Global_active_power, col = "red", main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)")
dev.off()






