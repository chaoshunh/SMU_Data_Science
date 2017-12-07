# Main Idea of Statistics is that calculations from one sample erratic, predictable in long run
# multiple samples, come up with behavior
# observe over and over again, bootstrap built on this principle
# normally only one sample to work with
# pretends original sample is population, resample from original multiple times
# small sample sizes work well for boot strap

vec<- c(23.3, 26.1, 19.0, 28.8, 29.0)
# compute 95% CI for pop mean using just these numbers
# assumes normality, how to test normality? too small for any test
# LETS BOOTSTRAP!!!
# keep sample size of vector, from the vector with replacement
bootsample1 <- sample(vec, size=length(vec), replace=TRUE)
bootsample2 <- sample(vec, size=length(vec), replace=TRUE)
bootsample3 <- sample(vec, size=length(vec), replace=TRUE)

# lets build the sampling distribution of the sample mean out of our bootstrap samples
boots <- numeric(1000)
for(i in 1:1000){
  boots[i] <- mean(sample(vec, size=length(vec), replace=TRUE))
}
hist(boots)
abline(v=mean(boots), col='red')
qqnorm(boots)

