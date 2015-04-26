
library (dplyr)
library (ggplot2)

plot6 <- function() {
  ## NOTE: This function assumes the data file is in the working directory
  
  ##Read data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  #Use filter() to drop data not belonging to Baltimore and Los Angeles
  Balitmore <- filter(NEI, fips == "24510")
  LA <- filter(NEI, fips == "06037")
  
  #filter SCC codes related to vehicle emissions
  Vehicle_emmissions <- SCC[grep("*Vehicle*", SCC$EI.Sector, ignore.case=TRUE),]
  
  Baltimore_Vehicle_Emissions <- filter(Balitmore, Balitmore$SCC %in% as.character(Vehicle_emmissions$SCC))
  LA_Vehicle_Emissions <- filter(LA, LA$SCC %in% as.character(Vehicle_emmissions$SCC))
  
  #Use dplyr group_by() to group the Baltimore and LA vehicles emission dataframes by year
  Baltimore_by_year <- group_by(Baltimore_Vehicle_Emissions, year)
  LA_by_year <- group_by(LA_Vehicle_Emissions, year)
  
  #Use dplyr summarize() to sum the Emissions. Since the dataframe was grouped by year,
  #the emission total per year is generated
  Total_Baltimore_Emissions_by_year <- summarise(Baltimore_by_year, total=sum(Emissions, na.rm=TRUE))
  Total_Baltimore_Emissions_by_year<-mutate(Total_Baltimore_Emissions_by_year, city="Baltimore")
  
  Total_LA_Emissions_by_year <- summarise(LA_by_year, total=sum(Emissions, na.rm=TRUE))
  Total_LA_Emissions_by_year<-mutate(Total_LA_Emissions_by_year, city="Los Angeles")
  
  # recombine the Baltimore and LA data frames by row binding
  NEI <- rbind (Total_Baltimore_Emissions_by_year, Total_LA_Emissions_by_year)
  
  #save the plot in PNG file
  NEI_plot <- qplot (y=total, x=year, data=NEI, color=city)
  NEI_plot + scale_x_continuous(breaks = seq(1999,2008,3)) + geom_line() + labs (x = "Year") + labs (y = "Total PM2.5 Vehicle Emissions (tons)") + labs (title = "Total PM2.5 Vehicle Emissions in Baltimore and LA between 1999 and 2008")
  ggsave(file="plot6.png")
}
