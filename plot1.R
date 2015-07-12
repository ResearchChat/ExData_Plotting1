#Created using RStudio version 0.98.1103  and R i386 3.1.3 

#Load Library
  library(ggplot2)

#Load Data
  electric <- read.table("household_power_consumption.txt",   #Identify the text file (placed in the root directory) AND
                         header=T,                            #Use the headers in the file  AND
                         sep=";",                             #Separate the columns according to the ; delimiter AND
                         na.strings="?")                      #Convert ? values to NA

#Data Cleaning
  electric$Date <- as.Date(electric$Date, "%d/%m/%Y")         #Convert from Factor to Date format
  
  electricsub <- subset(electric, 
                        Date >= as.Date("2007/02/01") & 
                          Date <= as.Date("2007/02/02"))      #Subset based on Date range to a new object

#Plot Creation
  hist(electricsub$Global_active_power,                       #Create a histogram plot using the Global_active_power variable
       main="Global Active Power",                            #Define the title "Global Active Power
       xlab="Global Active Power (kilowatts)",                #Set x-axis lavel to "Global Active Power (kilowatts)
       ylab="Frequency",                                      #Set y-axis label to "Frequency"
       col="red",                                             #Color the histogram red
       cex.main=0.90,                                         #The sample plot looked like the label font sizes were smaller than default. Reduce the main title 10% 
       cex.lab=0.90,                                          #Reduce the label font size 10%
       cex.axis=.90)                                          #Reduce the axis font size 10%

#Plot Export
  dev.copy(png, 'plot1.png', width=480, height=480)           #Copy the current plot to the PNG graphic device, with file name plot1.png and setting size to 480 x 480
  dev.off()                                                   #Turning off the graphic device