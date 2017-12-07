plots <- c(63,25,73,89,5,12,15,96,47,30)
df<- read.xls('/users/patrickcorynichols/desktop/rectangles_Nichols.xlsx', sheet = 7)
areas <-df[df['id'] == plots]

areas <- df[match(plots,df$id),][,'area']
mean(areas)

# weight the areas
weightAreas <- 1/areas
adjustedAreas <- areas*weightAreas
sum(adjustedAreas)/sum(weightAreas)*100