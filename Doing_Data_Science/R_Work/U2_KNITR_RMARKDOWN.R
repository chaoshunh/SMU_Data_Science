# R Markdown relies on knitr and a utility called Pandoc to create different types of presentation documents
# knit ties presentation of results with creation of those results

# Steps
# 1. Create a knittable markup doc (analysis code + presentation document's markup - the text and rules for how to format doc)
# 2. knitr knits, runs analysis code and converts output into the markup language you are using according to rules you tell
# 3. Inserts marked up results into a doc that only contains markup for the presentation document
# 4. Compile this markup doc as you would if you hadn't used knitr into a final PDF doc or webpage

# R Markdown
# implements variation of knitr that utilizes Pandoc to create presos in multiple formats from a knittable document written
# in markdown. Header written in YAML, can contain title, author, include ToC, link to BibTeX
# new values are denoted by being placed on a new line and indented

# code chunks must be placed into chunks in a presentation document:

#```{r chunklabel, echo = False, cache = TRUE}
# enter code here
stringObj <- c('This is a','string code block')
# ``` # close the code block

#### CODE CHUNK OPTIONS
# chunk labels can be cached and named based on the label
# echo = False will prevent code from being shown in markdown document
# cache will cache the result so it doesnt have to be re-run again