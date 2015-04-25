plot2<-function() {
  #Open and read data file
  pwr <- read.csv2("household_power_consumption.txt")
  
  #Extract the data between 1 Feb and 2 Feb 2007
  pwr$datetime<-strptime(paste(pwr$Date, pwr$Time), format ="%d/%m/%Y %H:%M:%S")
  pwr<-pwr[pwr$datetime > "2007-01-31 23:59:59" & pwr$datetime < "2007-02-03 00:00:00",]
  
  x<-pwr[,"datetime"]
  y<-as.double(as.character(pwr[,"Global_active_power"]))
  
  #save the plot in PNG file
  png("plot2.png", width=480, height=480, units="px")
  plot (x, y, type="n", xlab="", ylab="Global Active Power (kilowatts)")
  lines(x,y)
  dev.off()
}