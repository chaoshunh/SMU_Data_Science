# API Package Example: WDI Package - World Bank Development Indicators
# Gather data on fertilizer consumption
# WDI package has methods such as WDIsearch to find data available at World Bank

library(WDI)

WDIsearch("fertilizer consumption")

##      indicator
## [1,] "AG.CON.FERT.MT"
## [2,] "AG.CON.FERT.PT.ZS"
## [3,] "AG.CON.FERT.ZS"
##      name
## [1,] "Fertilizer consumption (metric tons)"
## [2,] "Fertilizer consumption (% of fertilizer production)"
## [3,] "Fertilizer consumption (kilograms per hectare of arable land)"

# get a selection of indicator numbers and names

# gather dataset on fertilizer consumption in kg per hectare of arable land with AG.CON.FERT.ZS

fertData <- WDI(indicator='AG.CON.FERT.ZS')
head(fertData)

# four variables: iso2c, country, AG.CON.FERT.ZS, year


# WEB SCRAPING

# data stored in HTML table
# can use packages such as the XML package for handling HTML tables and XML formatted data
# rvest package provides easy to use set of functions with capabilities similar and superior to XML
# If JSON, read with rjson or RJSONIO packages

# learn XML, HTML, JSON, Javascipt, use regex, etc.
library(plyr)
library(dplyr)

fertData <- ddply(fertData, 'country', transform, prop = AG.CON.FERT.ZS/sum(AG.CON.FERT.ZS))
fertCounts <- count(fertData, "country")
fertOvr <- ddply(fertData, "country", summarise, freq_all = sum(AG.CON.FERT.ZS, na.rm=T))
fertOvr <- transform(fertOvr, prop_all = freq_all/sum(freq_all))
fert <- join(fertData, fertOvr, type='left', by = 'country')

# summarise(fertData,mean=mean(year))
# summarise(fertData,mean=mean(AG.CON.FERT.ZS, na.rm=T),mean2=mean(AG.CON.FERT.ZS, na.rm=T) )
# group by multiples with ddply
# head(ddply(fertData, c("country"), summarise, N=length(year), mean=mean(AG.CON.FERT.ZS)))