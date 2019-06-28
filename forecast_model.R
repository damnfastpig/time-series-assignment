#loading necessary libraries
library('ggplot2')
library('forecast')
library('tseries')

#loading in the dataset that consists of Delhi's daily weather for past 20 years
data = read.csv('data_clean.csv', header=TRUE, stringsAsFactors=FALSE)
ref1 = read.csv('monthlytemp.csv', header=TRUE)
ref2 = read.csv('monthlyhum.csv', header=TRUE)

#its original data column datetime_utc requires some cleaning
#starting by splitting its date and time aspect
library(data.table)
setDT(data)[, paste0("type", 1:2) := tstrsplit(data$datetime_utc, "-")]


#checking data$type1(date splitted from original column) is character
class(data$type1)


#converting data$type1 to date format
library("lubridate")
data$date <- ymd(data$type1)
class(data$date)

#this is for temperature and changing its column names to something simpler
temp<- aggregate(data$X_tempm ~ data$date, data, mean )
colnames(temp)=c("date", "temp")

#now aggregating daily dataset into monthly avg. 
short.date = strftime(temp$date, "%Y/%m")
aggr.stat = aggregate(temp$temp ~ short.date, FUN = mean)
colnames(aggr.stat)=c("date", "temp")

#monthly temperature: decomposing the temperature time series, monthly
tstemp2 <-ts(aggr.stat$temp, frequency=12, start=c(1996,11), end=c(2017, 4))

#monthly temperature: auto arima
set.seed(123)
mytep_month <-arima(tstemp2, order=c(10, 0, 10), seasonal=list(order=c(0, 1, 1)))

#this is for humidity and changing its column names to something simpler
hum<- aggregate(data$X_hum~ data$date, data, mean )
colnames(hum)=c("date", "hum")

#now aggregating daily dataset into monthly avg. since there are too many observations. 
short.date = strftime(hum$date, "%Y/%m")
aggr.stat = aggregate(hum$hum ~ short.date, FUN = mean)
colnames(aggr.stat)=c("date", "hum")

#monthly humidity: decomposing the raine time series
tshum2 <-ts(aggr.stat$hum, frequency=12, start=c(1996,11), end=c(2017, 4))

#monthly humidity: auto arima model and forecast plot
hum_arima <-arima(tshum2, order=c(11, 0, 11), seasonal=list(order=c(0, 1, 1)))


hum_fcast <- forecast(hum_arima, h=36)
#plot(hum_fcast, )

# plot last observations and the forecast
#plot(hum_fcast$mean)

forecastTemperature <- function(months) {
  forecast(mytep_month, h = months)
}


forecastHumidity <- function(months) {
  forecast(hum_arima, h = months)
}

tempinfo <- function(x, y) {
  ref1[c(x:y, 23),]
}

huminfo <- function(x, y) {
  ref2[c(x:y, 23),]
}

ref1["avg", -1]<-colMeans(ref1[1:5, -1], na.rm=TRUE)
ref1
