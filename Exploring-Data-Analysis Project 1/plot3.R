plot3<-function() {
  #Open and read data file
  pwr <- read.csv2("household_power_consumption.txt")
  
  #Extract the data between 1 Feb and 2 Feb 2007
  pwr$datetime<-strptime(paste(pwr$Date, pwr$Time), format ="%d/%m/%Y %H:%M:%S")
  pwr<-pwr[pwr$datetime > "2007-01-31 23:59:59" & pwr$datetime < "2007-02-03 00:00:00",]
  
  datetime<- pwr[,"datetime"]
  sub1<- as.double(as.character(pwr[,"Sub_metering_1"]))
  sub2<- as.double(as.character(pwr[,"Sub_metering_2"]))
  sub3<- as.double(as.character(pwr[,"Sub_metering_3"]))
  y_max<-max(sub1)
  
  #save the plot in PNG file
  png("plot3.png", width=480, height=480, units="px")
  plot (datetime, sub1, type="n", xlab="", ylab="Energy sub metering", ylim=c(0, y_max))
  lines(datetime, sub1, col="black")
  
  #the next plot does not need to re-label and show the axes since the previous canvas is not refreshed
  par(new=T)   # do not refresh canvas
  plot (datetime, sub2, type="n", xlab="", ylab="", ylim=c(0, y_max), axes=F)
  lines(datetime, sub2, col="red")
  
  par(new=T)
  plot (datetime, sub3, type="n", xlab="", ylab="", ylim=c(0, y_max), axes=F)
  lines(datetime, sub3, col="blue")
  
  legend ("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
  
  dev.off()
}