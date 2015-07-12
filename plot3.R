#Created using RStudio version 0.98.1103  and R i386 3.1.3 

#Load Libraries

library(ggplot2)

#Load data
electric <- read.table("household_power_consumption.txt",   #Identify the text file (placed in the root directory) AND
                       header=T,                            #Use the headers in the file  AND
                       sep=";",                             #Separate the columns according to the ; delimiter AND
                       na.strings="?")                      #Convert ? values to NA

#Data Cleaning
electric$DateTime <- paste(electric$Date, electric$Time)    #Create new variable combining date and time stamp
electric$DateTime <- strptime(electric$DateTime, "%d/%m/%Y %H:%M:%S")  #Convert new variable from character to date/time format
electric$Date <- as.Date(electric$Date, "%d/%m/%Y")         #Convert from Factor to Date format

electricsub <- subset(electric, 
                      Date >= as.Date("2007/02/01") & 
                        Date <= as.Date("2007/02/02"))      #Subset based on Date range to a new object

#Plot creation
plot(electricsub$DateTime, electricsub$Sub_metering_1,      #Create a plot WITH 
     type="l",                                              #a line 
     col="black",                                           #that is black WITH
     xlab = "",                                             #x label set to blank AND
     ylab = "Energy sub metering",                          #y label set to "Energy sub meterin" AND
     cex.lab=.90,                                           #Reduce the label font size 10%
     cex.axis=.90)                                          #Reduce the axis font size 10%
     
lines(electricsub$DateTime, electricsub$Sub_metering_2,     #Overlay another plot (have to use lines or points.  plots creates a new window)
     type="l",                                              #a line
     col="red")                                             #that is red                 

lines(electricsub$DateTime, electricsub$Sub_metering_3,     #Overlay another plot WITH
     type="l",                                              #a line
     col="blue")                                            #that is blue

legend("topright",                                          #Position the legendin the top right corner
       lty=1,                                               #Use lines in the legend
       col = c("black", "red", "blue"),                      #Color the three lines grey, red and blue
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  #Label the lines Sub_metering_1, 2 and 3
        cex=0.8)                                            #Reduce the Legend font size 20%

#Plot export
dev.copy(png, 'plot3.png', width=480, height=480)           #Copy the current plot to the PNG graphic device, with file name plot1.png and setting size to 480 x 480
dev.off()                                                   #Turning off the graphic device