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
GDPData <- read.csv(GDPLocalFile, header = TRUE, sep = ",")
CountryData <- read.csv(CountryLocalFile, header = TRUE, sep = ",")
head(CountryData)
head(GDPData)

#merge(GDPData, CountryData, )