hours <- c(27,55,24,100,18,60,0,21)
born <- c(0,1,0,1,0,1,1,1) # Born in US = 1
gender <- c(1,1,0,0,1,1,1,1) # Male = 1
grad <- c(1,0,1,0,1,0,1,1) # Graduate = 1
df <- data.frame(hours=hours, born=born, gender=gender, grad=grad)

# statistics for hours taken from sample
hrsMean <- mean(df$hours) # mean of hours
hrsSD <- sd(df$hours) # standard deviation of hours


# SAMPLING DISTRIBUTION OF PROPORTIONS
# Proportions of Born in US

# combinations of proportions from born vector
bornMean <- mean(df$born)
meansBorn <- colMeans(combn(df$born,2)) # means of all combinations of 1,0 across students
meanBorn <- mean(colMeans(combn(df$born,2))) # mean of sampling distribution of proportions
meanBorn == bornMean
hist(meansBorn)

# sample proportion Variance
# take probability of success * 1-probability success*N/N-1
seBornBrute <- sqrt(sum((meansBorn-bornMean)^2*1/28)) # brute force method of obtaining SE from Sampling Dist of Proportion
varBorn = bornMean*(1-bornMean)*(length(df$born)/(length(df$born)-1)) # CLT method, variance depends on proportion (bornMean)
seBornCLT = sqrt(varBorn/2*(1-2/8)) # sqrt(variance of proportion/2 * finite population correction)
seBornCLT == seBornBrute






# Sample Hours Sampling Distribution
# take all combinations of sample of 2 from population of 8
hoursMeans <- colMeans(combn(df$hours,2))
hoursMean <- mean(colMeans(combn(df$hours,2))) # mean of sampling distribution for total distribution
meanHours == hrsMean # mean is unbiased estimator
hist(meansHours)
abline(v=meanHours, col='red')

# mean of sampling distribution of means of hours from samples of size 2 is 38.125 as well

# standard error of hours from sampling distribution, uses original dataset of hours
hoursSE <- sqrt(sum((hoursMeans - hoursMean)^2/length(meansHours))) # brute force method
hoursSECLT <- sqrt(hrsSD^2/2*(1-2/length(df$hours))) # CLT method with finite population correction
# as sample size larger, se smaller
hist(hoursMeans)




# Stratified Examples of Calculating Mean and Variance
# One unit randomly selected from each gender
# 12 possible samples
fem <- subset(df, gender==0)
male <- subset(df, gender==1)

# weight the results since pulling from stratified source
# female represents herself and 1 other, so 2 and male represents himself and 6 others, so 8
# divide by 8
counter = 1
means <- numeric(12)
for(i in fem[,'hours']){
  for(j in male[,'hours']){
      means[counter] = (2/8*i+6/8*j)
      counter = counter + 1
    }
}

genderMean <- mean(means)
genderSE <- sqrt(sum((means-stratMean)^2*(1/12)))

# variability is slightly reduced
# this was a stratified random design


# Stratification based on graduate/undergrad status
under <- subset(df, grad==0)
grad <- subset(df, grad==1)


counter = 1
means <- numeric(15)
for(i in under[,'hours']){
  for(j in grad[,'hours']){
    means[counter] = (3/8*i+5/8*j)
    counter = counter + 1
  }
}

classMean <- mean(means)
classSD <- sqrt(sum((means-stratMean)^2*(1/15)))
hist(means)

