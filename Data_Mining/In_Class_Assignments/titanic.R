load("/Users/patrickcorynichols/Desktop/titanic2.raw.rdata")

head(titanic.raw)
attach(titanic.raw)

library(Matrix)
library(arules)
library(arulesViz)

rules = apriori(titanic.raw)
inspect(rules)

rules <- apriori(titanic.raw, parameter=list(minlen=2, supp=0.05, conf=0.8),
                 appearance = list(rhs=c("Survived=No","Survived=Yes"), default="lhs"), 
                 control=list(verbose=F))
rules_sorted <- sort(rules, by="lift")

# find redundant rules

subset_matrix <- is.subset(rules_sorted,rules_sorted)
subset_matrix[lower.tri(subset_matrix,diag=T)] <- NA
redundant <- colSums(subset_matrix,na.rm=T) >=1
which(redundant)

rules_pruned <- rules_sorted[!redundant]
inspect(rules_sorted)

plot(rules_sorted)
plot(rules_sorted, method="grouped", measure = 'confidence', shading='lift')
plot(rules_sorted, method="paracoord",measure='confidence', shading='lift')
plot(rules_sorted, method="matrix", measure='confidence', shading='lift')


