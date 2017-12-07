#1.	 Using the testdata data vector you created for the Lecture 1 practice problems:
#  45.4 44.2 36.8 35.1 39.0 60.0 47.4 41.1 45.8 35.6
#a.	Use logical referencing to calculate the standard deviation of only those values that are less than 45.
t <- c(45.4,44.2,36.8,35.1,39.0,60.0,47.4,41.1,45.8,35.6)
sd(t[t<45])
# 3.5
# a.	Write an R command that will determine how many of the vector entries are less than 45. Display the command and its output.
sum(t<45)

# a.	Write an R command that will determine how many vector entries are 
# greater than 40 but less than 55 (i.e. how many entries are between 40 and 55). 
# Display the command and its output.

sum(t< 55 & t > 40)
# a.	Write an R command that will calculate what proportion of the 
# data vector has values exceeding 40.

mean(t>40)
#[1] 0.6
setwd('~/desktop')
df <- read.table('cigsales.txt', header=1)

# a.	The variable black indicates the percentage of a given state that is 
# African-American. Using logical referencing, select from this data frame 
# only those states that have over a 15% African-American population. 
# What states get selected?

unique(df[df['black']>15,]['state'])

# a.	Extract the variable price from this data frame, 
# and place it into a vector of its own called price.vec.
price.vec <- df[,'price']

# a.	Use logical referencing to create two separate vectors in R: 
# A vector called poor containing only the income values that fall 
# below the median income value for all the states; and a vector 
# called rich containing only the income values that fall above the 
# median income value for all the states.

poor <- df[df['income'] < median(df[,'income']),]['income']
rich <- df[df['income'] > median(df[,'income']),]['income']


trim <- function(x, lower = 0.0, upper = 1.0) {
  indices <- x >= lower & x <= upper
  return(x[indices])
}
# returns all vals between lower and upper, inclusive from a vector v

trim <- function(x, lower = 0.0, upper = 1.0) x[x >= lower & x <= upper]
# does the exact same except more compactly using logical indexing directly 
# and logical expressions 
# this version does not explicity return, may be bad form though

sumdice <- function(n) {
  k <- sample(1:6, size=n, replace=TRUE)
  return(sum(k))
}

# creates a vector k with integers between 1 and 6 of size N with replacement
# it returns the sum of all the dice

# sampling without replacement when domain is smaller than requested sample size causes
# error
# Error in sample.int(length(x), size, replace, prob) : 
#  cannot take a sample larger than the population when 'replace = FALSE'



# 1.	On average, how many dots would you expect to see when you roll a fair 
# six-sided die? How can you use the function sumdice() to get a reliable estimate 
# of the average (“expected”) number of dots?

# you would expect to see a uniform distribution, however, the average should technically
# be 3.5..

rolls <- numeric(10000)
for (i in 1:10000){
  rolls[i]<- sumdice(1)
}
mean(rolls)

# 1.	Examine the following piece of R code. What is the difference between 
# the variable x and the variable y? (Note: I am not asking for a number. 
# I am asking for the difference in how they function within the code below. 
# Write your answer in sentence form.).

# x <- 42
# fred <- function(y) {
#  x <- y
#  return(y + x)
# }
#fred(13)

# x outside is completely separate from y in this case as its not in the scope
# x inside is inside the function and ultimately returns x + itself


# 1.	Create an R function named diff() that calculates the absolute 
# difference between the mean and median of a sample of values stored 
# in a vector. Then, run your function on the price.vec vector from part 2b.

diff <- function(x){
  mean(x) - median(x)
}

diff(price.vec)

for (i in 1:20) {
  print(i+3)
}

# iterates over 1 through 20, adding 3 to each position
# for instance, 1 is 4, 20 is 23



