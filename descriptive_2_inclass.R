# Descriptive practice


#1. Write two sentences. Save each as a seperate object in R. 

require(quanteda)

x1 <- ("I like apples") 
x2 <- ("I like oranges")

#2. Combine them into a corpus
txt <- c(x1 = "I like apples",
         x2 = "I like oranges")
corpus_txt<-corpus(txt)

#3. Make this corpus into a dfm with all pre-processing options at their defaults.

dfm_txt<-dfm(corpus_txt)

#4. Now save a second dfm, this time with stopwords removed.
dfm(txt, remove=stopwords("english"))



#5. Calculate the TTR for each of these dfms (use textstat_lexdiv). Which is higher?
  
textstat_lexdiv(dfm_txt<-dfm(corpus_txt,verbose = FALSE))

textstat_lexdiv(dfm(txt, remove=stopwords("english"),verbose = FALSE))


#6. Calculate the Manhattan distance between the two sentences you've constructed (by hand!)
corr_matrix<-textstat_readability, c("I like apples", "I like oranges")