lotsa_medians <- function(vecLength, numVals){
  vec <- numeric(vecLength)
  for(i in 1:vecLength){
    exp <- rexp(numVals)
    vec[i] <- median(exp)
  }
  hist(vec)
  abline(v=mean(vec), col='red', lwd=2)
}
  

lotsa_medians(1000,10)
lotsa_medians(1000,50)
