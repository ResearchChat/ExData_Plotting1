#Created using RStudio version 0.98.1103  and R i386 3.1.3

#Load Library
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

#Plot Creation
  plot(electricsub$DateTime, electricsub$Global_active_power, #Create a timeseries plot using the Global_active_power variable
       type="l",                                              #Draw lines between data points
       xlab="",                                               #x-axis label set to blank
       ylab="Global Active Power (kilowatts)",                #y-axis label set to "Global Active Power (kilowatts)"
       cex.lab=.90,                                           #Reduce the label font size 10%
       cex.axis=.90)                                          #Reduce the axis font size 10%

#Plot export
  dev.copy(png, 'plot2.png', width=480, height=480)           #Copy the current plot to the PNG graphic device, with file name plot1.png and setting size to 480 x 480
  dev.off()                                                   #Turning off the graphic device