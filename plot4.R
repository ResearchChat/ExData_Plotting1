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

#Multi-plot Creation
  par(mfrow=c(2,2), mar=c(4,4,1,1))                           #Create 4 spaces for plots (2 columns and 2 rows) and set margin spacing

#Plot Creation (Top Left)

  plot(electricsub$DateTime, electricsub$Global_active_power, #Create of aplot of DateTime by Global_active_power AND
       type="l",                                              #Draw lines between data points WITH 
       xlab="",                                               #x-axis set with a blank label AND
       ylab="Global Active Power (kilowatts)",                #y-axis set labelled "Global Active Power (kilowatts) AND
       cex.lab=.90,                                           #Reduce the label font size 10% AND
       cex.axis=.90)                                          #Reduce the axis font size 10%

#Plot Creation (Top Right)
  plot(electricsub$DateTime, electricsub$Voltage,             #Create a plot of DateTime by Voltage AND
       type="l",                                              #Draw lines between data points AND
       xlab="datetime",                                       #x-axis label set to "datetime" AND
       ylab="Voltage",                                        #y-axis label set to "Voltage AND
       cex.lab=.90,                                           #Reduce the label font size 10% AND
       cex.axis=.90)                                          #Reduce the axis font size 10%

#Plot creation (Bottom left)
  plot(electricsub$DateTime, electricsub$Sub_metering_1,      #Create a plot of DateTime by Sub_metering_1 AND 
       type="l",                                              #Draw lines between data points 
       col="black",                                            #that is grey WITH
       xlab = "",                                             #x label "DateTime" AND
       ylab = "Energy sub metering",                          #y label "Energy sub meterin" AND
       cex.lab=.90,                                           #Reduce the label font size 10% AND
       cex.axis=.90)                                          #Reduce the axis font size 10%
  
  lines(electricsub$DateTime, electricsub$Sub_metering_2,     #Overlay another plot of DateTime by Sub_metering_2 (have to use lines or points.  plots creates a new window)
        type="l",                                              #a line
        col="red")                                             #that is red                 
  
  lines(electricsub$DateTime, electricsub$Sub_metering_3,     #Overlay another plot of DateTime by Sub_metering_3 WITH
        type="l",                                              #a line
        col="blue")                                            #that is blue
  
  legend("topright",                                          #Position the legend in the top right corner
         lty=1,                                               #Use lines in the legend
         col = c("black", "red", "blue"),                      #Color the three lines grey, red and blue
         bty="n",                                              #remove border around legend
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  #Label the lines Sub_metering_1, 2 and 3
         cex=0.8)                                            #Reduce the Legend font size 20%

#Plot creation (Bottom right)
  plot(electricsub$DateTime, electricsub$Global_reactive_power, #Create a plot of DateTime by Global_reactive_power AND
       type="l",                                              #Draw lines between data points AND
       xlab="datetime",                                       #x-axis label set to "datetime" AND
       ylab="Global_reactive_power",                          #y-axis label set to "Global_reactive_power" AND 
       cex.lab=.90,                                           #Reduce the label font size 10% AND
       cex.axis=.90)                                          #Reduce the axis font size 10%

#Plot export
  dev.copy(png, 'plot4.png', width=480, height=480)           #Copy the current plot to the PNG graphic device, with file name plot1.png and setting size to 480 x 480
  dev.off()                                                   #Turning off the graphic device