## This script creates plot 3 in Exploratory Data Analysis
## course project 1
## it creates a data frame called "power"
## by reading the file household_power_consumption.txt 
## and extracting the records correspond to 
## the dates 1-Feb-2007 and 2-Feb-2007.

## Then it makes a 3-line plot of the energy sub-metering 1-3
## over the two-day period, where each sub-metering
## is represented by a line with different color,
## and a legend box associates each color to the corresponding metering
## Then it copies the plot into a file named "plot3.png"

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
par(mfcol=c(1,1))

with(power, {
     plot(datetime, Sub_metering_1,
          type="l", ylab="Energy sub metering", 
          cex.lab=0.8, cex.axis=0.8, xlab="")     
     lines(datetime, Sub_metering_2, type="l", col="red") 
     lines(datetime, Sub_metering_3, type="l", col="blue")     
     
}  )


legend("topright", cex=0.8, col = c("black","red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

##  Save the plot in .png file
dev.copy(png, file = "plot3.png")
dev.off()
