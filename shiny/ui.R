library(shiny)

shinyUI(fluidPage(
  
  sidebarLayout(
    sidebarPanel('Na spodnjem grafu lahko vidimo predikcijo stevila prihodov ali prenocitev turistov iz izbrane drzave v izbrani obcini na podlagi linearne regresije.'), 
    mainPanel()
  ),
  
  selectInput(inputId = 'drzava',
              label = 'država:',
              choices = unique(azil.shiny$država),
              selected = 'Slovenia',
              multiple = FALSE),

  
  selectInput(inputId = 'spol',
              label = 'spol:',
              choices = unique(azil.shiny$spol),
              selected = 'Total',
              multiple = FALSE),

  
  sliderInput("n",
              "Number of observations:",
              value = 5,
              min = 1,
              max = 10),
  
  plotOutput('lin')
  
  
  
))