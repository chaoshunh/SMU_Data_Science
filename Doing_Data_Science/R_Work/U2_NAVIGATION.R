# navigating directories and files in R

# get the current working directory
getwd()

# set a new working directory
setwd('~/desktop')

# list files in current directory (like ls in bash shell)
list.files()

# create a folder on current working directory
dir.create("ExampleDir")

# create a file in the directory
file.create('ExampleDir/Code.R')

# paste works as concatenation
path = paste(getwd(),"/ExampleDir",sep="")

# move to new directory
setwd(path)

# list the files
list.files()

### WRITING TO FILES ###

# write text into the file we just created
cat("Reproducible R Code\n",file='Code.R')
cat("more text\n",file="Code.R")
# append text instead of over-writing file with append arg
cat("even more text\n", file='Code.R',append=T) 
# check if file exists
file.exists('Code.R')
getwd()

### RENAMING FILES ###
# move code.r to current working directory as Codez.r cause 1337
file.rename(from='Code.R',to=paste(getwd(),'/Codez.R',sep=""))


