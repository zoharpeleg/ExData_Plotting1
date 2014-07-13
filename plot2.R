power<-read.table(file="household_power_consumption.txt", sep=";", header=TRUE, nrows=69600, as.is=TRUE)
power<-power[power$Date=="1/2/2007"|power$Date=="2/2/2007",]
power$Time <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")
##hist(as.numeric(power$Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power (Kilowatts)")
## colnames(dat) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))
##title("Global Active Power")
plot(power$Time, power$Global_active_power, type="l", ylab="Global Active Power (Kilowatts)", xlab="")

dev.copy(png, file = "plot2.png")
dev.off()
