library(RJSONIO)
library(jsonlite)
library(RCurl)

sw_data = rbind(
  c("Anakin","male","Tatooine","41.9BBY","yes"),
  c("Amidala","female","Naboo","46BBY","no"),
  c("Leia","female","Alderaan","19BBY","no")
)

#matrix format

swdf = data.frame(sw_data)
names(swdf) = c("Name","Gender","Homeworld","Born","Jedi")

swdfJSON = jsonlite::toJSON(swdf)
sw_R = fromJSON(swdfJSON)


getForm("https://epweb.corp.apple.com/irj/portal")