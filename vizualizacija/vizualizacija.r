# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(dplyr)
library(readr)
library(tibble)
library(scales)

###
#PRVI DEL KODE: ZA EVROPO

#vsota po drzavah
po.drzavah.priseljeni <- priseljeni %>% group_by(drzava) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
po.drzavah.drzavljanstva <- drzavljanstva %>% group_by(drzava) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))

#vsota po izvoru (po drzavljanstvu)
po.drzavljanstvu.priseljeni <- priseljeni %>% group_by(drzavljanstvo) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
po.drzavljanstvu.drzavljanstva <- drzavljanstva %>% group_by(drzavljanstvo) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))

max5.drzavah.priseljeni <- top_n(po.drzavah.priseljeni, 5)

max5.drzavah.drzavljanstva <- top_n(po.drzavah.drzavljanstva, 5)

#iz katerih drzav so se priseljevali v prve tri drzave
spanija <- priseljeni %>% filter(drzava=="Spain")
spanija <- spanija %>% group_by(drzavljanstvo) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
spanija5 <- top_n(spanija, 5)

italija <- priseljeni %>% filter(drzava=="Italy")
italija <- italija %>% group_by(drzavljanstvo) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
italija5 <- top_n(italija, 5)

uk <- priseljeni %>% filter(drzava=="United Kingdom")
uk <- uk %>% group_by(drzavljanstvo) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
uk5 <- top_n(uk, 5)

###
#DRUGI DEL KODE: ZA AZIL

#vsota po drzavah
azil.po.drzavah.priseljeni <- azil.pri %>% group_by(drzava) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
azil.po.drzavah.drzavljanstva <- azil.drz %>% group_by(drzava) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))

#vsota po izvoru (po drzavljanstvu)
azil.po.drzavljanstvu.priseljeni <- azil.pri %>% group_by(drzavljanstvo) %>% summarise(skupno = sum(stevilo, na.rm=TRUE)) 
azil.po.drzavljanstvu.drzavljanstva <- azil.drz %>% group_by(drzavljanstvo) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))

max5.azil.drzavah.priseljeni <- top_n(azil.po.drzavah.priseljeni, 5)

max5.azil.drzavah.drzavljanstva <- top_n(azil.po.drzavah.drzavljanstva, 5)

#iz katerih drzav so se priseljevali v prve tri drzave
spanija.azil <- azil.pri %>% filter(drzava=="Spain")
spanija.azil <- spanija.azil %>% group_by(drzavljanstvo) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
spanija.azil5 <- top_n(spanija.azil, 5)

italija.azil <- azil.pri %>% filter(drzava=="Italy")
italija.azil <- italija.azil %>% group_by(drzavljanstvo) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
italija.azil5 <- top_n(italija.azil, 5)

uk.azil <- azil.pri %>% filter(drzava=="United Kingdom")
uk.azil <- uk.azil %>% group_by(drzavljanstvo) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
uk.azil5 <- top_n(uk.azil, 5)

bel.azil <- azil.pri %>% filter(drzava=="Belgium")
bel.azil <- bel.azil %>% group_by(drzavljanstvo) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
bel.azil5 <- top_n(bel.azil, 5)

sw.azil <- azil.pri %>% filter(drzava=="Sweden")
sw.azil <- sw.azil %>% group_by(drzavljanstvo) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
sw.azil5 <- top_n(sw.azil, 5)

#OPOMBA: NA EUROSTATU SO ZA NEKATERE DRZAVE SLABI PODATKI (NPR ZA NEMCIJA-SIRIJA)

#obdelava tabele iz spletne strani

#tabela vsote za vsako drzavo po letih
po.drzavah.azil <- azil %>% group_by(drzava) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))

max5.azil <- top_n(po.drzavah.azil, 5)
min5.azil <- top_n(po.drzavah.azil, -5)

###
#RISANJE GRAFOV

### v teh stirih tabelah je to kar je v graf1
#pp.uk <- azil.pri %>% filter(drzava=="United Kingdom") %>% group_by(leto) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
#pp.it <- azil.pri %>% filter(drzava=="Italy") %>% group_by(leto) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
#pp.sp <- azil.pri %>% filter(drzava=="Spain") %>% group_by(leto) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
#pp.slo <- azil.pri %>% filter(drzava=="Slovenia") %>% group_by(leto) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))

graf1 <- ggplot(azil.pri %>% filter(drzava %in% c("United Kingdom", "Italy",
                                                  "Spain", "Slovenia")) %>%
                  group_by(leto, drzava) %>% summarise(skupno = sum(stevilo, na.rm=TRUE)),
                aes(x = leto, y = skupno/1000, color = drzava)) + geom_line() +
  ylab("Število (x1000)") + xlab("Leto") + guides(color = guide_legend(title = "Država")) +
  theme_classic() + ggtitle("Število priseljenih ljudi")
#print(graf1)


grafuk<-ggplot(data = uk.azil5, aes(x=drzavljanstvo,y=skupno/1000))+geom_bar(stat="identity", fill="steelblue3")+
  ggtitle("Najpogostejša državljanstva priseljenih ljudi v Veliki Britaniji")+
  ylab("Število (x1000)") + xlab("Državljanstvo")+theme_classic()
#print(grafuk)


grafit<-ggplot(data = italija.azil5, aes(x=drzavljanstvo,y=skupno/1000))+geom_bar(stat="identity", fill="steelblue3")+
  ggtitle("Najpogostejša državljanstva priseljenih ljudi v Italiji")+
  ylab("Število (x1000)") + xlab("Državljanstvo")+theme_classic()
print(grafit)

grafsp<-ggplot(data = spanija.azil5, aes(x=drzavljanstvo,y=skupno/1000))+geom_bar(stat="identity", fill="steelblue3")+
  ggtitle("Najpogostejša državljanstva priseljenih ljudi v Španiji")+
  ylab("Število (x1000)") + xlab("Državljanstvo")+theme_classic()
#print(grafsp)

graf2 <- ggplot(azil.drz %>% filter(drzava %in% c("France", "Italy",
                                                  "United Kingdom","Germany")) %>%
                  group_by(leto, drzava) %>% summarise(skupno = sum(stevilo, na.rm=TRUE)),
                aes(x = leto, y = skupno/1000, color = drzava)) + geom_line() +
  ylab("Število (x1000)") + xlab("Leto") + guides(color = guide_legend(title = "Država")) +
  theme_classic() + ggtitle("Države, ki so podelile največ državljanstev")
#print(graf2)


###zemljevidi

svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
                        "ne_110m_admin_0_countries") %>% pretvori.zemljevid()
#preimnovanje nekaterih držav (mogoče bi se dalo bolj elegantno =) )
azil.po.drzavljanstvu.priseljeni$drzavljanstvo[
  azil.po.drzavljanstvu.priseljeni$drzavljanstvo=="China (including Hong Kong)"]<-"China"
azil.po.drzavljanstvu.priseljeni$drzavljanstvo[
  azil.po.drzavljanstvu.priseljeni$drzavljanstvo=="South Korea"]<-"Republic of Korea"
azil.po.drzavljanstvu.priseljeni$drzavljanstvo[
  azil.po.drzavljanstvu.priseljeni$drzavljanstvo=="North Korea"]<-"Dem. Rep. Korea"
azil.po.drzavljanstvu.priseljeni$drzavljanstvo[
  azil.po.drzavljanstvu.priseljeni$drzavljanstvo=="Myanmar/Burma"]<-"Myanmar"
azil.po.drzavljanstvu.priseljeni$drzavljanstvo[
  azil.po.drzavljanstvu.priseljeni$drzavljanstvo=="Gambia, The"]<-"The Gambia"
azil.po.drzavljanstvu.priseljeni$drzavljanstvo[
  azil.po.drzavljanstvu.priseljeni$drzavljanstvo=="Congo"]<-"Republic of Congo"

uk.azil$drzavljanstvo[
  uk.azil$drzavljanstvo=="China (including Hong Kong)"]<-"China"
uk.azil$drzavljanstvo[
  uk.azil$drzavljanstvo=="South Korea"]<-"Republic of Korea"
uk.azil$drzavljanstvo[
  uk.azil$drzavljanstvo=="North Korea"]<-"Dem. Rep. Korea"
uk.azil$drzavljanstvo[
  uk.azil$drzavljanstvo=="Myanmar/Burma"]<-"Myanmar"
uk.azil$drzavljanstvo[
  uk.azil$drzavljanstvo=="Gambia, The"]<-"The Gambia"
uk.azil$drzavljanstvo[
  uk.azil$drzavljanstvo=="Congo"]<-"Republic of Congo"

spanija.azil$drzavljanstvo[
  spanija.azil$drzavljanstvo=="China (including Hong Kong)"]<-"China"
spanija.azil$drzavljanstvo[
  spanija.azil$drzavljanstvo=="South Korea"]<-"Republic of Korea"
spanija.azil$drzavljanstvo[
  spanija.azil$drzavljanstvo=="North Korea"]<-"Dem. Rep. Korea"
spanija.azil$drzavljanstvo[
  spanija.azil$drzavljanstvo=="Myanmar/Burma"]<-"Myanmar"
spanija.azil$drzavljanstvo[
  spanija.azil$drzavljanstvo=="Gambia, The"]<-"The Gambia"
spanija.azil$drzavljanstvo[
  spanija.azil$drzavljanstvo=="Congo"]<-"Republic of Congo"

#splošno
zemljevid<-ggplot()+geom_polygon(data = inner_join(svet, azil.po.drzavljanstvu.priseljeni, by=c("name_long"="drzavljanstvo")), 
                                 aes(x = long, y = lat,group=group, fill=skupno/1000))+scale_fill_gradientn(colours = c("blue", "green", "red"),
                                                                                                            values = rescale(c(0, 30, 80, 500)))
#print(zemljevid)
#velika britanija
zemljeviduk<-ggplot()+geom_polygon(data = inner_join(svet, uk.azil, by=c("name_long"="drzavljanstvo")), 
                                   aes(x = long, y = lat,group=group, fill=skupno/1000))+scale_fill_gradientn(colours = c("blue", "green", "red"),
                                                                                                              values = rescale(c(0, 10, 30, 80)))
#print(zemljeviduk)
#španija
zemljevidsp<-ggplot()+geom_polygon(data = inner_join(svet, spanija.azil, by=c("name_long"="drzavljanstvo")), 
                                   aes(x = long, y = lat,group=group, fill=skupno/1000))+scale_fill_gradientn(colours = c("blue", "green", "red"),
                                                                                                              values = rescale(c(0, 10, 30, 80)))
#print(zemljevidsp)