# Plot 6
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
Q6scc <- scc[vehic, 1]
Q6data <- data[data$SCC %in% Q6scc,]

# Select data from Baltimore (fips == "24510") and 
# Los Angeles (fips == "06037")
Q6data <- filter(Q6data, fips == "24510" | fips == "06037")

# Group data by year
Q6data <- group_by(Q6data, fips, year)

# Sum all emissions in each year
Q6 <- summarise(Q6data, emissions = sum(Emissions, na.rm = TRUE))

# Make labels for facets
city.labs <- c("Los Angeles", "Baltimore City")
names(city.labs) <- c("06037", "24510")
# Plot
ggplot(Q6) +
  geom_col(aes(x=factor(year), y=emissions)) +
  facet_grid(cols = vars(fips),
             labeller = labeller(fips = city.labs))+
  ggtitle("Motor Vehicle Emissions in Baltimore City and Los Angeles")
ggsave("plot6.png")


