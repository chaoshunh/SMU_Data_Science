library(dplyr)
library(plyr)
library(ggplot2)
# test
gdpURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
eduURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'

gdp <- read.csv(gdpURL, skip = 3, stringsAsFactors = F)[2:191,c(1,2,4,5)] # excludes lines with nulls and summary data points (192:232)
edu <- read.csv(eduURL, stringsAsFactors = F)

names(gdp) = c('code','rank','economy','usd')
gdp$usd <- as.numeric(gsub(",","",gdp$usd))

names(edu)[1] = "code"

# Q1
df <- plyr::join(gdp, edu, by = "code", type="inner")
nrow(df) # matched IDs

# Q2
df <- plyr::arrange(df, usd)
df[13,]['Short.Name'] # country name

# Q3 - Average GDP Rankings for High Income: OECD, High Income: nonOECD
df$rank <- as.integer(df$rank)
ddply(df, ~Income.Group, summarize, avgRank = mean(rank))

# Q4
ggplot(data=df, aes(x=df$rank, y=df$usd, color=df$Income.Group))+geom_point(position="jitter")

# Q5
#quantRank <- quantile(df$rank, c(.2, .4, .6, .8))
#cut(df$rank, 5, labels = c(1,2,3,4,5))
df$quantile <- cut(df$rank, 5, labels = c(1,2,3,4,5)) # why do we need quantiles here?
top38 <- subset(df, df$rank <= 38)
nrow(subset(top38, Income.Group == 'Lower middle income'))
