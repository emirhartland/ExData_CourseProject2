#Reading the PM2.5 Emission Data and Source Classification Code Table files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the total emissions from coal cumbustion-related sources
NEISCC <- merge(NEI, SCC, by="SCC")
coal_related  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subNEISCC <- NEISCC[coal_related, ]
total_emissions_coal <- aggregate(Emissions ~ year, subNEISCC, sum)

#Creating the plot
library(ggplot2)
ggplot(data = total_emissions_coal, aes(year, Emissions, fill = year)) +
  geom_bar(stat = "identity") + 
  labs(x = "Year", y = " Total PM2.5 Emissions (tons)") +
  ggtitle('Total PM2.5 Emissions - Coal Combustion-Related Sources')
dev.copy(png, filename="plot4.png")
dev.off()