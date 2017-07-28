# Pred uporabo namestite paket extrafont, potem pa izvedite
#   library(extrafont)
#   font_import() # vpraša za potrditev, traja nekaj minut
#   loadfonts()
# Slednja ukaza izvedite samo enkrat in ju ne vkljucujte v program!

library(extrafont)

# Prosim, da uporabljate eno od sledecih vrednosti za parameter family:
# * "Arial"
# * "Arial Black"
# * "Comic Sans MS"
# * "Courier New"
# * "Georgia"
# * "Impact"
# * "Trebuchet MS"
# * "Times New Roman"
# * "Verdana"
pdf.options(family = "Arial")
