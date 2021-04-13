
library(jsonlite)
library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)


##code adapted from Heather Geiger

setwd("C:/Users/kevin/Documents/GitHub/TAD_2021/R lessons/")


NYTIMES_KEY <- ("HpMzWYJVGMA5O7BlzEybtzubN0VOh2I0 ")

term <- "facebook"
begin_date <- "20210101"
end_date <- "20210401"

baseurl <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",NYTIMES_KEY, sep="")

initialQuery <- fromJSON(baseurl)

pages_2020 <- vector("list",length=5)

for(i in 0:4){
  nytSearch <- fromJSON(paste0(baseurl, "&page=", i), flatten = TRUE) %>% data.frame() 
  pages_2020[[i+1]] <- nytSearch 
  Sys.sleep(10) #I was getting errors more often when I waited only 1 second between calls. 5 seconds seems to work better.
}
facebook_20212_articles <- rbind_pages(pages_2020)



term <- "trump"
begin_date <- "20210101"
end_date <- "20210401"

baseurl <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",NYTIMES_KEY, sep="")

initialQuery <- fromJSON(baseurl)

pages_2021 <- vector("list",length=4)

for(i in 0:5){
  nytSearch <- fromJSON(paste0(baseurl, "&page=", i), flatten = TRUE) %>% data.frame()
  pages_2021[[i+1]] <- nytSearch
  Sys.sleep(10)
}
trump_2021_articles <- rbind_pages(pages_2021)





#####in-class practice: 


### save the results of two different queries from the date range jan 1 2021 - APril 1 2021

I did "trump" and "facebook"
### calculate the proportion of the headlines from each search term assigned to a given section name
table(facebook_2021_articles$response.docs.subsection_name)

table(trump_2021_articles$response.docs.subsection_name)
## create a combined dfm with the text of all of the lead paragraphs

dfmt <- dfm(trump_2021_articles, remove_punct = TRUE)
dfmf <- dfm(facebook_2021_articles, remove_punct =TRUE)

## calculate the average Flesch Reading Ease score (hint: use code form descriptive_2.R) for the lead paragraphs from each search term. Which is higher?
install.packages("quanteda")
library(quanteda)

X <- textstat_readability(facebook_2021_articles$response.docs.lead_paragraph)

mean(x$Flesch)

xx <- textstat_readability(trump_2021_articles$response.docs.lead_paragraph))

mean(x$Flesch)
