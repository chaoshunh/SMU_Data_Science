library(RCurl)

myfile <- getURL('https://sakai.unc.edu/access/content/group/3d1eb92e-7848-4f55-90c3-7c72a54e7e43/public/data/bycatch.csv')
# can also use read.csv only here
df <- read.csv(textConnection(myfile))
# textConnection establishes an open() like Python instance
df['date'] = date()
dim(df)
names(df)
str(df)

url <- 'https://sakai.unc.edu/access/content/group/3d1eb92e-7848-4f55-90c3-7c72a54e7e43/public/data/bycatch.csv'

df <- source_data(url)