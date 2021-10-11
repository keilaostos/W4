# Question 1 ----

# Have total emissions from PM2.5 decreased in the 
# United States from 1999 to 2008? 

# Using the base plotting system, make a plot showing 
# the total PM2.5 emission from all sources for each of
# the years 1999, 2002, 2005, and 2008.

library(tidyverse)
data <- tibble(data)
sources <- group_by(data, SCC)
years <- group_by(data, year)

summarise(years, emissions = sum(Emissions, na.rm = TRUE))

Q1 <- summarise(years, emissions = sum(Emissions, na.rm = TRUE))
base::plot(Q1, main="Total emissions from all sources",
           type="b")

# Question 2 ----

# Have total emissions from PM2.5 decreased in 
# the Baltimore City, Maryland from 1999 to 2008?
# (fips == "24510") 

# Use the base plotting system to make a plot 
# answering this question.
balt <- filter(data, fips == "24510")
balt <- group_by(balt, year)

Q2 <- summarise(balt, emissions = sum(Emissions, na.rm = TRUE))
base::plot(Q2, main="Baltimore City's Emissions")

# Question 3 ----

# Of the four types of sources indicated by the 
# type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? 

# Which have seen increases in emissions from 1999–2008? 

# Use the ggplot2 plotting system to make a plot 
# answer this question.

balt <- filter(data, fips == "24510")
balt <- group_by(balt, type, year)
Q3 <- summarise(balt, emissions = sum(Emissions, na.rm = TRUE))

ggplot(Q3) +
  geom_line(aes(x=year, y=emissions, colour=type))+
  ggtitle("Baltimore City's Emissions, by type")+
  scale_x_continuous(breaks=c(1999,2002,2005,2008))

# Question 4 ----

# Across the United States, how have emissions 
# from coal combustion-related sources changed 
# from 1999–2008?

# Subset coal combustion related data
comb <- grepl("comb", x=scc$SCC.Level.One, 
              ignore.case = T)
coal <- grepl("coal", x=scc$SCC.Level.Four, 
              ignore.case = T)
Q4scc <- scc[comb & coal, 1]
Q4data <- data[data$SCC %in% Q4scc,]
Q4data <- group_by(Q4data, year)
Q4 <- summarise(Q4data, emissions = sum(Emissions, na.rm = TRUE))

ggplot(Q4) +
  geom_line(aes(x=year, y=emissions))+
  ggtitle("Coal Combustion-Related Emissions")+
  scale_x_continuous(breaks=c(1999,2002,2005,2008))


# Question 5 ----

# How have emissions from motor vehicle sources 
# changed from 1999–2008 in Baltimore City?

vehic <- grepl("vehicle", x=scc$SCC.Level.Two, 
              ignore.case = T)

Q5scc <- scc[vehic, 1]
Q5data <- data[data$SCC %in% Q5scc,]
Q5data <- filter(Q5data, fips == "24510")
Q5data <- group_by(Q5data, year)
Q5 <- summarise(Q5data, emissions = sum(Emissions, na.rm = TRUE))

ggplot(Q5) +
  geom_line(aes(x=year, y=emissions))+
  ggtitle("Motor Vehicle Emissions in Baltimore City")+
  scale_x_continuous(breaks=c(1999,2002,2005,2008))


# Question 6 ----

# Compare emissions from motor vehicle sources in 
# Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips == "06037")
# Which city has seen greater changes over time 
# in motor vehicle emissions?

vehic <- grepl("vehicle", x=scc$SCC.Level.Two, 
               ignore.case = T)

Q5scc <- scc[vehic, 1]
Q6data <- data[data$SCC %in% Q5scc,]
Q6data <- filter(Q6data, fips == "24510" | fips == "06037")
Q6data <- group_by(Q6data, fips, year)
Q6 <- summarise(Q6data, emissions = sum(Emissions, na.rm = TRUE))

city.labs <- c("Los Angeles", "Baltimore City")
names(city.labs) <- c("06037", "24510")

ggplot(Q6) +
  geom_col(aes(x=factor(year), y=emissions)) +
  facet_grid(cols = vars(fips),
             labeller = labeller(fips = city.labs))+
  ggtitle("Motor Vehicle Emissions in Baltimore City and Los Angeles")+
  scale_x_continuous(breaks=c(1999,2002,2005,2008))
  





