# Econ 112 Macroeconomic Data Analysis
# Homework 3
# this code applies the Box-Jenkins procedure to select 
# the best fitting time series model of UK Unemployment rate

current_path <- rstudioapi::getActiveDocumentContext()$path
setwd(dirname(current_path))

ur=read.csv(file.choose(),header = T)

# turn data into times series object

rur=ts(ur[,2],start=1960,frequency=4)

#rename variable for estimation
y = rur
y = ts(rur,start=1960,frequency=4)

# IDENTIFICATION STAGE

#plot data, ACF and PACF to get an idea of model class

plot(y, main="Quarterly UR", xlab="Time", type = "l")
acf(y,main="Autocorrelation UR Growth, UK")
pacf(y,main="Partial Autocorrelation UR, UK")

# at this stage select 3-4 models that you think are plausible given
# the ACF and PACF above.

# ESTIMATION STAGE

# estimate plausible models

# load all the libraries needed
library(dyn)
library(forecast)
library(sandwich)
library(lmtest)

# estimate ARMA models, compare fit using AIC and BIC

AR.1.MA.0.y<-arima(y,order=c(1,0,0))
coeftest(AR.1.MA.0.y,vcv=NeweyWest)

AR.2.MA.0.y<-arima(y,order=c(2,0,0))
coeftest(AR.2.MA.0.y,vcv=NeweyWest)

AR.3.MA.0.y<-arima(y,order=c(3,0,0))
coeftest(AR.3.MA.0.y,vcv=NeweyWest)

AR.1.MA.1.y<-arima(y,order=c(1,0,1))
coeftest(AR.1.MA.1.y,vcv=NeweyWest)

AR.2.MA.1.y<-arima(y,order=c(2,0,1))
coeftest(AR.2.MA.1.y,vcv=NeweyWest)

AR.1.MA.2.y<-arima(y,order=c(1,0,2))
coeftest(AR.1.MA.2.y,vcv=NeweyWest)

AR.2.MA.2.y<-arima(y,order=c(2,0,2))
coeftest(AR.2.MA.2.y,vcv=NeweyWest)


AIC(AR.1.MA.0.y,AR.2.MA.0.y,AR.3.MA.0.y,AR.1.MA.1.y,AR.2.MA.1.y,AR.1.MA.2.y,AR.2.MA.2.y)
BIC(AR.1.MA.0.y,AR.2.MA.0.y,AR.3.MA.0.y,AR.1.MA.1.y,AR.2.MA.1.y,AR.1.MA.2.y,AR.2.MA.2.y)

# DIAGNOSTIC CHECKING

#perform diagnostics of chosen model: AR(1) in our case

#re-estimate using OLS

AR.2.y <-dyn$lm(y~lag(y,-1)+lag(y,-2))
coeftest(AR.1.y,vcv=NeweyWest)

AR.2.y.fitted<-fitted(AR.2.y)

plot(y, main="Figure 7: Fitted AR(2) Estimates", xlab="Time", type = "l", col="blue")
lines(AR.2.y.fitted, col="red")

AR.2.y.residuals<-residuals(AR.2.y)
plot(AR.2.y.residuals, main="Figure 8:Residuals of AR(2) Estimates", xlab="Time", type = "l", col="blue")

acf(AR.2.y.residuals, main="Autocorrelation of Residuals for AR(2) of UK unemployment rate")
pacf(AR.1.MA.1.y.residuals, main="Figure 8: Autocorrelation of Residuals for ARMA(1,1) of UK inflation rate")

# plot instagram of residuals and contrast with Gaussian distribution

x <- AR.2.y.residuals
h<-hist(x, breaks=40, col="lightblue", xlab="UR", 
        main="Figure 11: Histogram with Normal Curve (for the unemployment's residuals)") 
xfit<-seq(min(x),max(x),length=40) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="orange", lwd=2)



