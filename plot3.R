power<-read.table(file="./household-power/household_power_consumption.txt", sep=";", header=TRUE, nrows=69600, as.is=TRUE)
power<-power[power$Date=="1/2/2007"|power$Date=="2/2/2007",]
power$Time <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")

with(power, {
     plot(Time, Sub_metering_1,
          type="l", ylab="Energy sub metering", 
          cex.lab=0.8, cex.axis=0.8, xlab="")     

     lines(Time, Sub_metering_2, type="l", col="red") 
     lines(Time, Sub_metering_3, type="l", col="blue")     
     
}  )


legend("topright", cex=0.8, col = c("black","red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

dev.copy(png, file = "plot3.png")
dev.off()
