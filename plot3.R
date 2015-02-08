# Due to large size of data, the input data will be filtered for the dates of interest 
# (i.e. Feb. 01 and Feb. 02 of 2007) as it is read into R using functions in the 'sqldf' 
# package 
fileptr <- file("household_power_consumption.txt")
housedatafeb <- sqldf('select * from fileptr where Date="1/2/2007" or Date="2/2/2007"', 
                file.format=list(sep=";"))


# add column which combines Date and Time together and converts it to a date-time format
housedatafeb$datetime<- as.POSIXct(paste(housedatafeb$Date, housedatafeb$Time), 
                        format="%d/%m/%Y %H:%M:%S")

# Plot 3 - save to 480x480 PNG file
# Prepare png file for plot then draw the initial line plot
png("plot3.png",height=480,width=480,units="px")
plot(housedatafeb$datetime,housedatafeb$Sub_metering_1,type="l",
     ylab="Energy sub metering",xlab="")

# Add two additional sets of data to the chart
lines(housedatafeb$datetime,housedatafeb$Sub_metering_2,col="red")
lines(housedatafeb$datetime,housedatafeb$Sub_metering_3,col="blue")

# Add a legend in the top right corner
legend("topright",lty=1,col=c("black","red","blue"),legend=colnames(housedatafeb[7:9]))

# close the file device
dev.off()
