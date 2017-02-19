#Check if NEI already exists. No need to load again and again
if (!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

#Check if SCC already exists. No need to load again and again
if (!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Calculate the aggregate by year.
aggregateByYear <- aggregate(Emissions ~ year, NEI, sum)


# Open the png file
png('plot1.png')

# Paint the barplot
barplot(height=aggregateByYear$Emissions, names.arg = aggregateByYear$year, xlab="Years", ylab=expression('Total PM'[2.5]*' emission'), main=expression('Total PM'[2.5]*' emissions for various years'))

# Close the device
dev.off()
