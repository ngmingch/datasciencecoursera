plot4<-function() {
  ##Read data
  pwr <- read.csv2("household_power_consumption.txt")
  #Filter out the data between 1 Feb and 2 Feb 2007
  pwr$datetime<-strptime(paste(pwr$Date, pwr$Time), format ="%d/%m/%Y %H:%M:%S")
  pwr<-pwr[pwr$datetime > "2007-01-31 23:59:59" & pwr$datetime < "2007-02-03 00:00:00",]
  
  x<- pwr[,"datetime"]
  
  #save plot PNG
  png("plot4.png", width=480, height=480, units="px")
  par(mfrow=c(2,2))
  
  #topleft plot
  y<- as.double(as.character(pwr[,"Global_active_power"]))
  plot (x, y, type="n", ylab="Global Active Power", xlab="")
  lines(x,y)
  
  #topright plot
  y<- as.double(as.character(pwr[,"Voltage"]))
  plot (x, y, type="n", xlab="datetime", ylab="Voltage")
  lines(x,y)
  
  #bottomleft plot
  s1<- as.double(as.character(pwr[,"Sub_metering_1"]))
  s2<- as.double(as.character(pwr[,"Sub_metering_2"]))
  s3<- as.double(as.character(pwr[,"Sub_metering_3"]))
  ylim_max<-max(s1)
  
  plot (x, s1, type="n", ylab="Energy sub metering", xlab="", ylim=c(0, ylim_max))
  lines(x,s1,col="black")
  par(new=T) # suppress refresh canvas
  
  #the next plot does not need to re-label and show the axes since the previous canvas is not refreshed
  plot (x, s2, type="n", ylab="", xlab="", ylim=c(0, ylim_max), axes=F)
  lines(x,s2,col="red")
  par(new=T) # suppress refresh canvas
  
  plot (x, s3, type="n", ylab="", xlab="", ylim=c(0, ylim_max), axes=F)
  lines(x,s3,col="blue")
  par(new=T) # suppress refresh canvas

  legend ("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)

  #bottomright plot
  y<- as.double(as.character(pwr[,"Global_reactive_power"]))
  plot (x, y, type="n", xlab="datetime", ylab="Global_reactive_power")
  lines(x,y)
  
  dev.off()
}