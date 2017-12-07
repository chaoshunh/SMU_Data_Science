library(tidyr)
library(dplyr)
library(countrycode)
library(ggplot2)
library(repmis)
library(RCurl)
library(WDI)

## Get Data
WDIsearch("fertilizer consumption")
# names correspond to indicators
# pull fertilizer consumption data
fertConsumpData <- WDI(indicator="AG.CON.FERT.PT.ZS")
dim(fertConsumpData)
str(fertConsumpData)
head(fertConsumpData)

#iso2c, country itself
# Create wide format data for the example, make years columns, put measure into columns
spreadFert <- spread(fertConsumpData, year, AG.CON.FERT.PT.ZS)
# arrange Ascending by country
spreadFert <- arrange(spreadFert, country)

# now lets gather columns into one, identify key:value mappings as year:fert
gatheredFert <- gather(spreadFert, Year, Fert, 3:9)
# this makes columns 3:9 map to a key:value, in this case the key is year, the headers are the keys
# the values are the values in the frame itself, the fertilizer level values
str(gatheredFert)

# rename and order cols
gatheredFert <- rename(gatheredFert, year=Year, FertilizerConsumption=Fert)
gatheredFert <- gatheredFert[order(gatheredFert$country, gatheredFert$year),] # order by rows here

# subset data
# plot the data

ggplot(data=gatheredFert,aes(FertilizerConsumption))+geom_density()+xlab("\nFertilizer Consumption")


# subset the data
fertOutliers <- subset(x=gatheredFert, FertilizerConsumption > 1000)
gatheredFertSub <- subset(x=gatheredFert, FertilizerConsumption <= 1000)
gatheredFertSub <- subset(x=gatheredFert, country != 'Arab World')
# get all non null Fertilizer Consumption
gatheredFertSub <- subset(x=gatheredFertSub, !is.na(FertilizerConsumption))
str(gatheredFertSub)


# MERGING in R
# have to make sure countries in both data files are same

str(fertConsumpData)
str(gatheredFertSub)

# look at table of country from df fertConsumpData
table(fertConsumpData$country)
table(gatheredFertSub$country, fertConsumpData$country)

# change names of countries in dataframes to ensure merge works
gatheredFertSub$country[gatheredFertSub$country == "Korea, Rep."] <- "South Korea"
fertConsumpData$country[fertConsumpData$country == "Korea, Rep."] <- "South Korea"

# change fertilizer consumption to log fert consumption
gatheredFertSub$logFertConsumption <- log(gatheredFertSub$FertilizerConsumption)

summary(gatheredFertSub$logFertConsumption)
# log of 0 is infinite, change log of 0 to 0.001 by indexing:
gatheredFertSub$FertilizerConsumption[gatheredFertSub$FertilizerConsumption==0] <- 0.001
gatheredFertSub$logFertConsumption <- log(gatheredFertSub$FertilizerConsumption)
summary(gatheredFertSub$logFertConsumption)

# more indexing, changing levels to a categorical:
gatheredFertSub$FertConsGroup[gatheredFertSub$FertilizerConsumption < 18] <- 1
gatheredFertSub$FertConsGroup[gatheredFertSub$FertilizerConsumption >= 18 & gatheredFertSub$FertilizerConsumption < 81] <- 2
gatheredFertSub$FertConsGroup[gatheredFertSub$FertilizerConsumption >= 81 & gatheredFertSub$FertilizerConsumption < 158] <- 3
gatheredFertSub$FertConsGroup[gatheredFertSub$FertilizerConsumption >= 158] <- 4
# change fertCons categorical to factor
fcLabels <- c("low","medium low","medium high","high")
gatheredFertSub$FertConsGroup <- factor(gatheredFertSub$FertConsGroup, labels=fcLabels)

# can also accomplish same thing with cut function, much easier, less lines of code
gatheredFertSub$fertGrp2 <- cut(gatheredFertSub$FertilizerConsumption, breaks=c(-0.01,17.99,80.99,157.99,999.99), labels=c("low","medium low","medium high","high"))

# always understand why a variable is not the type we expect
# why is the variable not the type we expect? dig into code to understand
# always check conversions to ensure they are correct
# as.vector, as.character, as.factor, as.numeric, etc.

##### Merging Examples #####
#Disproportionality data, can also use read.csv here
#but repmis allows for secure download with hash value to ensure we get right version
urlAddress <- "https://raw.githubusercontent.com/christophergandrud/Disproportionality_Data/master/Disproportionality.csv"
dataURL <- getURL(urlAddress) # RCurl method
dispropData <- read.table(textConnection(dataURL), sep=",", header=TRUE) #textConnection opens file as text
# can also read.csv here
dim(dispropData)

# Finance Regulation Data
fileURL <- "http://bit.ly/14aS5qq"
finregulatorData <- source_data(fileURL, sep=",", header=T)
# repmis reads in data, provides SHA-1 hash for integrity check

dim(dispropData)
dim(finregulatorData)
dim(gatheredFertSub)

# merge two, clean them and merge the third
str(dispropData)
str(finregulatorData)

# pull in country code iso2c, built in function in a package above called {countrycode}
finregulatorData$iso2c <- countrycode(finregulatorData$country, origin="country.name", destination="iso2c")

str(finregulatorData)
names(finregulatorData)
names(dispropData)

# duplicates columns not merging on, can filter your columns as you see fit, though
mergeData1 <- merge(x=finregulatorData,y=dispropData,by="iso2c",all=T)
mergeData2 <- merge(finregulatorData, dispropData, union("iso2c","year"), all=T)
names(mergeData2)

# union gives back all matches, all=T does as well, can join using on.x = on.y = or c() if var names are same b/w two frames
# for left join all.X = TRUE, right join = all.Y = TRUE, inner: all = FALSE or default merge, all = TRUE for full outer
mergeData2 <- merge(mergeData2, gatheredFertSub, union("iso2c","year"), all=T)
dataDuplicates <- mergeData2[duplicated(mergeData2[,1:2]),]
nrow(dataDuplicates)
dataNotDuplicates <- mergeData2[!duplicated(mergeData2[,1:2]),]

# using dplyr: select to select data
finalCleanedData <- dplyr::select(dataNotDuplicates,-country.y, -country.x,-idn)
summary(finalCleanedData$reg_4state) # lots of NAs, impute or not?

# use RCurl for downloading secure data
# working with compressed data
temp <- tempfile() # store data in tempfile
URL <- "http://bit.ly/1jXJgDh"
download.file(URL, temp)

UDSdata <- read.csv(gzfile(temp, "uds_summary.csv")) # unzip gzfile with gzfile()
unlink(temp)