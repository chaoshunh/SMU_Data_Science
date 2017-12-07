# EXAMPLE OF REGEX IN R

# Using readlines to get each line, similar to pythons open('file','r')
df <- readLines("/users/patrickcorynichols/Desktop/Personal/DataScience/Classes/Doing_Data_Science/Data/baseballsalaries.txt")
grep("nuclear", df) # no captial N's picked up
# returns lines where info is found
df[2]

# metacharacter example, capture N or n
grep("[Nn]uclear", df) # no captial N's picked up
df[c(2,6)]

# beginning of line ^, end $
# lets find FredMc for FredMcGriff
idx <- grep("^FredMc", df) # uses Griffey ONLY at beginning of line
df[idx]

# find something ending in .125, batting average
idx <- grep(".125$", df)
df[idx]

# now let's find some numbers
idx<-grep("[8-9]",df)
df[idx]

# lets combine literals and multiple metacharacters
# find lines beginning with capital F and anything after
idx <- grep("^F.",df)
df[idx]

# using or pipe
# use an or with beginning, can chain these:
# we look for strings starting with Fr, Vi or Mar and any characters as long as it ends in 07
idx <- grep("^Fr|^Vi|^Mar.*07$", df)
df[idx]

# find two sets of numbers, find any amounts of numbers 0-9 as long as there is one set, 
# separated by any amount of characters, followed by another number
# get Dave Martinez
# any line starting with at least Da followed by any characters until a numeric, followed by
# any characters ending in 76
idx <- grep("^Da+.*[0-9].*76$", df)
df[idx]

# * = any number including none, + = at least one
# capturing and non capturing groups
df[grep('D.*(?:Mart|Ortiz)',df)]
