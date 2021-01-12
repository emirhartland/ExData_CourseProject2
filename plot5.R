#Reading the PM2.5 Emission Data and Source Classification Code Table files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the total emissions from motor vehicle sources in Baltimore
baltimore_vehicle <- NEI[(NEI$fips == "24510") & (NEI$type == "ON-ROAD"), ]
emissions_balt <- summarise(group_by(baltimore_vehicle, year), Emissions=sum(Emissions))

#Creating the plot
library(ggplot2)
ggplot(data = emissions_balt, aes(year, Emissions, fill = year)) +
  geom_bar(stat = "identity") +
  labs(x = "Year", y = "Total PM2.5 Emissions (tons)") +
  ggtitle('Total PM2.5 Emissions - Motor Vehicle Sources in Baltimore')
dev.copy(png, filename="plot5.png")
dev.off()
