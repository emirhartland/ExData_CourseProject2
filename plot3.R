#Reading the PM2.5 Emission Data and Source Classification Code Table files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the total emissions in Baltimore City per year and type
baltimore <- subset(NEI, fips == "24510")
total_baltimore_type <- aggregate(Emissions ~ year + type, baltimore, sum)

#Creating the plot
library(ggplot2)
ggplot(data = total_baltimore_type, aes(year, Emissions, color = type)) +
  geom_line() + 
  labs(x = "Year", y = " Total PM2.5 Emissions (tons)") +
  ggtitle('Total PM2.5 Emissions - Baltimore City, Maryland')
dev.copy(png, filename="plot3.png")
dev.off()