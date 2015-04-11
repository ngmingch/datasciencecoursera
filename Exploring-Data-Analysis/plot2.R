plot2<-function() {
  ##Read data
  pwr <- read.csv2("household_power_consumption.txt")
  #Filter out the data between 1 Feb and 2 Feb 2007
  pwr$DateTime<-strptime(paste(pwr$Date, pwr$Time), format ="%d/%m/%Y %H:%M:%S")
  pwr<-pwr[pwr$DateTime > "2007-01-31 23:59:59" & pwr$DateTime < "2007-02-03 00:00:00",]
  
  x<- pwr[,"DateTime"]
  y<- as.double(as.character(pwr[,"Global_active_power"]))
  
  #save plot PNG
  png("plot2.png", width=480, height=480, units="px")
  plot (x, y, type="n", ylab="Global Active Power (kilowatts)", xlab="")
  lines(x,y)
  dev.off()
}