## This script creates plot 4 in Exploratory Data Analysis
## course project 1
## it creates a data frame called "power"
## by reading the file household_power_consumption.txt 
## and extracting the records correspond to 
## the dates 1-Feb-2007 and 2-Feb-2007.

## Then it makes 4 plots on one page as follows:
## Global active power vs time - as in plot 2
## Energy sub-metering 1-3 vs. time, as in plot 3
## Voltage vs. time
## Global reactive power vs. time


## Using SQL commands to read only the relevant lines:
## file <- "household_power_consumption.txt"
## mySql <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
## power <- read.csv.sql(file, mySql, sep=";", na.strings="?")
## This was my preferred method since it requires no prior 
## knowledge of the data file, but i could not make 
## read.csv2.sql work on my setup, while read.csv.sql, which did work
## did not accept the na.strings parameters

## A "classic" alternative would then be: 
## reading the first 69,000 lines  
## and then extracting the relevant dates
## (runs faster but requires more storage and prior knowledge of the file)
power<-read.table(file="household_power_consumption.txt", sep=";", header=F, nrows=69600, as.is=TRUE, na.strings="?")
colnames(power) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))
power<-power[power$Date=="1/2/2007"|power$Date=="2/2/2007",]

## Creating a new date-and-time column:
power$datetime <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")

## Prepare the plot layout
par(mfcol=c(2,2))


## First plot (same as in plot 2)
plot(power$datetime, power$Global_active_power, type="l", ylab="Global Active Power", xlab="", cex.lab=0.7, cex.axis=0.7)

## Second plot (same as in plot 3)
with(power, {
        plot(datetime, Sub_metering_1,
             type="l", ylab="Energy sub metering", 
             cex.lab=0.7, cex.axis=0.7, xlab="")     
        lines(datetime, Sub_metering_2, col="red") 
        lines(datetime, Sub_metering_3, col="blue")     
        
}  )

## add legend (no border)
legend("topright", cex=0.6, bty="n", xjust=1,lty=1,
       col = c("black","red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
       )

## Third plot - top right
with(power, plot(datetime, Voltage,
             type="l",  
             cex.lab=0.7, cex.axis=0.7) )

## Fourth plot - bottom right
with(power, plot(datetime, Global_reactive_power,
                 type="l",  
                 cex.lab=0.7, cex.axis=0.7) )

##  Save the plot in .png file
dev.copy(png, file = "plot4.png")
dev.off()
