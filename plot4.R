## Load data.table library
library(data.table)

DT <- fread("household_power_consumption.txt", na.strings = "?")
DT <- DT[,Datetype := as.Date(Date, "%d/%m/%Y")]

## Subset only the two days we are looking at.
sub <- subset(DT, Datetype == '2007-02-01' | Datetype == '2007-02-02')

## create timestamp column to comparable Date format
sub <- sub[,Timestamp := paste(Datetype, Time, sep = " ")] 
sub$Timestamp <- as.POSIXct(sub$Timestamp,  format="%Y-%m-%d %H:%M:%S")

## convert Global_active_power, Voltage, Global_reactive_power, Sub Metering 1, 2 and 3 to numeric
sub <- sub[,Sub_metering_1 := as.numeric(Sub_metering_1)]
sub <- sub[,Sub_metering_2 := as.numeric(Sub_metering_2)]
sub <- sub[,Sub_metering_3 := as.numeric(Sub_metering_3)]
sub <- sub[,Global_active_power := as.numeric(Global_active_power)]
sub <- sub[,Global_reactive_power := as.numeric(Global_reactive_power)]
sub <- sub[,Voltage := as.numeric(Voltage)]


## plot to png device
par(mfrow = c(2,2))

plot(sub$Timestamp, sub$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(sub$Timestamp, sub$Voltage, type = "l", ylab = "Voltage", xlab = "")

plot(sub$Timestamp, sub$Sub_metering_1, type = 'n', ylab = "Energy sub metering", xlab = "")
points(sub$Timestamp, sub$Sub_metering_1, type = "l")
points(sub$Timestamp, sub$Sub_metering_2, type = "l", col= "red")
points(sub$Timestamp, sub$Sub_metering_3, type = "l", col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1),
       lwd=c(2.5,2.5),col=c("black", "red", "blue"), cex = .25)


plot(sub$Timestamp, sub$Global_reactive_power, type = "l", ylab = "Global reactive power", xlab = "")



dev.copy(png, file = "plot4.png")

dev.off()
