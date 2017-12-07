# downloading data from Chris Gandrud's Dropbox Folder
# Using source_data function from repmis package
# File is on financial regulators



library('repmis')
#identify URL to download from
fileURL <- 'http://bit.ly/14aS5qq'

finRegulatorData <- source_data(fileURL,sep=",",header=T)

# cant do this with non-public folders
# returns SHA-1 hash to ensure data has not changed
# can set SHA-1 so that others can be sure they are using the same data files that were used to generate
# a result
# useful for source code files that underlie published results

source_data(fileURL,sep=",",header=T,sha1='testerror')

# SHA allows us to use a version or source a version