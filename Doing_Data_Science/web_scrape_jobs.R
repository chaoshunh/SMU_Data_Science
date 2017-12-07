library(XML)
library(RCurl)

stop = readLines("http://jmlr.csail.mit.edu/papers/volume5/lewis04a/a11-smart-stop-list/english.stop")

# takes words, removes stop words
asWords = function(txt, stopWords = stop, stem = F)
{
  words = unlist(strsplit(txt, '[[:space:]!.,;#:()/"]+'))
  words = words[words != ""]
  if(stem && require(SnowballC))
    words = wordStem(words)
  i = tolower(words) %in% tolower(stopWords)
  words[!i]
}

# redundant??? removes stop words as well...
removeStopWords = function(x, stopWords = stop)
{
  if(is.character(x))
    setdiff(x, stopWords)
  else if(is.list(x))
    lapply(x, removeStopWords, stopWords)
  else x
}


getFreeFormWords = function(doc, stopWords = stop)
{
  nodes = getNodeSet(doc,"//div[@class='job-details-container']")
  if(length(nodes) == 0)
    nodes = getNodeSet(doc, "//div[@class='job-details-container']//p")
  
  if(length(nodes) == 0)
    warning("did not find any nodes for the free form text in ", docName(doc))
  
  words = lapply(nodes, 
                 function(x)
                   strsplit(xmlValue(x),
                            "[[:space:][:punct:]]+"))
  removeStopWords(words, stopWords)
}

getSkillList = function(doc){
  lis = getNodeSet(doc, "//div[@class = 'skills']//
                          li[@class='skill-item']//
                          span[@class = 'skill-name']")
  sapply(lis, xmlValue)
}

getDatePosted = function(doc){
  xmlValue(getNodeSet(doc,
                      "//div[@class = 'job-details-container']//
                      div[@class = 'posted']/
                      span/following-sibling::text()")[[1]],
                      trim = TRUE)
  }

getLocationSalary = function(doc){
  ans = xpathSApply(doc,"//div[@class = 'details'][1]/div[position()<3]", xmlValue)
  names(ans) = c("location", "salary")
}


readPost = function(doc, stopWords = stop){
  ans = list(words = getFreeFormWords(doc, stopWords),
             datePosted = getDatePosted(doc),
             skills = getSkillList(doc))
  o = getLocationSalary(doc)
  ans[names(o)] = o
  ans
}


getPostLinks = function(doc, baseURL = "https://www.cybercoders.com/search/"){
  if(is.character(doc)) doc = htmlParse(doc)
  links = getNodeSet(doc,"//div[@class = 'job-title']/a/@href")
  getRelativeURL(as.character(links), baseURL)
}

readPagePosts = function(doc, links = getPostLinks(doc, baseURL), baseURL = "https://www.cybercoders.com/search/"){
  if(is.character(doc)) doc = htmlParse(doc)
  lapply(links, readPost())
}


txt = getForm("https://www.cybercoders.com/search/", 
              searchterms = '"Data Scientist"', 
              searchlocation = "", 
              newsearch = "true", 
              sorttype = "")

doc = htmlParse(txt, asText = TRUE)
links = getNodeSet(doc,"//div[@class = 'job-title']/a/@href")
jobLinks = getRelativeURL(as.character(links), "https://www.cybercoders.com/search/")


posts = readPagePosts(doc)