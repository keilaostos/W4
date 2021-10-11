# Plot 3
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

# Group data by year
balt <- group_by(balt, year)

# Sum all emissions in each year
Q3 <- summarise(balt, emissions = sum(Emissions, na.rm = TRUE))

# Plot
ggplot(Q3) +
  geom_line(aes(x=year, y=emissions, colour=type))+
  ggtitle("Baltimore City's Emissions, by type")+
  scale_x_continuous(breaks=c(1999,2002,2005,2008))
ggsave("plot3.png", width=12, height=8, units="cm")

