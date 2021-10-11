# Plot 1
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

# Group data by year
years <- group_by(data, year)

# Sum all emissions in each year
Q1 <- summarise(years, emissions = sum(Emissions, na.rm = TRUE))

# Plot
png("plot1.png", res=100)
base::plot(Q1, main="Total emissions from all sources",
           type="b")
dev.off()
