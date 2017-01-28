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

## Create second plot, save it as a png
png('plot2.png')
plot(data2$mergedtime, data2$Global_active_power,
     type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()