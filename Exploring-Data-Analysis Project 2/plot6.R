
library (dplyr)
library (plyr)
library (ggplot2)

plot6 <- function() {
        ## NOTE: This function assumes the data file is in the working directory
        
        ##Read data
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        
        #Use filter() to drop data not belonging to Baltimore and Los Angeles
        NEI <- subset (NEI, fips == "24510" | fips == "06037")

        NEI$city[NEI$fips=="24510"]  <- "Baltimore" 
        NEI$city[NEI$fips=="06037"]  <- "Los Angeles" 
        
        #filter SCC codes related to vehicle emissions
        Vehicle_emmissions <- SCC[grep("*Vehicle*", SCC$EI.Sector, ignore.case=TRUE),]
        
        #filter vehicle related emissions
        NEI <- subset (NEI, NEI$SCC %in% as.character(Vehicle_emmissions$SCC))
        
        #Aggregate the data by city and year
        aggdata <- ddply(NEI, c("city", "year"), summarise, total_emissions=sum(Emissions))
                
        #save the plot in PNG file
        output_plot <- qplot (y=total_emissions, x=year, data=aggdata, color=city)
        output_plot + scale_x_continuous(breaks = seq(1999,2008,3)) + geom_line() + labs (x = "Year") + labs (y = "Total PM2.5 Vehicle Emissions (tons)") + labs (title = "Total PM2.5 Vehicle Emissions in Baltimore and LA between 1999 and 2008")
        ggsave(file="plot6.png")
}
