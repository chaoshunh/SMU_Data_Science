## creating functions in R

# functions are R's verbs to objects being nouns
# bundle of commands
# functions take commands, some dont however, just enclose in parentheses
# many functions have default values identified in the help, these are
# pre-populated

# built in function round example:
numvec <- c(1.2, 3.2, 5.6, 1.2)
# use a built in for standard deviation
sd(numvec)
# get arguments for a function
args(sd)

# in this case we nest functions
round(mean(numvec, na.rm = TRUE), digits=1)

numvec2 <- c(5.2, 3.7, 10.6, 2.2)
# combine columns with c bind
numvecs <- cbind(numvec2, numvec)
#combine rows with r bind
numvecs <- rbind(numvec2, numvec)
args(rbind)

# probability that X is greater than 75 with a mean dataset of 85 and SD of 5
pnorm(75, 85, 5, lower.tail=FALSE)

# can also use the piping function %>%
# output of one function is set as the first argument of the next
mean(numvec) %>% round(digits=2)

library(MASS)
fit <- rlm(stackloss$stack.loss~stackloss$Air.Flow)
plot(fit) # to see residuals, leverage plots, QQ plots for normality, etc.



###### WRITING YOUR OWN FUNCTIONS ########
# R doesnt have built in functions, functions written by someone else
# customize R by coding own functions

# typical function syntax:start with function, take args wrapped in braces, last line of function is returned
# name <- function(args) {
         # expressions
         # value (can use return here)
         # }

# define a trim function to trim off values 
# that are less than x and greater than y
trim <- function(x, lower=0.0, upper=1.0) {
  indices <- x >= lower & x <= upper # use logical operator &, or is |
  x[indices]
}
# set x as a vector of 20 values from a random normal distribution, standard
# normal since no args specified
x <- rnorm(20)
# run trim to keep vals based on logic
trim(x)

# sample takes a random sample of values
sumdice <- function(n=2){
  x <- sample(1:6, n, replace=T) # sample from 1:6, of size n, with replacement (add back in #'s selected)
  sum(x)
}

sumdice()

