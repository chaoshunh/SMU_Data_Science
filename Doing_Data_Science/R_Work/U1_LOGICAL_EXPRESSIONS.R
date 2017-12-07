# BOOLEANS AND EXPRESSIONS 

gpa_section_a <- c(3.13, 3.55, 2.92, 2.73, 3.00, 3.18, 2.66, 3.76)

class(gpa_section_a)
mean(gpa_section_a)

# returns vector or array of booleans
gpa_section_a > 3.0
gpa_section_a >= 3.0

# logical indexing like pandas
gpa_section_a[gpa_section_a>3.0]

# handling NAs (missing values)
gpa_section_a <- c(3.13, 3.55, 2.92, 2.73, 3.00, 3.18, 2.66, 3.76, NA)

# run mean function, exclude NAs
mean(gpa_section_a, na.rm=T)

# find all of the NA indices
which(is.na(gpa_section_a))

# find percentage null, take mean of booleans where values are > 3
mean(gpa_section_a > 3.0, na.rm = T)

# NA: not available, any data type
# NaN: not a number, numerics only
# 0/0
# Inf, numerics only
# 1/0