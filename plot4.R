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
#Fourth Chart
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2,2))
plot(electric_subset$timedate, electric_subset$Global_active_power, type = "n", col="black", 
     ylab = "Global Active Power (kilowatts)", xlab = "")
lines(electric_subset$timedate, electric_subset$Global_active_power)

plot(electric_subset$timedate, electric_subset$Sub_metering_1, type = "n", col="black", 
     ylab = "Energy sub metering", xlab = "")
lines(electric_subset$timedate, electric_subset$Sub_metering_1, col = "black")
lines(electric_subset$timedate, electric_subset$Sub_metering_2, col = "red")
lines(electric_subset$timedate, electric_subset$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = "solid", col = c("black", "red", "blue"))

plot(electric_subset$timedate, electric_subset$Voltage, type = "n", col="black", 
     ylab = "Voltage", xlab = "datetime")
lines(electric_subset$timedate, electric_subset$Voltage)

plot(electric_subset$timedate, electric_subset$Global_reactive_power, type = "n", col="black", 
     ylab = "Global_reactive_power", xlab = "datetime")
lines(electric_subset$timedate, electric_subset$Global_reactive_power)
dev.off()