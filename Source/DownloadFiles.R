

# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 

# R - environment
sessionInfo()

#install packages required
install.packages("tidyverse")
install.packages("repmis")
install.packages("dplyr")
install.packages("tidyr")
install.packages("ggplot2")

# Load libraries required
library(tidyverse)
library(repmis)
library(dplyr)
library(tidyr)
library(ggplot2)

# set directories for Base, Data, Source, and Paper
BaseDir <- "C:/Vivek/Data_Science/MSDS6306-DoingDataScience/CaseStudy1/MSDS6306-Unit6-CaseStudy"
DataDir <- paste(BaseDir,"Data", sep = "/")
SourceDir <- paste(BaseDir,"Source", sep = "/")
PaperDir <- paste(BaseDir,"Paper", sep = "/")

# set working directory
setwd(DataDir)

# URL for file download
DownloadUrl <- "https://d396qusza40orc.cloudfront.net"

# Set the file path in the website
GDPRemoteFile<- paste(DownloadUrl, "getdata%2Fdata%2FGDP.csv", sep = "/")
CountryRemoteFile <- paste(DownloadUrl, "getdata%2Fdata%2FEDSTATS_Country.csv", sep = "/")

# Set the file paths in the local machine
GDPLocalFile<- paste(DataDir, "getdata%2Fdata%2FGDP.csv", sep = "/")
CountryLocalFile <- paste(DataDir, "getdata%2Fdata%2FEDSTATS_Country.csv", sep = "/")

# Download the files from Remote to Local
download.file(GDPRemoteFile, GDPLocalFile)
download.file(CountryRemoteFile, CountryLocalFile)

# load data files to variables and replace all "empty" strings with "NA"
GDPDataFull <- read.csv(GDPLocalFile, header=T, quote = "\"", skip=4, na.strings = c("", "NA"))
CountryData <- read.csv(CountryLocalFile, header=T, na.strings = c("", "NA"))

# Set Column Names for GDPData 
names(GDPDataFull) <- c("CountryCode", "Ranking", "X.1", "Long.Name", "GDPinMillionsofDollars", "X.2","X.3", "X.4", "X.5", "X.6")
RegionData <- slice(GDPDataFull,(219:231))
WorldData <- slice(GDPDataFull, 217)
GDPDatawoRegion <- slice(GDPDataFull, 1:215)

# Cleanse the WorldData
WorldData <- select(WorldData, CountryCode, Ranking, Long.Name, GDPinMillionsofDollars) %>%
  mutate(GDPinMillionsofDollars=gsub(",","",GDPinMillionsofDollars)) %>%
  mutate(GDPinMillionsofDollars=as.numeric(GDPinMillionsofDollars))

# Cleanse the RegionData
RegionData <- select(RegionData, CountryCode, Ranking, Long.Name, GDPinMillionsofDollars) %>%
  mutate(GDPinMillionsofDollars=gsub(",","",GDPinMillionsofDollars)) %>%
  mutate(GDPinMillionsofDollars=as.numeric(GDPinMillionsofDollars))

# Cleanse the GDPDataFull
GDPDataFull <- select(GDPDataFull, CountryCode, Ranking, Long.Name, GDPinMillionsofDollars) %>%
  mutate(GDPinMillionsofDollars=gsub(",","",GDPinMillionsofDollars)) %>%
  mutate(GDPinMillionsofDollars=as.numeric(GDPinMillionsofDollars))

# Cleanse the GDPDatawoRegion
GDPDatawoRegion <- select(GDPDatawoRegion, CountryCode, Ranking, Long.Name, GDPinMillionsofDollars) %>%
  mutate(GDPinMillionsofDollars=gsub(",","",GDPinMillionsofDollars)) %>%
  mutate(GDPinMillionsofDollars=as.numeric(GDPinMillionsofDollars))
#Q1. Merge the data based on the country shortcode. How many of the IDs match?
# Merge Data Sets

CombinedGDPFullCountry <- merge(GDPDataFull, CountryData, by = c("CountryCode"))
# 224 IDs match on the Merged Data when GDP File included the Region Information.

CombinedGDPwoRegionCountry <- merge(GDPDatawoRegion, CountryData, by = c("CountryCode"))
# 210 IDs match on the Merged Data when GDP File included the Region Information.

#Q2. Sort the data frame in ascending order by GDP (so United States is last). What is the 13th country in the resulting data frame?
# Sort Combined Data by GDPinMillionsofDollars

CombinedGDPFullCountry <- arrange(CombinedGDPFullCountry, CombinedGDPFullCountry$GDPinMillionsofDollars)
CombinedGDPwoRegionCountry <- arrange(CombinedGDPwoRegionCountry, CombinedGDPwoRegionCountry$GDPinMillionsofDollars)

# St. Kitts and Nevis is the 13th country in both the data frames, i.e., the one including the region and the one without the region information.

#Q3. 3	What are the average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups?

select(CombinedGDPFullCountry, Income.Group, GDPinMillionsofDollars) %>%
  group_by(Income.Group) %>%
  summarise(avg = mean(GDPinMillionsofDollars, na.rm=T))

# Average GDP of High Income: nonOECD is   104,349.83 M USD
# Average GDP of High Income:    OECD is 1,483,917.13 M USD
