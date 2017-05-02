library(readr)
library(rvest)
library(gsubfn)
library(dplyr)
library(tidyr)

#stolpci so v prvih dveh tabelah enaki
stolpci <- c("leto","država","državljanstvo","brezveze",
             "krneki","stevilka","spol","število","nula")

#prva tabela prikazuje število priseljenih
priseljeni <- read_csv("tabeladrzav.csv", col_names = stolpci,
                       skip = 1, na = ":", locale = locale(encoding = "cp1250"))
priseljeni[c(4,5,6,9)] <- c(NULL,NULL,NULL,NULL)
#priseljeni <- filter(priseljeni, spol!='Total')

#druga tabela prikazuje število pridobljenih državljanstev
drzavljanstva <- read_csv("stdrzav.csv", col_names = stolpci,
                          skip = 1, na = ":", locale = locale(encoding = "cp1250"))
drzavljanstva[c(4,5,6,9)] <- c(NULL,NULL,NULL,NULL)
#drzavljastva <- filter(drzavljastva, spol!='Total')

#število azilantov po državah
link <- "https://en.wikipedia.org/wiki/List_of_countries_by_refugee_population"
stran <- html_session(link) %>% read_html()
azil <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[1]] %>% html_table(fill = TRUE)
azil[c(2,11,12)] <- c(NULL,NULL,NULL)
colnames(azil) <- c('država','2015','2014','2013','2012','2011','2010','2009','2008')
azil <- gather(azil, "leto", "število",-1)
azil <- azil[,c(2,1,3)]

#število prijavljenih beguncev po državah
linkk <- "https://en.wikipedia.org/wiki/List_of_countries_by_refugee_population"
strann <- html_session(linkk) %>% read_html()
begunec <- strann %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
  .[[2]] %>% html_table(fill = TRUE)
begunec[c(2,10,11)] <- c(NULL,NULL,NULL)
colnames(begunec) <- c('država','2014','2013','2012','2011','2010','2009','2008')
begunec <- gather(begunec, "leto", "število",-1)
begunec <- begunec[,c(2,1,3)]

#write.csv(priseljeni, file = 'tabela1.csv')
#write.csv(drzavljanstva, file = 'tabela2.csv')
#write.csv(azil, file = 'tabela3.csv')
#write.csv(begunec, file = 'tabela4.csv')
