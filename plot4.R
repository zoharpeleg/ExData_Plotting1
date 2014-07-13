power<-read.table(file="household_power_consumption.txt", sep=";", header=TRUE, nrows=69600, as.is=TRUE)
power<-power[power$Date=="1/2/2007"|power$Date=="2/2/2007",]
power$datetime <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")

par(mfcol=c(2,2))

plot(power$datetime, power$Global_active_power, type="l", ylab="Global Active Power", xlab="", cex.lab=0.7, cex.axis=0.7)

with(power, {
        plot(datetime, Sub_metering_1,
             type="l", ylab="Energy sub metering", 
             cex.lab=0.7, cex.axis=0.7, xlab="")     
        lines(datetime, Sub_metering_2, type="l", col="red") 
        lines(datetime, Sub_metering_3, type="l", col="blue")     
        
}  )


legend("topright", cex=0.6, bty="n", xjust=1,lty=1,
       col = c("black","red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
       )

with(power, plot(datetime, Voltage,
             type="l",  
             cex.lab=0.7, cex.axis=0.7) )

with(power, plot(datetime, Global_reactive_power,
                 type="l",  
                 cex.lab=0.7, cex.axis=0.7) )

dev.copy(png, file = "plot4.png")
dev.off()
