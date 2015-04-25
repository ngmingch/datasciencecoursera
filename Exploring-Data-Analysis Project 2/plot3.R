
library (dplyr)
library (ggplot2)

plot3 <- function() {
  ## NOTE: This function assumes the data file is in the working directory
  
  ##Read data
  NEI <- readRDS("summarySCC_PM25.rds")
  
  #Use filter() to drop data not belonging t0 Baltimore
  NEI <- filter(NEI, fips == "24510")

  #Use dplyr filter() and group_by() to group the NEI dataframe by type and year
  NEI_point_by_year<- NEI %>% filter(type == "POINT") %>% group_by(year) %>% summarise(total=sum(Emissions, na.rm=TRUE)) %>% mutate (type="POINT")
  NEI_nonpoint_by_year<- NEI %>% filter(type == "NONPOINT") %>% group_by(year) %>% summarise(total=sum(Emissions, na.rm=TRUE)) %>% mutate (type="NONPOINT")
  NEI_onroad_by_year<- NEI %>% filter(type == "ON-ROAD") %>% group_by(year) %>% summarise(total=sum(Emissions, na.rm=TRUE)) %>% mutate (type="ON-ROAD")
  NEI_nonroad_by_year<- NEI %>% filter(type == "NON-ROAD") %>% group_by(year) %>% summarise(total=sum(Emissions, na.rm=TRUE)) %>% mutate (type="NON-ROAD")

  # recombine the 4 data frames by row binding
  NEI <- rbind (NEI_point_by_year, NEI_nonpoint_by_year, NEI_onroad_by_year, NEI_nonroad_by_year)
  
  #save the plot in PNG file
  NEI_plot <- qplot (y=total, x=year, data=NEI, color=type, facets=. ~ type)
  NEI_plot + scale_x_continuous(breaks = seq(1999,2008,3)) + theme_bw() + geom_line() + labs (x = "Year") + labs (y = "Total PM2.5 Emissions (tons)") + labs (title = "Total PM2.5 Emissions in Baltimore between 1999 and 2008")
  ggsave(file="plot3.png")
}
