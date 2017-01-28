## Download zipfile and unzip, using a temp file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              temp, mode = "wb")
data <- read.table(unz(temp, "household_power_consumption.txt"), 
                   header = TRUE, sep = ";", col.names =
                     c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",
                       "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                   stringsAsFactors = FALSE, dec = ".", na.strings = "?")

## Create subset of only the dates 1/2/2007 and 2/2/2007
data2 <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

## create variable for time
data2$mergedtime <- paste(data2$Date, data2$Time)
data2$mergedtime <- strptime(data2$mergedtime, format = "%d/%m/%Y %H:%M:%S")


## Create fourth plot, set par on 4 (2 x 2), save it as a png

png('plot4.png')
par(mfcol=c(2,2))
#1
plot(data2$mergedtime, data2$Global_active_power,
     type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
#2
plot(data2$mergedtime, data2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data2$mergedtime, data2$Sub_metering_2, col = "red")
lines(data2$mergedtime, data2$Sub_metering_3, col = "blue")
legend("topright", pch = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#3
plot(data2$mergedtime, data2$Voltage,
     type = "l", xlab = "datetime", 
     ylab = "Voltage", ylim = c(233, 246.6))
#4
plot(data2$mergedtime, data2$Global_reactive_power,
     type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()