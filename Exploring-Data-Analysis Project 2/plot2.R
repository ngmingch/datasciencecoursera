
library (dplyr)

plot2 <- function() {
  ## NOTE: This function assumes the data file is in the working directory
  
  ##Read data
  NEI <- readRDS("summarySCC_PM25.rds")
  
  #Use filter() to drop data not belonging t0 Baltimore
  NEI <- filter(NEI, fips == "24510")
  
  #Use dplyr group_by() to group the NEI dataframe by year
  NEI_by_year <- group_by(NEI, year)
  
  #Use dplyr summarize() to sum the Emissions. Since the dataframe was grouped by year,
  #the emission total per year is generated
  Total_Emissions_by_year <- summarise(NEI_by_year, total=sum(Emissions, na.rm=TRUE))
  
  #save the plot in PNG file
  png("plot2.png", width=480, height=480, units="px")
  plot (Total_Emissions_by_year$year, Total_Emissions_by_year$total, type="n", xlab="Year", ylab="Total Emissions (tons)")
  lines(Total_Emissions_by_year$year, Total_Emissions_by_year$total)
  title("Total PM2.5 Emissions in Baltimore between 1999 and 2008")
  dev.off()
}
