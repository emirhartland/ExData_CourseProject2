#Reading the PM2.5 Emission Data and Source Classification Code Table files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the total emissions from motor vehicle sources in Baltimore
baltimore_vehicle <- NEI[(NEI$fips == "24510") & (NEI$type == "ON-ROAD"), ]
emissions_balt <- summarise(group_by(baltimore_vehicle, year), Emissions=sum(Emissions))

#Subsetting the total emissions from motor vehicle sources in Los Angeles
la_vehicle <- NEI[(NEI$fips == "06037") & (NEI$type == "ON-ROAD"), ]
emissions_la <- summarise(group_by(la_vehicle, year), Emissions=sum(Emissions))

#Combining Baltimore data with Los Angeles data
emissions_balt$County <- "Baltimore City, MD"
emissions_la$County <- "Los Angeles, CA"
total_emissions_both <- rbind(emissions_balt, emissions_la)

#Creating the plot
library(ggplot2)
ggplot(data = total_emissions_both, aes(year, Emissions, fill = County)) +
  geom_bar(stat = "identity") +
  facet_grid(.~ County, scales="free") +
  labs(x = "Year", y = "Total PM2.5 Emissions (tons)") +
  ggtitle('Total PM2.5 Emissions - Motor Vehicle Sources in Baltimore and Los Angeles')
dev.copy(png, filename="plot6.png")
dev.off()
