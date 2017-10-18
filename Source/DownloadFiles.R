

# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 

# R - environment
sessionInfo()

#install packages required
install.packages("tidyverse")
install.packages("repmis")
install.packages("dplyr")
install.packages("tidyr")


# Load libraries required
library(tidyverse)
library(repmis)
library(dplyr)
library(tidyr)


# set directories for Base, Data, Source, and Paper
BaseDir <- "C:/Vivek/Data_Science/MSDS6306-DoingDataScience/CaseStudy1/MSDS6306-Unit6-CaseStudy"
DataDir <- paste(BaseDir,"Data", sep = "/")
SourceDir <- paste(BaseDir,"Source", sep = "/")
PaperDir <- paste(BaseDir,"Paper", sep = "/")

# set working directory
setwd(DataDir)

# initialize and set variable with filenames to create
filename <- c("FGDP.csv","GDP.csv")

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
GDPData <- read.csv(GDPLocalFile, header=T, quote = "\"", skip=4, na.strings = c("", "NA"))
CountryData <- read.csv(CountryLocalFile, header=T, na.strings = c("", "NA"))

# Set Column Names for GDPData 
names(GDPData) <- c("CountryCode", "Ranking", "X.1", "Long.Name", "GDPinMillionsofDollars", "X.2","X.3", "X.4", "X.5", "X.6")
RegionData <- slice(GDPData,(219:231))
WorldData <- slice(GDPData, 217)

# Check the str and names of the data sets
str(GDPData)
names(GDPData)
str(CountryData)
names(CountryData)

WorldData <- select(WorldData, CountryCode, Ranking, Long.Name, GDPinMillionsofDollars) %>%
  mutate(GDPinMillionsofDollars=gsub(",","",GDPinMillionsofDollars)) %>%
  mutate(GDPinMillionsofDollars=as.numeric(GDPinMillionsofDollars))

RegionData <- select(RegionData, CountryCode, Ranking, Long.Name, GDPinMillionsofDollars) %>%
  mutate(GDPinMillionsofDollars=gsub(",","",GDPinMillionsofDollars)) %>%
  mutate(GDPinMillionsofDollars=as.numeric(GDPinMillionsofDollars))


# Cleanse the GDPData
GDPData <- select(GDPData, CountryCode, Ranking, Long.Name, GDPinMillionsofDollars) %>%
  slice((1:215)) %>%
  mutate(GDPinMillionsofDollars=gsub(",","",GDPinMillionsofDollars)) %>%
  mutate(GDPinMillionsofDollars=as.numeric(GDPinMillionsofDollars))

# Merge Data Sets

CombinedGDPCountry <- merge(GDPData, CountryData, by = c("CountryCode"), sort = GDPData$GDPinMillionsofDollars)

