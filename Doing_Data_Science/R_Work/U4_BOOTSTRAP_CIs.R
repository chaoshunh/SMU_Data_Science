# parametric confidence interval with bootstrap parametric CI
# approximate normal, know distribution we like to sample from
# often more accurate than non-parametric percentile interval

x<- rnorm(50,22,5)
xbar <- mean(x)
ser <- sd(x)/sqrt(50)
# population: original sample x, sd deviation of population is sd(x)
sampvar <- var(x)


bootnorm <- numeric(1000)

for(i in 1:1000){
  bootsamp <- sample(x, size=50, replace=TRUE)
  bootmean <- mean(bootsamp)
  bootsd <- sd(bootsamp)
  tpivot <- (bootmean-xbar)/(bootsd/sqrt(50))
  bootnorm[i] <- tpivot
}
# re-sampling tpivot value or t statistic

quant <- quantile(bootnorm, c(0.025,0.975))

# inequalities, upend must subtract the .025 quantile, lowend must subtract the .975 quantile
# due to algebra of the t-pivot and confidence interval
lowend <- xbar-quant[2]*ser
upend  <- xbar-quant[1]*ser

