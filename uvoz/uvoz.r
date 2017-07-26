library(readr)
library(rvest)
library(gsubfn)
library(dplyr)
library(tidyr)
library(rjson)

#stolpci so v teh tabelah enaki
stolpci <- c("leto","drzava","drzavljanstvo","brezveze",
             "krneki","stevilka","spol","stevilo","nula")

###
#PRVI DVE TABELLI STA ZA IMIGRACIJE ZNOTRAJ EVROPE

#prva tabela prikazuje število priseljenih
priseljeni <- read_csv("podatki/imigrant.csv", col_names = stolpci,
                       skip = 1, na = ":", locale = locale(encoding = "cp1250"))
priseljeni[c(4,5,6,9)] <- c(NULL,NULL,NULL,NULL)
priseljeni <- filter(priseljeni, drzava!=drzavljanstvo, drzavljanstvo!="Europe")

#druga tabela prikazuje število pridobljenih državljanstev
drzavljanstva <- read_csv("podatki/ship.csv", col_names = stolpci,
                          skip = 1, na = ":", locale = locale(encoding = "cp1250"))
drzavljanstva[c(4,5,6,9)] <- c(NULL,NULL,NULL,NULL)
drzavljanstva <- filter(drzavljanstva, drzava!=drzavljanstvo, drzavljanstvo!="Europe")

#tehnicni popravki tabel (umani vejco, naredi numeric,...)
priseljeni$stevilo <- gsub(",", "", priseljeni$stevilo)
drzavljanstva$stevilo <- gsub(",", "", drzavljanstva$stevilo)

priseljeni[, c(5)] <- lapply(priseljeni[, c(5)], as.numeric)
drzavljanstva[, c(5)] <- lapply(drzavljanstva[, c(5)], as.numeric)

priseljeni$drzava <- as.factor(unlist(priseljeni$drzava))
drzavljanstva$drzava <- as.factor(unlist(drzavljanstva$drzava))

###
#DRUGI DVE TABELI STA ZA PROŠNJE ZA AZIL

#prva tabela prikazuje število priseljenih
azil.pri <- read_csv("podatki/imiazil.csv", col_names = stolpci,
                       skip = 1, na = ":", locale = locale(encoding = "cp1250"))
azil.pri[c(4,5,6,9)] <- c(NULL,NULL,NULL,NULL)
azil.pri <- filter(azil.pri, drzava!=drzavljanstvo, drzavljanstvo!="Europe")

#druga tabela prikazuje število pridobljenih državljanstev
azil.drz <- read_csv("podatki/citiazil.csv", col_names = stolpci,
                          skip = 1, na = ":", locale = locale(encoding = "cp1250"))
azil.drz[c(4,5,6,9)] <- c(NULL,NULL,NULL,NULL)
azil.drz <- filter(azil.drz, drzava!=drzavljanstvo, drzavljanstvo!="Europe")

#tehnicni popravki tabel (umani vejco, naredi numeric,...)
azil.pri$stevilo <- gsub(",", "", azil.pri$stevilo)
azil.drz$stevilo <- gsub(",", "", azil.drz$stevilo)

azil.pri[, c(5)] <- lapply(azil.pri[, c(5)], as.numeric)
azil.drz[, c(5)] <- lapply(azil.drz[, c(5)], as.numeric)

azil.pri$drzava <- as.factor(unlist(azil.pri$drzava))
azil.drz$drzava <- as.factor(unlist(azil.drz$drzava))

###
#UVOZ PODATKOV IZ SPLETNE STRANI; PROSILCI ZA AZIL

json_file <- "http://www.pewglobal.org/wp-content/themes/pew-global/js/europes-asylum-seekers.json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))

azil <- data.frame(t(sapply(json_data, `[`)))
azil[c(1:23)] <- c(NULL)
azil[c(10)] <- c(NULL)

#preimenovanje stolpcev
letnice <- c(2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 'drzava')
names(azil) <- letnice

azil <- gather(azil, "leto", "stevilo",-9)
azil <- azil[,c(2,1,3)]

azil[azil == "NULL"] <- NA

#naredimo stolpec 'stevilo' tipa 'numeric'
azil[, c(3)] <- sapply(azil[, c(3)], as.numeric)

#resen problem "cannot group column drzava, of class 'list'"
azil$drzava <- as.factor(unlist(azil$drzava))


#write.csv(priseljeni, file = 'tabela11.csv')
#write.csv(drzavljanstva, file = 'tabela12.csv')
#write.csv(azil.pri, file = 'tabela21.csv')
#write.csv(azil.drz, file = 'tabela22.csv')
#write.csv(azil, file = 'tabela3.csv')