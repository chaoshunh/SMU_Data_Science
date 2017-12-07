## R OBJECTS

# get help
?mean
# vectors, fundamental data type in R
# all R objects composed of vectors
numvec <- c(2.8, 2, 14.8)
charvec <- c("Albania","Botswana","Cambodia")
# cbind appends columns into a matrix, all will be same type, auto-str conversion happens here
# matrices are vectors with columns as well as rows
matrixObj <- cbind(numvec,charvec)

# this is an R list, lists take different object types
l <- list('test',1,2,3)

print(matrixObj)

# data frames allow for different types of data
# in this case we use two vectors as columns of a df
df<- data.frame(numvec,charvec)

# can use logical indexing
class(df['numvec'])
# keeps df intact

# or use $ sign
class(df$numvec)
# returns vector

# get col names of df
names(df)

# change names of rows directly, instead of leaving index
row.names(df) <- c("Idx","One","Two")
print(row.names(df))

# get the mean of a vector
mean(numvec)
# get five # summ of a vector
summary(numvec)
# get data type of vector (class)
class(numvec)

#### Component Selection and Subscripts

# R does NOT start at zero like Python, [1] is indeed the first element

newNumeric <- df$numvec

newNumeric
# pick first through third
newNumeric[1:3]
# pick first and third from vector
newNumeric[c(1,3)]

section_a <- c(3.13, 2.75, 2.15, 3.92, 1.88, 'Final Grades')

# remove final grades, or select everything except sixth position
# convert to numeric via as.numeric method
section_a <- as.numeric(section.a[-6])
sd(section_a)
mean(section_a)


### SELECTING WITH SUBSCRIPTS AND DATAFRAMES

# statistical dataset known as a data frame
# denoted by [,], first part is rows, second cols

# look at first few obs
head(cars)

# COMPONENT SELECTION IN DATAFRAMES WITH $
cars$speed
mean(cars$speed)
newVec <- cars$dist

# INDEXING INTO DATAFRAMES
# select first value from speed columns in cars df
cars[1,'speed']
# select third through seventh values in speed df, both columns
cars[3:7, ]
# select fourth value from second column (dist) in cars df
cars[4,2]
#  can also include a vector of columns to select from
cars[4,c("speed","dist")]

# now lets look at another dataset...
# what the heck is this dataset?
help(stackloss)
# str() for structure of an object, in this case a dataframe
str(stackloss)
# or simply the dimensions of the data rows x cols
dim(stackloss)
# see first ten lines
head(stackloss, 10)

### STREAMLINING AND OTHER TIPS

# streamline code by using attach and with
# attach attaches a database to R's search path
# this can conflict with existing variable names or methods
attach(cars)
# now we can just use speed and dist as set vars
speed
# get the top 6 values from speed by using head(x)
head(speed)
# last 6 values from dist
tail(dist)

# when done, detach cars
detach(cars)

# can also use with to do roughly the same but contain the assignment to a block
# this keeps the attachment localized to the with and dont have to worry about detaching
# second argument is an expression
with(df,{
      mean(numvec)
      }
    )

sessionInfo()
