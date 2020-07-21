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

par(mfrow=c(2,2), mar=c(4,4,1,1), oma=c(0,0,2,0))
with(t, {
    plot(Global_active_power~dateTime, type="l", ylab="Global Active Power", xlab="")
    plot(Voltage~dateTime, type="l", ylab="Voltage", xlab="datetime")
    plot(Sub_metering_1~dateTime, type="l",
         ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~dateTime, col="red")
        lines(Sub_metering_3~dateTime, col="blue")
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1.5, bty="n"
               ,cex=0.6, adj=c(-0,0)
               ,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~dateTime, type="l", ylab="Global_reactive_power",
         xlab="datetime")
})
dev.copy(png, "plot4.png", width=480, height=480)
dev.off()