library(repmis)
library(RCurl)

site <- "http://www.users.miamioh.edu/hughesmr/sta333/baseballsalaries.txt"

setwd("/users/patrickcorynichols/desktop/Personal/DataScience/Classes/Doing_Data_Science/Data/")

download.file(site, destfile="./baseballsalaries.txt")