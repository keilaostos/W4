# Plot 5
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

# Subset motor vehicle related data
vehic <- grepl("vehicle", x=scc$SCC.Level.Two, 
               ignore.case = T)
Q5scc <- scc[vehic, 1]
Q5data <- data[data$SCC %in% Q5scc,]

# Select data from Baltimore (fips == "24510")
Q5data <- filter(Q5data, fips == "24510")

# Group data by year
Q5data <- group_by(Q5data, year)

# Sum all emissions in each year
Q5 <- summarise(Q5data, emissions = sum(Emissions, na.rm = TRUE))

# Plot
ggplot(Q5) +
  geom_line(aes(x=year, y=emissions))+
  ggtitle("Motor Vehicle Emissions in Baltimore City")+
  scale_x_continuous(breaks=c(1999,2002,2005,2008))
ggsave("plot5.png", width=12, height=8, units="cm")


