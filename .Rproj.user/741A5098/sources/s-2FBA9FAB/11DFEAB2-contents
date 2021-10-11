# Plot 2

library(tidyverse)

# Download data
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "exdata_data_NEI_data.zip", sep = "/"))
unzip(zipfile = "exdata_data_NEI_data.zip")

# Read in data
scc <- readRDS(file = "Source_Classification_Code.rds")
data <- readRDS(file = "summarySCC_PM25.rds")
data <- tibble(data)

# Select data from Baltimore (fips == "24510")
balt <- filter(data, fips == "24510")

# Group data by type and year 
balt <- group_by(balt, type, year)

# Sum all emissions in each year
Q2 <- summarise(balt, emissions = sum(Emissions, na.rm = TRUE))

# Plot
png("plot2.png", res=100)
base::plot(Q2, main="Baltimore City's Emissions",
           type="b")
dev.off()
