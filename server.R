library(shiny)
source("forecast_model.R")

server <- function(input, output) {
  getTemperature <- reactive({
    forecastTemperature(input$months)
    
  })
  
  
  getHumidity <- reactive({
    forecastHumidity(input$months)
  })
  
  getTempHist <- reactive ({
    tempinfo(input$years[1], input$years[2])
    
  })
  
  getHumHist <- reactive ({
    huminfo(input$years[1], input$years[2])
    
  })
  
  
     output$tempplot <- renderPlot({
     plot(getTemperature())
     })
     
     output$humplot<- renderPlot({
       plot(getHumidity())
     })
     
     output$temptable<- renderTable({
       getTemperature()
       
     })
     
     output$humtable<- renderTable({
       getHumidity()
       
     })
     
     output$temphist<- renderTable({
       getTempHist()
       
     })
     
     output$humhist<- renderTable({
       getHumHist()
       
     })
     

     
}
