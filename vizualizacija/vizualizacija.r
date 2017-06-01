# 3. faza: Vizualizacija podatkov

library(ggplot2)
library(dplyr)
library(readr)
library(tibble)

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

library(ggplot2)
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

graf1t<-data.frame(pp.sp$leto, 
                   pp.sp$skupno, pp.slo$skupno, pp.uk$skupno, pp.it$skupno)
graf1<-ggplot(graf1t, aes(x=pp.sp.leto))+
  geom_line(aes(y=pp.slo.skupno),lwd = 1, color="green")+
  geom_line(aes(y=pp.sp.skupno),lwd = 1, color="orange")+
  geom_line(aes(y=pp.uk.skupno),lwd = 1, color="violetred1")+
  geom_line(aes(y=pp.it.skupno),lwd = 1, color="royalblue2")+
  ylab("stevilo")+xlab("leto")+theme_classic()+ggtitle("število priseljenih ljudi")
#manjka legenda!


#print(graf1)

grafuk<-ggplot(data = uk5, aes(x=drzavljanstvo,y=skupno))+geom_bar(stat="identity", fill="steelblue3")+
  ggtitle("najpogostejša državljanstva priseljenih ljudi v Veliki Britaniji")

#print(grafuk)

#dodal bom se nekaj grafov, ki pa bodo narejeni na podoben princip kot zgornja dva

###
#ZEMLJEVIDI

#zemlevid evrope uvoz
evropa <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                          "ne_50m_admin_0_countries", encoding = "UTF-8") %>%
  pretvori.zemljevid() %>% filter(continent == "Europe" | sovereignt %in% c("Turkey", "Cyprus"),
                                  long > -30)

#prikaz zemljevida brez podatkov
#print(ggplot() + geom_polygon(data = evropa, aes(x = long, y = lat, group = group)) + 
 #       coord_map(xlim = c(-25, 40), ylim = c(32, 72)))

#v zgornjem zemljevidu bom predstavil ljudje katerih drzavljanstev so se priseljevali v Italijo
#uvozil bom se zemljevid sveta (oziroma Evrope, Azije in Afrike) in predstavil se
#   iz katerih drzav Afrike in Azije so se najvec preseljevali v Evropo in v katerih 
#   evropskih drzavah je bilo najvec prosenj za azil
