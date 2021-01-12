#Reading the PM2.5 Emission Data and Source Classification Code Table files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Agregating the total emissions per year
total_emissions <- aggregate(Emissions ~ year, NEI, sum)

#Creating the plot
barplot(
  total_emissions$Emissions/10^6,
  names.arg = total_emissions$year,
  xlab = "Year",
  ylab = "PM2.5 Emissions (10^6 tons)",
  main = "Total PM2.5 Emissions - All United States"
)
dev.copy(png, filename="plot1.png")
dev.off()