
library (dplyr)

plot4 <- function() {
  ## NOTE: This function assumes the data file is in the working directory
  
  ##Read data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  #filter SCC codes related to coal combustion
  Fuel_Comb <- SCC[grep("Fuel Comb", SCC$EI.Sector, ignore.case=TRUE),]
  Fuel_Comb_Coal <- Fuel_Comb[grep("Coal", Fuel_Comb$EI.Sector, ignore.case=TRUE),]

  NEI_Fuel_Comb_Coal <- filter(NEI, NEI$SCC %in% as.character(Fuel_Comb_Coal$SCC))
  
  #Use dplyr group_by() to group the NEI dataframe by year
  NEI_by_year <- group_by(NEI_Fuel_Comb_Coal, year)
  
  #Use dplyr summarize() to sum the Emissions. Since the dataframe was grouped by year,
  #the emission total per year is generated
  Total_Emissions_by_year <- summarise(NEI_by_year, total=sum(Emissions, na.rm=TRUE))
  
  #save the plot in PNG file
  png("plot4.png", width=680, height=680, units="px")
  plot (Total_Emissions_by_year$year, Total_Emissions_by_year$total, type="n", xlab="Year", ylab="Total Emissions (tons)")
  lines(Total_Emissions_by_year$year, Total_Emissions_by_year$total)
  title("Total PM2.5 Coal-related Emissions in the U.S.A between 1999 and 2008")
  dev.off()
}
