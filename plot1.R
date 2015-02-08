# Due to large size of data, the input data will be filtered for the dates of interest 
# (i.e. Feb. 01 and Feb. 02 of 2007) as it is read into R using functions in the 'sqldf' 
# package 
fileptr <- file("household_power_consumption.txt")
housedatafeb <- sqldf('select * from fileptr where Date="1/2/2007" or Date="2/2/2007"', 
                file.format=list(sep=";"))


# add column which combines Date and Time together and converts it to a date-time format
housedatafeb$datetime<- as.POSIXct(paste(housedatafeb$Date, housedatafeb$Time), 
                    format="%d/%m/%Y %H:%M:%S")


# Plot 1 - save to 480x480 PNG file
# Prepare png file for plot then draw the histogram
png("plot1.png",height=480,width=480,units="px")
hist(housedatafeb$Global_active_power,main="Global Active Power",
     xlab="Global Active Power (kilowatts)",col="red")

# close the file device
dev.off()
