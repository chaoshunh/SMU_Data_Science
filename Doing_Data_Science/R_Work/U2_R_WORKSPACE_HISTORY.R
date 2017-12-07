# THE R WORKSPACE AND HISTORY

# find all ojects in current workspace
ls()

# remove objects using rm
rm(df)

# save entire workspace to binary R data file use save.image(filelocation), defaults to working directory
save.image('~/desktop/testspace.RData')

# use load command to load a saved workspace to R:
load(file='~/desktop/testspace.RData')

# save a very large object to binary (e.g. a large fit model) with save()
save(comp, file='~/desktop/Comp.Rdata')

# see history with history command
history

# GLOBAL R Options with options command
# round digits to 1 decimal place
options(digits=1)

# PAGE 44 END