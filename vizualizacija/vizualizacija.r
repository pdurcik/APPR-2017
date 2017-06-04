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

#OPOMBA: NA EUROSTATU SO ZA NEKATERE DRZAVE SLABI PODATKI (NPR ZA NEMCIJA-SIRIJA)

#obdelava tabele iz spletne strani

#tabela vsote za vsako drzavo po letih
po.drzavah.azil <- azil %>% group_by(drzava) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))

max5.azil <- top_n(po.drzavah.azil, 5)
min5.azil <- top_n(po.drzavah.azil, -5)

###
#RISANJE GRAFOV

#g <- ggplot(uk.azil5)  + aes(x = drzavljanstvo, y = skupno) + geom_point()
#barplot(max5.azil$skupno %>% names.arg=c("China", "India", "Malasya","k","f"))

#V PRVEM GRAFU BOM PREDSTAVIL VSOTO PRESELJENIH LJUDI PO LETIH 
#V VSEH DRŽAVAH TER POSEBI ZA UK, IT, SP, SLO

#iz evropskih držav
poletih.preseljeni.evropa <- priseljeni %>% group_by(leto) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))

#po letih priseljeni v UK, IT, SP, SLO iz evrope
pp.uk <- priseljeni %>% filter(drzava=="United Kingdom") %>% group_by(leto) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
pp.it <- priseljeni %>% filter(drzava=="Italy") %>% group_by(leto) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
pp.sp <- priseljeni %>% filter(drzava=="Spain") %>% group_by(leto) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))
pp.slo <- priseljeni %>% filter(drzava=="Slovenia") %>% group_by(leto) %>% summarise(skupno = sum(stevilo, na.rm=TRUE))

#POSEBI ZA UK, KER V NJO SE JE NAJVEČ LJUDI PRISELILO V TEH LETIH

# 1) katera državljanstva so se največ priselila v uk: "uk5"

# 2) katerim državljanstvem so v uk podelili največ državljanstev
drzavljanstva.podelili.uk <- drzavljanstva %>% filter(drzava=="United Kingdom", drzavljanstvo!="Europe") %>% group_by(drzavljanstvo)%>% summarise(skupno = sum(stevilo, na.rm=TRUE))
top5.drzavljanstva.podelili.uk <- top_n(drzavljanstva.podelili.uk, 5)


graf1 <- ggplot(priseljeni %>% filter(drzava %in% c("United Kingdom", "Italy",
                                                    "Spain", "Slovenia")) %>%
                  group_by(leto, drzava) %>% summarise(skupno = sum(stevilo, na.rm=TRUE)),
                aes(x = leto, y = skupno/1000, color = drzava)) + geom_line() +
  ylab("Število (x1000)") + xlab("Leto") + guides(color = guide_legend(title = "Država")) +
  theme_classic() + ggtitle("Število priseljenih ljudi")

print(graf1)

grafuk<-ggplot(data = uk5, aes(x=drzavljanstvo,y=skupno/1000))+geom_bar(stat="identity", fill="steelblue3")+
  ggtitle("Najpogostejša državljanstva priseljenih ljudi v Veliki Britaniji")+
  ylab("Število (x1000)") + xlab("Državljanstvo")+theme_classic()


print(grafuk)

#dodal bom se nekaj grafov, ki pa bodo narejeni na podoben princip kot zgornja dva

###
#ZEMLJEVIDI

#preimnovanje nekaterih držav
italija$drzavljanstvo[italija$drzavljanstvo=="Kosovo (under United Nations Security Council Resolution 1244/99)"]<-"Kosovo"
italija$drzavljanstvo[italija$drzavljanstvo=="Germany (until 1990 former territory of the FRG)"]<-"Germany"
italija$drzavljanstvo[italija$drzavljanstvo=="Russia"]<-"Russian Federation"
italija$drzavljanstvo[italija$drzavljanstvo=="Former Yugoslav Republic of Macedonia, the"]<-"Macedonia"
italija$drzavljanstvo[italija$drzavljanstvo=="Vatican City State"]<-"Vatican"

#zemlevid evrope uvoz
evropa <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                          "ne_50m_admin_0_countries", encoding = "UTF-8") %>%
  pretvori.zemljevid() %>% filter(continent == "Europe" | sovereignt %in% c("Turkey", "Cyprus", "Russian Federation"),
                                  long > -30)

#prikaz zemljevida brez podatkov
#print(ggplot() + geom_polygon(data = evropa, aes(x = long, y = lat, group = group)) + 
#        coord_map(xlim = c(-25, 40), ylim = c(32, 72)))

zemljevid.it<-ggplot()+geom_polygon(data = left_join(evropa, italija, by=c("name_long"="drzavljanstvo")), 
                                    aes(x = long, y = lat,group=group, fill=skupno/1000))+
  coord_map(xlim = c(-25, 40), ylim = c(32, 72))+scale_fill_gradientn(colours = c("blue", "green", "red"),
                                                                      values = rescale(c(0, 30, 100, 700)))

print(zemljevid.it)

#v zgornjem zemljevidu bom predstavil ljudje katerih drzavljanstev so se priseljevali v Italijo
#uvozil bom tudi zemljevid sveta (oziroma Evrope, Azije in Afrike) in predstavil se
#   iz katerih drzav Afrike in Azije so se najvec preseljevali v Evropo in v katerih 
#   evropskih drzavah je bilo najvec prosenj za azil
