library(readr)
library(rvest)
library(gsubfn)
library(dplyr)
library(tidyr)
library(rjson)

#stolpci so v teh tabelah enaki
stolpci <- c("leto","država","državljanstvo","brezveze",
             "krneki","stevilka","spol","število","nula")

###


###

#prva tabela prikazuje število priseljenih
azil.pri <- read_csv("podatki/imiazil.csv", col_names = stolpci,
                       skip = 1, na = ":", locale = locale(encoding = "cp1252"))
azil.pri[c(4,5,6,9)] <- c(NULL,NULL,NULL,NULL)
azil.pri <- filter(azil.pri, država!=državljanstvo, državljanstvo!="Europe", državljanstvo != "Andorra")
azil.pri[c(6)] <- c(NULL)


#druga tabela prikazuje število pridobljenih državljanstev
azil.drz <- read_csv("podatki/citiazil.csv", col_names = stolpci,
                          skip = 1, na = ":", locale = locale(encoding = "cp1252"))
azil.drz[c(4,5,6,9)] <- c(NULL,NULL,NULL,NULL)
azil.drz <- filter(azil.drz, država!=državljanstvo, državljanstvo!="Europe", državljanstvo != "Andorra")

#tehnicni popravki tabel (umani vejco, naredi numeric,...)
azil.pri$število <- gsub(",", "", azil.pri$število)
azil.drz$število <- gsub(",", "", azil.drz$število)

azil.pri[, c(5)] <- lapply(azil.pri[, c(5)], as.numeric)
azil.drz[, c(5)] <- lapply(azil.drz[, c(5)], as.numeric)

azil.pri$država <- as.factor(unlist(azil.pri$država))
azil.drz$država <- as.factor(unlist(azil.drz$država))

###
#UVOZ PODATKOV IZ SPLETNE STRANI; PROSILCI ZA AZIL

json_file <- "http://www.pewglobal.org/wp-content/themes/pew-global/js/europes-asylum-seekers.json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))

azil <- data.frame(t(sapply(json_data, `[`)))
azil[c(1:23)] <- c(NULL)
azil[c(10)] <- c(NULL)

#preimenovanje stolpcev
letnice <- c(2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 'država')
names(azil) <- letnice

azil <- gather(azil, "leto", "število",-9)
azil <- azil[,c(2,1,3)]

azil[azil == "NULL"] <- NA

#naredimo stolpec 'stevilo' tipa 'numeric'
azil[, c(3)] <- sapply(azil[, c(3)], as.numeric)

#resen problem "cannot group column drzava, of class 'list'"
azil$država <- as.factor(unlist(azil$država))


#write.csv(azil.pri, file = 'tabela21.csv')
#write.csv(azil.drz, file = 'tabela22.csv')
#write.csv(azil, file = 'tabela3.csv')