sample <- rnorm(50, mean=22, sd=5)
sampleMean <- mean(sample)

# generate bootstrap samples
reps <- 100
bootMeans <- numeric(reps)
for(i in 1:reps){
  bootMeans[i] <- mean(sample(sample, 50, replace=T))
}

bias <- sampleMean-mean(bootMeans)
bias2 <- bias^2
mses <- var(sample) - bias
mse <- (1/reps)*sum(bias2)

hist(bootMeans)

abline(v=sampleMean, col='red',lwd=2,lty=2)
abline(v=mean(bootMeans), col='blue', lwd=2)
abline(v=22, col='cyan',lwd=3,lty=2)

# CLT in effect with bootstrap
print(sd(bootMeans))

mape <- mean(abs((sampleMean - mean(bootMeans))/sampleMean))