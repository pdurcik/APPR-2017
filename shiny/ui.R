library(shiny)

shinyUI(fluidPage(
  
  sidebarLayout(
    sidebarPanel(), 
    mainPanel()
  ),
  
  selectInput(inputId = 'drzava',
              label = 'Država:',
              choices = unique(azil.shiny$država),
              selected = 'Slovenia',
              multiple = FALSE),

  
  selectInput(inputId = 'spol',
              label = 'Spol:',
              choices = unique(azil.shiny$spol),
              selected = 'Total',
              multiple = FALSE),

  
  sliderInput("n",
              "Število držav",
              value = 5,
              min = 1,
              max = 10),
  
  plotlyOutput('lin')
  
  
  
))