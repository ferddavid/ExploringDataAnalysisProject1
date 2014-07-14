library(datasets)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
electric <- read.table(unz(temp, "household_power_consumption.txt"),sep = ";", header = TRUE, 
                       na.strings="?" )
unlink(temp)
electric$Date <- as.character(electric$Date)
electric$date_modified <- as.Date(electric$Date, "%d/%m/%Y")
electric_subset <- electric[electric$date_modified == "2007-02-01"|
                              electric$date_modified == "2007-02-02",]
electric_subset$timedate <- strptime(paste(electric_subset$Date, electric_subset$Time), 
                                     "%d/%m/%Y %H:%M:%S")
#First Chart Histogram
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(electric_subset$Global_active_power, col="red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()