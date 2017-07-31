# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(dplyr)
library(readr)
library(tibble)
library(scales)


###
#DRUGI DEL KODE: ZA AZIL

#vsota po državah
azil.po.drzavah.priseljeni <- azil.pri %>% group_by(država) %>% summarise(skupno = sum(število, na.rm=TRUE))
azil.po.drzavah.drzavljanstva <- azil.drz %>% group_by(država) %>% summarise(skupno = sum(število, na.rm=TRUE))

#vsota po izvoru (po državljanstvu)
azil.po.drzavljanstvu.priseljeni <- azil.pri %>% group_by(državljanstvo) %>% summarise(skupno = sum(število, na.rm=TRUE)) 
azil.po.drzavljanstvu.drzavljanstva <- azil.drz %>% group_by(državljanstvo) %>% summarise(skupno = sum(število, na.rm=TRUE))

max5.azil.drzavah.priseljeni <- top_n(azil.po.drzavah.priseljeni, 5)

max5.azil.drzavah.drzavljanstva <- top_n(azil.po.drzavah.drzavljanstva, 5)

#iz katerih drzav so se priseljevali v prve tri drzave
spanija.azil <- azil.pri %>% filter(država=="Spain")
spanija.azil <- spanija.azil %>% group_by(državljanstvo) %>% summarise(skupno = sum(število, na.rm=TRUE))
spanija.azil5 <- top_n(spanija.azil, 5)

italija.azil <- azil.pri %>% filter(država=="Italy")
italija.azil <- italija.azil %>% group_by(državljanstvo) %>% summarise(skupno = sum(število, na.rm=TRUE))
italija.azil5 <- top_n(italija.azil, 5)

uk.azil <- azil.pri %>% filter(država=="United Kingdom")
uk.azil <- uk.azil %>% group_by(državljanstvo) %>% summarise(skupno = sum(število, na.rm=TRUE))
uk.azil5 <- top_n(uk.azil, 5)

bel.azil <- azil.pri %>% filter(država=="Belgium")
bel.azil <- bel.azil %>% group_by(državljanstvo) %>% summarise(skupno = sum(število, na.rm=TRUE))
bel.azil5 <- top_n(bel.azil, 5)

sw.azil <- azil.pri %>% filter(država=="Sweden")
sw.azil <- sw.azil %>% group_by(državljanstvo) %>% summarise(skupno = sum(število, na.rm=TRUE))
sw.azil5 <- top_n(sw.azil, 5)

#OPOMBA: NA EUROSTATU SO ZA NEKATERE državE SLABI PODATKI (NPR ZA NEMCIJA-SIRIJA)

#obdelava tabele iz spletne strani

#tabela vsote za vsako državo po letih
po.drzavah.azil <- azil %>% group_by(država) %>% summarise(skupno = sum(število, na.rm=TRUE))

max5.azil <- top_n(po.drzavah.azil, 5)
min5.azil <- top_n(po.drzavah.azil, -5)

###
#RISANJE GRAFOV

### v teh stirih tabelah je to kar je v graf1
#pp.uk <- azil.pri %>% filter(drzava=="United Kingdom") %>% group_by(leto) %>% summarise(skupno = sum(število, na.rm=TRUE))
#pp.it <- azil.pri %>% filter(drzava=="Italy") %>% group_by(leto) %>% summarise(skupno = sum(število, na.rm=TRUE))
#pp.sp <- azil.pri %>% filter(drzava=="Spain") %>% group_by(leto) %>% summarise(skupno = sum(število, na.rm=TRUE))
#pp.slo <- azil.pri %>% filter(drzava=="Slovenia") %>% group_by(leto) %>% summarise(skupno = sum(število, na.rm=TRUE))

graf1 <- ggplot(azil.pri %>% filter(država %in% c("United Kingdom", "Italy",
                                                  "Spain", "Slovenia")) %>%
                  group_by(leto, država) %>% summarise(skupno = sum(število, na.rm=TRUE)),
                aes(x = leto, y = skupno/1000, color = država)) + geom_line() +
  ylab("Število (x1000)") + xlab("Leto") + guides(color = guide_legend(title = "Država")) +
  theme_classic() + ggtitle("Število priseljenih ljudi")
#print(graf1)


grafuk<-ggplot(data = uk.azil5, aes(x=državljanstvo,y=skupno/1000))+geom_bar(stat="identity", fill="steelblue3")+
  ggtitle("Najpogostejša državljanstva priseljenih ljudi v Veliki Britaniji")+
  ylab("Število (x1000)") + xlab("Državljanstvo")+theme_classic()
#print(grafuk)


grafit<-ggplot(data = italija.azil5, aes(x=državljanstvo,y=skupno/1000))+geom_bar(stat="identity", fill="steelblue3")+
  ggtitle("Najpogostejša državljanstva priseljenih ljudi v Italiji")+
  ylab("Število (x1000)") + xlab("Državljanstvo")+theme_classic()
#print(grafit)

grafsp<-ggplot(data = spanija.azil5, aes(x=državljanstvo,y=skupno/1000))+geom_bar(stat="identity", fill="steelblue3")+
  ggtitle("Najpogostejša državljanstva priseljenih ljudi v Španiji")+
  ylab("Število (x1000)") + xlab("Državljanstvo")+theme_classic()
#print(grafsp)

graf2 <- ggplot(azil.drz %>% filter(država %in% c("France", "Italy",
                                                  "United Kingdom","Germany")) %>%
                  group_by(leto, država) %>% summarise(skupno = sum(število, na.rm=TRUE)),
                aes(x = leto, y = skupno/1000, color = država)) + geom_line() +
  ylab("Število (x1000)") + xlab("Leto") + guides(color = guide_legend(title = "Država")) +
  theme_classic() + ggtitle("Države, ki so podelile največ državljanstev")
#print(graf2)


###zemljevidi

svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
                        "ne_110m_admin_0_countries", encoding = "cp1252") %>% pretvori.zemljevid()
#preimnovanje nekaterih držav (mogoče bi se dalo bolj elegantno =) )
azil.po.drzavljanstvu.priseljeni$državljanstvo[
  azil.po.drzavljanstvu.priseljeni$državljanstvo=="China (including Hong Kong)"]<-"China"
azil.po.drzavljanstvu.priseljeni$državljanstvo[
  azil.po.drzavljanstvu.priseljeni$državljanstvo=="South Korea"]<-"Republic of Korea"
azil.po.drzavljanstvu.priseljeni$državljanstvo[
  azil.po.drzavljanstvu.priseljeni$državljanstvo=="North Korea"]<-"Dem. Rep. Korea"
azil.po.drzavljanstvu.priseljeni$državljanstvo[
  azil.po.drzavljanstvu.priseljeni$državljanstvo=="Myanmar/Burma"]<-"Myanmar"
azil.po.drzavljanstvu.priseljeni$državljanstvo[
  azil.po.drzavljanstvu.priseljeni$državljanstvo=="Gambia, The"]<-"The Gambia"
azil.po.drzavljanstvu.priseljeni$državljanstvo[
  azil.po.drzavljanstvu.priseljeni$državljanstvo=="Congo"]<-"Republic of Congo"
azil.po.drzavljanstvu.priseljeni$državljanstvo[
  azil.po.drzavljanstvu.priseljeni$državljanstvo=="Laos"]<-"Lao PDR"

uk.azil$državljanstvo[
  uk.azil$državljanstvo=="China (including Hong Kong)"]<-"China"
uk.azil$državljanstvo[
  uk.azil$državljanstvo=="South Korea"]<-"Republic of Korea"
uk.azil$državljanstvo[
  uk.azil$državljanstvo=="North Korea"]<-"Dem. Rep. Korea"
uk.azil$državljanstvo[
  uk.azil$državljanstvo=="Myanmar/Burma"]<-"Myanmar"
uk.azil$državljanstvo[
  uk.azil$državljanstvo=="Gambia, The"]<-"The Gambia"
uk.azil$državljanstvo[
  uk.azil$državljanstvo=="Congo"]<-"Republic of Congo"
uk.azil$državljanstvo[
  uk.azil$državljanstvo=="Laos"]<-"Lao PDR"

spanija.azil$državljanstvo[
  spanija.azil$državljanstvo=="China (including Hong Kong)"]<-"China"
spanija.azil$državljanstvo[
  spanija.azil$državljanstvo=="South Korea"]<-"Republic of Korea"
spanija.azil$državljanstvo[
  spanija.azil$državljanstvo=="North Korea"]<-"Dem. Rep. Korea"
spanija.azil$državljanstvo[
  spanija.azil$državljanstvo=="Myanmar/Burma"]<-"Myanmar"
spanija.azil$državljanstvo[
  spanija.azil$državljanstvo=="Gambia, The"]<-"The Gambia"
spanija.azil$državljanstvo[
  spanija.azil$državljanstvo=="Congo"]<-"Republic of Congo"
spanija.azil$državljanstvo[
  spanija.azil$državljanstvo=="Laos"]<-"Lao PDR"

afrika.azija <- svet %>% filter(continent %in% c("Africa", "Asia"),
                                ! name_long %in% c("Cyprus", "Northern Cyprus", "Turkey"))

#splošno
zemljevid<-ggplot()+geom_polygon(data = left_join(afrika.azija, azil.po.drzavljanstvu.priseljeni, by=c("name_long"="državljanstvo")), 
                                 aes(x = long, y = lat,group=group, fill=skupno/1000))+scale_fill_gradientn(colours = c("blue", "green", "red"),
                                                                                                            values = rescale(c(0, 30, 80, 700)), name="Število priseljenih (v tisočih)")+ ggtitle("Državljanstva ljudi priseljenih v Evropo")

#print(zemljevid)
#velika britanija
zemljeviduk<-ggplot()+geom_polygon(data = left_join(afrika.azija, uk.azil, by=c("name_long"="državljanstvo")), 
                                   aes(x = long, y = lat,group=group, fill=skupno/1000))+scale_fill_gradientn(colours = c("blue", "green", "red"),
                                                                                                              values = rescale(c(0, 10, 30, 80)), name="Število priseljenih (v tisočih)")+ ggtitle("Državljanstva ljudi priseljenih v Veliko Britanijo")
#print(zemljeviduk)
#španija
zemljevidsp<-ggplot()+geom_polygon(data = left_join(afrika.azija, spanija.azil, by=c("name_long"="državljanstvo")), 
                                   aes(x = long, y = lat,group=group, fill=skupno/1000))+scale_fill_gradientn(colours = c("blue", "green", "red"),
                                                                                                              values = rescale(c(0, 10, 30, 80)), name="Število priseljenih (v tisočih)")+ ggtitle("Državljanstva ljudi priseljenih v Španijo")
#print(zemljevidsp)

### PREDIKCIJA ZA ŠPANIJO

spanija.predik <- azil.pri %>% filter(država=="Spain")
spanija.predik <- spanija.predik %>% group_by(leto) %>% 
  summarise(število = sum(število, na.rm=TRUE))

grafpredik <- ggplot(spanija.predik,
                     aes(x = leto, y = število/1000)) + geom_line() +
  ylab("Število (x1000)") + xlab("Leto")  +
  theme_classic() + ggtitle("Napoved za Španijo") + geom_smooth(method = "lm", formula = y ~ x + I(x^2))


q <- lm(data = spanija.predik, število ~ leto+I(leto^2))
l<-predict(q, data.frame(leto=seq(2016, 2020, 1)))
l<-lapply(l, as.numeric)
l<- data.frame(l)
#preimenovanje stolpcev

letnice <- c(2016, 2017, 2018, 2019, 2020)
names(l) <- letnice

l <- gather(l, "leto", "število",-6)
row.names(l)<-NULL
l[,-1] <-round(l[,-1],0)

spanija2020 <- rbind(spanija.predik, l) 

graf2020 <- ggplot(spanija2020,
                   aes(x = leto, y = število/1000,group = 1)) + geom_line() +
  ylab("Število (x1000)") + xlab("Leto")  +
  theme_classic() + ggtitle("Napoved za Španijo (od 2008 do 2020)")

#print(graf2020)

spanija.azil.azil <- azil %>% filter(država=="Spain")

### tabela za shiny

azil.shiny1 <- azil.pri %>% group_by(leto,država,državljanstvo) %>% 
  summarise(število = sum(število, na.rm=TRUE))
azil.shiny1["spol"]<-"Total"
azil.shiny1 <- azil.shiny1[,c(1,2,3,5,4)]

azil.shiny <- rbind.data.frame(azil.pri, azil.shiny1)
