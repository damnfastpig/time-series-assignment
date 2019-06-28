library(shiny)
library(shinycssloaders)

ui <- fluidPage(
  titlePanel("Delhi Weather Forcast"),

  sidebarLayout(
    sidebarPanel(
      h2("Forecasting time series"),
      p("This app forecasts monthly weather in Dehli. 
        We built this app by using a time series dataset from 1996-11-01 to 2017-04-24, therefore, the app will forecast 
        monthly temperature and humility for months after 2017-04. Temperatures in this app are in Celsius.
        Humidity in this app is relative humidity and expressed as a percentage. ",
        style = "font-family: 'times'; font-si24pt"),
      br(),
      h5("Please choose range of years to review"),
      sliderInput("years", "Range of past years:", min = 1, max = 22, value = c(1, 22), sep =""),
      

      h5("Please choose the number of months to forcast"),
       sliderInput("months", "Number of months:", min = 1, max = 240, value = 12)
      #submitButton("Forecast")
    ),
    mainPanel(
      h4("Time Series and Forecast Using ARIMA"),
      #actionButton("showResults", "Get the result"),
      #textOutput("message"),
      #plotOutput("temperature", width = "100%", height = "200px")
      #plotOutput("humidity", width = "100%", height = "200px")
      br(),
      br(),
      
     
      
      tabsetPanel(type="tab",
                  
                  tabPanel("Temp. History",
                           h5("Temperature History"),
                           withSpinner(tableOutput("temphist"), type=5)),
                  
                  tabPanel("Hum. History",
                           h5("Humidity History"),
                           withSpinner(tableOutput("humhist"), type=5)),
                  
                  tabPanel("Forecast Table",
                           h5("Monthly Temperature Forecast"),
                           withSpinner(tableOutput("temptable"), type=5),
                           h5("Monthly Humidity Forecast"),
                           withSpinner(tableOutput("humtable"), type=5)),
                  tabPanel("Forecast Graph", 
                           h5("Monthly Temperature Forecast"),
                           withSpinner(plotOutput("tempplot", width = "100%", height = "400px"), type = 5),
                           h5("Monthly Humidity Forecast"),
                           withSpinner(plotOutput("humplot", width = "100%", height = "400px"), type = 5)
      
))
    )
  )
)
