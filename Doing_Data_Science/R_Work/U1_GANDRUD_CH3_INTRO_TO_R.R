# Gandrud Getting Started with R, Chapter 3

# Object Oriented Language
# NUMERIC AND STRING OBJECTS
number <- 10
string <- 'Hello World'

# object types important, determine what methods we can use on it

vector <- c(10,20,30) # takes a single data type, auto converts to str if str involved
list <- list(10,'fifteen') # takes a combination of data types

# use mean function on vector
mean(vector)

# error using mean function on list
mean(list)

# check the data type of an object
print(class(number))

# VECTOR AND DATAFRAME OBJECTS
# data frames similar to excel tables
# data frames are a collection of vectors or arrays, fundamental data type in R

numVec <- c(2.8,2,14.8)
numVec

charVec <- c('Albania','Botswana','Cambodia')
charVec

# binding two vectors together, simply pulls together data positionally
df <- cbind(charVec,numVec)
class(df) # this is actually a matrix of data, where the data itself is converted to a single data type
          # in this case, because we have string data, its string
# index into a matrix
df[1,] # give me the first row with column headers
df[,1] # give me the first column as a vec

# to combine via rows:
df2 <- rbind(charVec,numVec) # this indexes the actual vectors along the rows, with vector names

## DATA FRAMES
# when we want different types of data vectors
df = data.frame(charVec,numVec, stringsAsFactors = F)

# The first column is our index, we can actually re-assign the index names on the rows if we want (rare)
row.names(df) = c("First","Second","Third")
df

# what data type is charVec?
class(df[,'charVec'])
# R defaults to factors with string data a lot, can use stringsAsFactors arg when calling a df to prevent this

# to get the names of the columns:
names(df)

# to reset the names, use names(x)=:
names(df) = c('Col1','Col2')
df

# COMPONENT SELECTION
# $ is the component selector, select out a column of data:
numVec = df$Col2
# or
df[,'Col2']


# USING ATTACH AND WITH
# attach attaches database to R's search path, makes var names available
# this can be dangerous, overwrites existing
attach(cars)
# dont have to selection speed with $ now
head(speed)
# detach the database
detach(cars)

# using with
with(df, { mean(Col2)})


#SUBSCRIPTS
# denoted with [], can select, columns, rows and individual values
# [rows, columns]
head(cars)
# third through seventh rows
cars[3:7,]
# fourth row, 2nd column value
cars[4,2]

cars[4,"dist"]

# we can also pass a vector of columns
cars[4,c("speed","dist")]


# FUNCTIONS AND COMMANDS
# take arguments COMMAND(ARGUMENTS)
mean(x=numVec)
?mean
round(mean(numVec), digits=1)

# instead of stacking code, use pipe
# output of one function sent to the next
library(magrittr)
mean(numVec) %>% round(digits=1)
  

# WORKSPACE AND HISTORY
# shows all objects in your workspace
ls()
rm(charVec) # remove an object

# Save the workspace into a binary
save.image('~/desktop/rimg.RData')
# when reloading, this will load all variables and necessary info of where workspace was at time of save
load(file='~/desktop/rimg.RData')

# in general not good to save binaries?
# good to save if computationally difficult process ran
# save just the large object with save
save(Comp, file='~/desktop/BLO.RData')


history

# SETTING GLOBAL R OPTIONS
# how R runs and outputs commands through entire session
options(digits=1)


# INSTALLING NEW PACKAGES AND LOADING FUNCTIONS
library(ggplot2)
# using specific package
ggplot2::qplot().....
# ensures R uses the command from the correct library here

