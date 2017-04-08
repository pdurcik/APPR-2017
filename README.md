# Analiza podatkov s programom R, 2016/17

Avtor: Primož Durcik

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2016/17

## Tematika

ANALIZA PRESELJEVANJA V EVROPI

V projektu bom analiziral preseljevanje prebivalstva v Evropi. Zbral bom podatke (nekaterih) evropskih držav za obdobje med letoma 2004 in 2015 glede na državljanstvo in glede na starostno skupino prebivalstva. Analiziral in predstavil bom kako se je spreminjalo število priseljenih in odseljenih v teh državah glede na omenjene kategorije in poskusil najti smiselno povezavo med podatki svoje analize in dogajanjem v svetu.

Viri podatkov: `http://ec.europa.eu/eurostat/web/population-demography-migration-projections/migration-and-citizenship-data/database`

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
