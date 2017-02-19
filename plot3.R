library(ggplot2)

#Check if NEI already exists. No need to load again and again
if (!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

#Check if SCC already exists. No need to load again and again
if (!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Get the subset for Baltimore
baltimoreNEISubset <- NEI[NEI$fips=="24510",]

# Calculate the aggregate by year.
aggregateByYear <- aggregate(Emissions ~ year+type, baltimoreNEISubset, sum)


# Open the png file with width = 640 and height = 480
png("plot3.png", width=640, height=480)

#define the plot
plt <- ggplot(aggregateByYear, aes(year, Emissions, color = type))

plt <- plt + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland from 1999 to 2008')

# print the plot
print(plt)

#turn off the device
dev.off()