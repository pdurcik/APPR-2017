# Analiza podatkov s programom R, 2016/17

Avtor: Primož Durcik

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2016/17

## Tematika

ANALIZA PRESELJEVANJA V EVROPI

V projektu bom analiziral preseljevanje prebivalstva v Evropi. Zbral bom podatke (nekaterih) evropskih držav za obdobje med letoma 2008 in 2015 glede na državljanstvo, spol in glede na starostno skupino priseljenega prebivalstva. Analiziral in predstavil bom, kako se je spreminjalo število priseljenih v teh državah glede na omenjene kategorije in primerjal število priseljenih ljudi s številom pridobljenih državljanstev in prošenj za azil za določene skupine ljudi.

V prvi tabeli bom imel stolpce država, leto, spol, starostna skupina, državljanstvo, meritev pa bo število priseljencev.
V drugi tabeli bom imel stolpce država, leto, spol, starostna skupina, državljanstvo, meritev pa bo število pridobljenih državljanstev.
V tretji tabeli bom imel stolpce država, leto, državljanstvo, meritev pa bo število prošenj za azil.

Viri podatkov: 
* `http://ec.europa.eu/eurostat/web/population-demography-migration-projections/migration-and-citizenship-data/database`
* `http://www.pewglobal.org/2016/08/02/number-of-refugees-to-europe-surges-to-record-1-3-million-in-2015/`
* `http://www.economist.com/blogs/graphicdetail/2016/03/daily-chart-20`
Podatki bodo v CSV (prvi vir) in HTML (drugi in tretji vir) obliki.

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)
