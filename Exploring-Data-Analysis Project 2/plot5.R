
library (dplyr)

plot5 <- function() {
  ## NOTE: This function assumes the data file is in the working directory
  
  ##Read data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  #Use filter() to drop data not belonging to Baltimore
  NEI <- filter(NEI, fips == "24510")
  
  #filter SCC codes related to vehicle emissions
  Vehicle_emmissions <- SCC[grep("*Vehicle*", SCC$EI.Sector, ignore.case=TRUE),]

  NEI_Vehicle_Emissions <- filter(NEI, NEI$SCC %in% as.character(Vehicle_emmissions$SCC))
  
  #Use dplyr group_by() to group the NEI dataframe by year
  NEI_by_year <- group_by(NEI_Vehicle_Emissions, year)
  
  #Use dplyr summarize() to sum the Emissions. Since the dataframe was grouped by year,
  #the emission total per year is generated
  Total_Emissions_by_year <- summarise(NEI_by_year, total=sum(Emissions, na.rm=TRUE))
  
  #save the plot in PNG file
  png("plot5.png", width=680, height=680, units="px")
  plot (Total_Emissions_by_year$year, Total_Emissions_by_year$total, type="n", xlab="Year", ylab="Total Emissions (tons)")
  lines(Total_Emissions_by_year$year, Total_Emissions_by_year$total)
  title("Total PM2.5 Vehicle-related Emissions in Baltimore between 1999 and 2008")
  dev.off()
}
