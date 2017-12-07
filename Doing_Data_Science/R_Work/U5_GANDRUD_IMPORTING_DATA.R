# GANDRUD CHAPTER 6 IMPORTING DATA

# USING RCurl

# Put URL address into the object UrlAddress
urlAddress <- paste0("https://raw.githubusercontent.com/", "christophergandrud/Disproportionality",
                     "_Data/master/Disproportionality.csv") # Download Electoral disproportionality data
# paste0 continues the string across lines with no spaces without having to call sep

urlAddress1 <- paste("https://raw.githubusercontent.com/", "christophergandrud/Disproportionality",
                     "_Data/master/Disproportionality.csv", sep="") # Download Electoral disproportionality data

dataUrl <- RCurl::getURL(UrlAddress)
# Convert Data into a data frame
dispropData <- read.table(text=dataUrl, sep = ",", header = TRUE)

names(dispropData)


# Decompressing Data

# For simplicity, store the URL in an object called  URL 
URL <- "http://www.unified-democracy-scores.org/files/20140312/z/uds_summary.csv.gz" # Create a temporary file called  temp  to put the zip file into.
temp <- tempfile()
# Download the compressed file into the temporary file.
download.file(URL, temp)
# Decompress the file and convert it into a data frame
UDSData <- read.csv(gzfile(temp, "uds_summary.csv")) # Delete the temporary file.
unlink(temp)
# Show variables in data
names(UDSData)