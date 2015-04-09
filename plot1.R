## Load data.table library
library(data.table)

DT <- fread("household_power_consumption.txt", na.strings = "?")
DT <- DT[,Date := as.Date(Date, "%d/%m/%Y")]
sub <- subset(DT, Date == '2007-02-01' | Date == '2007-02-02')
sub <- sub[,Global_active_power := as.numeric(Global_active_power)]
globalpower <- as.vector(sub[,Global_active_power])
hist(globalpower, col = 'red', main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()
