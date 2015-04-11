## Load data.table library
library(data.table)

DT <- fread("household_power_consumption.txt", na.strings = "?")
DT <- DT[,Datetype := as.Date(Date, "%d/%m/%Y")]

## Subset only the two days we are looking at.
sub <- subset(DT, Datetype == '2007-02-01' | Datetype == '2007-02-02')

## create timestamp column to comparable Date format
sub <- sub[,Timestamp := paste(Datetype, Time, sep = " ")] 
sub$Timestamp <- as.POSIXct(sub$Timestamp,  format="%Y-%m-%d %H:%M:%S")

## convert Global_active_power to numeric
sub <- sub[,Global_active_power := as.numeric(Global_active_power)]

## plot to png device
plot(sub$Timestamp, sub$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, file = "plot2.png")

dev.off()

