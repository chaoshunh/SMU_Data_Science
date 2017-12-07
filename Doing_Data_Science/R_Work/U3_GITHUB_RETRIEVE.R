# GETTING DATA FROM GITHUB

library(repmis)
url <- 'https://raw.githubusercontent.com/christophergandrud/Disproportionality_Data/master/Disproportionality.csv'
df <- repmis::source_data(url)

# SHA-1 hash unique to file
str(df)

# if we want an old version, can identify old SHA-1 hash
df2 <- repmis::source_data(url, sha1='43d58daa813272f1ea38dc584fc0f616ae21cdf5')