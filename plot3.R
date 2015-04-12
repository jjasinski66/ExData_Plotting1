## Load data.table library
library(data.table)

DT <- fread("household_power_consumption.txt", na.strings = "?")
DT <- DT[,Datetype := as.Date(Date, "%d/%m/%Y")]

## Subset only the two days we are looking at.
sub <- subset(DT, Datetype == '2007-02-01' | Datetype == '2007-02-02')

## create timestamp column to comparable Date format
sub <- sub[,Timestamp := paste(Datetype, Time, sep = " ")] 
sub$Timestamp <- as.POSIXct(sub$Timestamp,  format="%Y-%m-%d %H:%M:%S")

## convert Sub Metering 1, 2 and 3 to numeric
sub <- sub[,Sub_metering_1 := as.numeric(Sub_metering_1)]
sub <- sub[,Sub_metering_2 := as.numeric(Sub_metering_2)]
sub <- sub[,Sub_metering_3 := as.numeric(Sub_metering_3)]

## plot to png device
plot(sub$Timestamp, sub$Sub_metering_1, type = 'n', ylab = "Energy sub metering", xlab = "")
points(sub$Timestamp, sub$Sub_metering_1, type = "l")
points(sub$Timestamp, sub$Sub_metering_2, type = "l", col= "red")
points(sub$Timestamp, sub$Sub_metering_3, type = "l", col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1),
       lwd=c(2.5,2.5),col=c("black", "red", "blue"), cex = .75)


dev.copy(png, file = "plot3.png")

dev.off()
