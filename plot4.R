# Due to large size of data, the input data will be filtered for the dates of interest 
# (i.e. Feb. 01 and Feb. 02 of 2007) as it is read into R using functions in the 'sqldf' 
# package 
fileptr <- file("household_power_consumption.txt")
housedatafeb <- sqldf('select * from fileptr where Date="1/2/2007" or Date="2/2/2007"', 
                      file.format=list(sep=";"))


# add column which combines Date and Time together and converts it to a date-time format
housedatafeb$datetime<- as.POSIXct(paste(housedatafeb$Date, housedatafeb$Time), 
                                   format="%d/%m/%Y %H:%M:%S")

#Plot 4 - contains 4 separate charts laid out in a 2x2 grid which will be saved a 480x480 PNG file
# Prepare png file for plot then draw the initial line plot
png("plot4.png",height=480,width=480,units="px")
par(mfrow=c(2,2))

#top left chart
plot(housedatafeb$datetime,housedatafeb$Global_active_power,type="l",
     ylab="Global Active Power",xlab="")

#top right chart
plot(housedatafeb$datetime,housedatafeb$Voltage,type="l",
     ylab="Voltage",xlab="datetime")

#bottom left chart
plot(housedatafeb$datetime,housedatafeb$Sub_metering_1,type="l",
     ylab="Energy sub metering",xlab="")
lines(housedatafeb$datetime,housedatafeb$Sub_metering_2,col="red")
lines(housedatafeb$datetime,housedatafeb$Sub_metering_3,col="blue")
legend("topright",lty=1, bty="n",col=c("black","red","blue"),
       legend=colnames(housedatafeb[7:9]))

#bottom right chart
plot(housedatafeb$datetime,housedatafeb$Global_reactive_power,type="l",
     ylab="Global_active_power",xlab="datetime")

#close the file device
dev.off()
