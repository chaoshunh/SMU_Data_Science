x = rnorm(50,22,5)
xbar <- mean(x)
sem <- sd(x)/sqrt(length(x))
sampvar <- var(x)

iter <- 1000
bootnorm <- numeric(iter)
bootvar <- numeric(iter)

for(i in 1:iter){
  bootsamp <- sample(x, size=50, replace=T)
  bootnorm[i] <- mean(bootsamp)
  bootvar[i] <- var(bootsamp)
}

# percentile CI biased under random sampling
quantile(bootnorm, c(0.025,0.975))
quantile(bootvar, c(0.025,0.975))


x <- rbeta(50, 2,5)

# use Bias Corrected Accelerated BCA interval
library(boot)
# pass in function to index and get mean from each bootstrap sample
mymean <- function(d,i){mean(d[i])}
# set up bootstrap loop, used with function to get mean
myboot <- boot(x, mymean, R=1000)
# get percentile intervals back, tada
means <- boot.ci(myboot, type=c("perc","bca"))


mymedian <- function(d,i){median(d[i])}
mybootmed <- boot(x, mymedian, R=1000)
meds <- boot.ci(mybootmed, type=c("perc","bca"))

print(means)
print(meds)



