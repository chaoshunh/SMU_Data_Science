## READING DATA IN
# read data in from a text file on a website
site <- "http://www.users.muohio.edu/hughesmr/sta333/univadmissions.txt"
df <- read.table(site, header=TRUE)

print(str(df))
print(head(df))

names(df)
# change names of columns
names(df) <- c("id","GPA_First_Yr","hs.pct","act","year")
print(names(df))

hs.pct <- df$hs.pct
length(hs.pct)
# plot a histogram
hist(hs.pct)

# delete some rows from the data frame
# delete rows 1 and 2
df[-c(1,2),]

# select rows 80-88
df[80:88,]
# select rows 81, 85, 87
df[c('81','85','87'),]

# IMPORT FROM LOCAL FILE
getwd()
setwd('~/desktop')
olivera <- read.csv('olivera.csv')