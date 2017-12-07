library(xml)
library(repmis)
library(RCurl)
library(rvest)

fileURL <- 'http://www.w3schools.com/xml/simple.xml'
out <- read_xml(fileURL)
root <- xml_root(out)
names(root)

# what's the name of the root?
xml_name(out)

# get all the children
length(xml_children(out))
xml_contents(xml_children(out))

xml_children(out, "name")

# get children of children
xml_children(xml_children(out))

# get all the values / text in the elements
xml_text(out)

# get all names
xml_text(xml_find_all(out,'.//name'))
# get all descriptions
xml_text(xml_find_all(out,'.//description'))
# get second price
xml_text(xml_find_all(out,'.//price'))[2]


# get the third child of the first child
xml_children(xml_child(out,3))


xml2::as_list(xml_find_all(out, "//name"))

# get just text back with no tags
xml_text(xml_find_all(out, "//name"))


fileURL <- "http://espn.go.com/nfl/team/stats/_/name/dal"
doc <- xml2::read_html(fileURL)

#library(XML)
#XML::htmlTreeParse(fileURL,useInternalNodes = TRUE)

# identify the attribute as class = name for "li" element
players <- xml_text(xml_find_all(doc,"//li[@class='name']"))
stats <- xml_text(xml_find_all(doc,"//ul[@class='player-info']"))



library(xml2)

pg <- read_xml("http://www.ggobi.org/book/data/olive.xml")

# get all the <record>s
recs <- xml_find_all(pg, "//record")

# extract and clean all the columns
vals <- trimws(xml_text(recs))

labs <- trimws(xml_attr(recs, "label"))

cols <- xml_attr(xml_find_all(pg, "//data/variables/*[self::categoricalvariable or
                                                      self::realvariable]"), "name")

do.call(rbind,lapply(strsplit(vals, " "),
       function(x) {
         data.frame(rbind(setNames(as.numeric(x),cols)))
       }))


dat <- do.call(rbind, lapply(strsplit(vals, "\ +"),
                             function(x) {
                               data.frame(rbind(setNames(as.numeric(x),cols)))
                             }))

dat$area_name <- labs


