plot1<-function() {
  ##Read data
  pwr <- read.csv2("household_power_consumption.txt")
  #Filter out the data between 1 Feb and 2 Feb 2007
  pwr$Date<-as.Date(pwr$Date, format="%d/%m/%Y")
  pwr<-pwr[pwr$Date > "2007-01-31" & pwr$Date < "2007-02-03",]
  
  x<- as.double(as.character(pwr[,"Global_active_power"]))
  
  #save plot PNG
  png("plot1.png", width=480, height=480, units="px")
  hist(x, xlab = "Global Active Power (kilowatts)", main="Global Active Power", col="red")
  dev.off()
}