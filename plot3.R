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


with(t,{
    plot(Sub_metering_1~dateTime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~dateTime, col="red")
    lines(Sub_metering_3~dateTime, col="blue")
})
    legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1),
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, "plot3.png", width=480, height=480)
dev.off()