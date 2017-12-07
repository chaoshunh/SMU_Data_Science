install.packages("downloader")

## DOWNLOADING COMPRESSED DATA AND UNCOMPRESSING
URL <- "http://bit.ly/1jXJgDh"
temp <- tempfile()
download.file(URL, temp)
UDSData <- read.csv(gzfile(temp,"uds_summary.csv"))
names(UDSData)
# unlink to free cache
unlink(temp)
gzfile()
# download secure data with RCurl

## APPLES AND ORANGES EXERCISE
# do top 10 most stable countries grow more apples or oranges
# avg amount of railroad in countries that grow more apples than oranges and vice versa?

setwd('~/desktop/Personal/DataScience/Classes/Doing_Data_Science/Data')
# get data from URL using downloader
URL <- "https://raw.githubusercontent.com/thoughtfulbloke/faoexample/master/appleorange.csv"
df <- downloader::download(URL,'appleorange.csv') # downloader actually leaves the file in your current working directory
list.files()

# use strings as factors FALSE to help parse the data more effectively
df <- read.csv('appleorange.csv', stringsAsFactors = FALSE, header=FALSE)

names(df) <- c("country","countryNumber", "products", "productNumber","tonnes","year")
df <- df[3:700,]
str(df)
df$countryNumber <- as.integer(df$countryNumber)
fslines <- which(df$country == "Food supply quantity (tonnes) (tonnes)")
df <- df[c(-fslines),]
str(df)
# clean up tonnes
df$tonnes <-gsub("\xca","",df$tonnes)
df$tonnes <-gsub(", tonnes \\(\\)","",df$tonnes)
df$tonnes <- as.numeric(df$tonnes)

df$year <- 2009

apples <-df[df$productNumber == 2617, c(1,2,5)]
names(apples)[3] = 'apples'
oranges <-df[df$productNumber == 2611, c(1,2,5)]
names(oranges)[3] = 'oranges'

# MERGING
dfClean <- merge(apples, oranges, by = "countryNumber", all=TRUE)
str(dfClean)
library(reshape2)
# this is essentially a group by tonnes, across all of the products, with products on the columns given the ~
dfClean2 <- dcast(df[,c(1:3,5)], formula=country+countryNumber ~ products, value.var="tonnes")
# find NAs across rows, ! operator is inverse
dfClean2[!complete.cases(dfClean2),]

# find the data values for country that only occur one time
table(df$country)[table(df$country) == 1]

