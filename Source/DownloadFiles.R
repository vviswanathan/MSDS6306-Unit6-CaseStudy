BaseDir <- "C:/Vivek/Data_Science/MSDS6306-DoingDataScience/CaseStudy1/MSDS6306-Unit6-CaseStudy"
DataDir <- paste(BaseDir,"Data", sep = "/")
SourceDir <- paste(BaseDir,"Source", sep = "/")
PaperDir <- paste(BaseDir,"Paper", sep = "/")
setwd(DataDir)
DownloadUrl <- "https://d396qusza40orc.cloudfront.net"
GDPRemoteFile<- paste(DownloadUrl, "getdata%2Fdata%2FGDP.csv", sep = "/")
CountryRemoteFile <- paste(DownloadUrl, "getdata%2Fdata%2FEDSTATS_Country.csv", sep = "/")
GDPLocalFile<- paste(DataDir, "getdata%2Fdata%2FGDP.csv", sep = "/")
CountryLocalFile <- paste(DataDir, "getdata%2Fdata%2FEDSTATS_Country.csv", sep = "/")
download.file(GDPRemoteFile, GDPLocalFile)
download.file(CountryRemoteFile, CountryLocalFile)
GDPData <- read.csv(GDPLocalFile, header = TRUE, sep = ",", skip = 4)
CountryData <- read.csv(CountryLocalFile, header = TRUE, sep = ",")
names(GDPData) <- c("CountryCode", "Ranking", "X.1", "ShortName", "EconomyinMillionsofDollars", "X.2","X.3", "X.4", "X.5", "X.6")
head(GDPData)
head(CountryData)
MergeGDPCountryData <- merge(GDPData, CountryData, by = "CountryCode", incomparables = NA)
attach(MergeGDPCountryData)
MergeGDPCountryData[with(MergeGDPCountryData, order(EconomyinMillionsofDollars))]
SortMergedData <- MergeGDPCountryData[order(MergeGDPCountryData$EconomyinMillionsofDollars),]
head(SortMergedData)
tail(SortMergedData)
tail(GDPData[order(GDPData$EconomyinMillionsofDollars),])
