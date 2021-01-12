#Reading the PM2.5 Emission Data and Source Classification Code Table files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the total emissions in Baltimore City per year
baltimore <- subset(NEI, fips == "24510")
total_baltimore <- aggregate(Emissions ~ year, baltimore, sum)

#Creating the plot
barplot(
  total_baltimore$Emissions,
  names.arg = total_baltimore$year,
  xlab = "Year",
  ylab = "PM2.5 Emissions (tons)",
  main = "Total PM2.5 Emissions - Baltimore City, Maryland"
)
dev.copy(png, filename="plot2.png")
dev.off()