library(ggplot2)

#Check if NEI already exists. No need to load again and again
if (!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
}

#Check if SCC already exists. No need to load again and again
if (!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

#Check if merged file exists. If no need to create
if (!exists("mergeData")) {
  #merge the 2 files
  mergeData <- merge(NEI, SCC, by="SCC")
}


# fetch all vehicle records from the merged Data
vehicle  <- grepl("vehicle", mergeData$Short.Name, ignore.case=TRUE)
subsetMergeData <- mergeData[vehicle, ]

#Subset for baltimore and LosAngeles
baltimoreLAVehicles <- subset(subsetMergeData, fips == "24510" | fips == "06037")

# Aggregate for plot
aggregateByYear <- aggregate(Emissions ~ year + fips, baltimoreLAVehicles, sum)

# Set the appropriate name
aggregateByYear$fips[aggregateByYear$fips=="24510"] <- "Baltimore, MD"
aggregateByYear$fips[aggregateByYear$fips=="06037"] <- "Los Angeles, CA"


# Open the png file with width = 640 and height = 480
png("plot6.png", width=1080, height=480)


#define the plot
plt <- ggplot(aggregateByYear, aes(factor(year), Emissions))
plt <- plt + facet_grid(. ~ fips)
plt <- plt + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD vs Los Angeles, CA 1999-2008')

print(plt)

# Turn off the plot
dev.off()
