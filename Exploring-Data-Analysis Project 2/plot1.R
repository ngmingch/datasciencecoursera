
library (dplyr)

plot1 <- function() {
  ## NOTE: This function assumes the data file is in the working directory
  
  ##Read data
  NEI <- readRDS("summarySCC_PM25.rds")
  
  #Use dplyr group_by() to group the NEI dataframe by year
  NEI_by_year <- group_by(NEI, year)
  
  #Use dplyr summarize() to sum the Emissions. Since the dataframe was grouped by year,
  #the emission total per year is generated
  Total_Emissions_by_year <- summarise(NEI_by_year, total=sum(Emissions, na.rm=TRUE))

  #save the plot in PNG file
  png("plot1.png", width=480, height=480, units="px")
  plot (Total_Emissions_by_year$year, Total_Emissions_by_year$total, type="n", xlab="Year", ylab="Total Emissions (tons)")
  lines(Total_Emissions_by_year$year, Total_Emissions_by_year$total)
  dev.off()
}

