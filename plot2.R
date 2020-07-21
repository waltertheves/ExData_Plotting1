t <- read.table("household_power_consumption.txt", header=TRUE, sep=";"
                , na.strings="?", colClasses = c('character', 'character'
                                                 , 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'
                                                 , 'numeric'))
t$Date <- as.Date(t$Date, '%d/%m/%Y')
t <- subset(t, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
t <- t[complete.cases(t),]
dateTime <- paste(t$Date, t$Time)
dateTime <- as.POSIXct(dateTime)
t <- t[ ,!(names(t) %in% c("Date", "Time"))]
t <- cbind(dateTime, t)

plot(t$dateTime, t$Global_active_power, type='l', xlab='',
     ylab="Global Active Power (kilowatts)")
dev.copy(png, "plot2.png", width=480, height=480)
dev.off()