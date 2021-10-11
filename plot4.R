# Plot 4
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

# Subset coal combustion related data
comb <- grepl("comb", x=scc$SCC.Level.One, 
              ignore.case = T)
coal <- grepl("coal", x=scc$SCC.Level.Four, 
              ignore.case = T)
Q4scc <- scc[comb & coal, 1]
Q4data <- data[data$SCC %in% Q4scc,]

# Group data by year
Q4data <- group_by(Q4data, year)

# Sum all emissions in each year
Q4 <- summarise(Q4data, emissions = sum(Emissions, na.rm = TRUE))

# Plot
ggplot(Q4) +
  geom_line(aes(x=year, y=emissions))+
  ggtitle("Coal Combustion-Related Emissions")+
  scale_x_continuous(breaks=c(1999,2002,2005,2008))
ggsave("plot4.png", width=12, height=8, units="cm")


