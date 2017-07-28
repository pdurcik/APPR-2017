library(shiny)
library(plotly)



shinyServer(function(input, output) {
  
  output$lin <- renderPlot({
    drzava.azil <- azil.shiny %>% filter(država==input$drzava, spol==input$spol)%>% group_by(državljanstvo) %>% 
      summarise(skupno = sum(število, na.rm=TRUE))
    drzava.azil.n <- top_n(drzava.azil,input$n)
    g1 <- ggplot(data = drzava.azil.n, aes(x=državljanstvo,y=skupno/100))+geom_bar(stat="identity", fill="steelblue3")+
      ggtitle("Najpogostejša državljanstva priseljenih ljudi")+
      ylab("Število (x100)") + xlab("Državljanstvo")+theme_classic()
    print(g1)
    
    #g2 <- plot_ly(drzava.azil.n, x = ~državljanstvo, y = ~skupno, type = 'bar')
    #print(g2)
    
  })
})
