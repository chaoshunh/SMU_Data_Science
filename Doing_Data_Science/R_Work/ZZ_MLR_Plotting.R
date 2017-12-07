t <- c(2016,2015,2014,2013,2012,2011,2010,2009,2008,2007)
v <- c(277,280,248,246,331,326,306,302,331,391)

df <- data.frame(t,v)
df <- df[order(t),]

#lrg <- lm(v ~ poly(t,5))
lrg <- lm(v ~ t)
out <- data.frame(time = sort(t), prediction = predict(lrg, df))

plot(t,v)
lines(out$time,out$prediction)