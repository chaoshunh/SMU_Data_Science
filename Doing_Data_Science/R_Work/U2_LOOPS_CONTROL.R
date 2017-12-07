## LOOPS IN R

# syntax - much like Java
# for (i in 1:100){
#   do some work here
#   }

n <- 20
nsim <- 1000
# create a fixed length vector of a length nsim
# numeric creates a numeunique(c(.3, .4 - .1, .5 - .2, .6 - .3, .7 - .4))ric vector of zeroes, we can fill these slots
lotsa_medians <- numeric(nsim)

for (i in 1:nsim){
  x <- rnorm(n) # create 20 normal values based on n above
  lotsa_medians[i] <- median(x) # append median value to numeric vector lotsa_medians
  }

summary(lotsa_medians)
hist(lotsa_medians)
abline(v=median(lotsa_medians), col='red', lwd=3)
mean(lotsa_medians)
length(lotsa_medians)


v <- c(1,2,3)
if(length(v) > 2)
  {print('Yes')} else
  {print('No')}


