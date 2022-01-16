# Econ 112 Macroeconomic Data Analysis
# this code applies the Box-Jenkins procedure to select 
# the best fitting time series model of UK Inflation

current_path <- rstudioapi::getActiveDocumentContext()$path
setwd(dirname(current_path))

inf=read.csv(file.choose(),header = T)

# turn data into times series object

rinf=ts(inf[,2],start=1960,frequency=1)

# compute annualized growth rate

#rename variable for estimation
y = rinf
y = ts(rinf,start=1960,frequency=1)

# IDENTIFICATION STAGE

#plot data, ACF and PACF to get an idea of model class

plot(y, main="Figure 2: UK Inflation Rate", xlab="Time", type = "l")
acf(y,main="Figure 5: Autocorrelation inflation, UK")
pacf(y,main="Figure 6: Partial Autocorrelation inflation, UK")

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

AR.3.MA.1.y<-arima(y,order=c(3,0,1))
coeftest(AR.3.MA.1.y,vcv=NeweyWest)

AR.3.MA.2.y<-arima(y,order=c(3,0,2))
coeftest(AR.3.MA.3.y,vcv=NeweyWest)

AR.3.MA.3.y<-arima(y,order=c(3,0,3))
coeftest(AR.3.MA.3.y,vcv=NeweyWest)

AR.1.MA.3.y<-arima(y,order=c(1,0,3))
coeftest(AR.1.MA.3.y,vcv=NeweyWest)

AR.2.MA.3.y<-arima(y,order=c(2,0,3))
coeftest(AR.2.MA.3.y,vcv=NeweyWest)

AIC(AR.1.MA.1.y,AR.2.MA.1.y,AR.1.MA.2.y,AR.2.MA.2.y,AR.3.MA.1.y,AR.3.MA.2.y,AR.3.MA.3.y,AR.1.MA.3.y,AR.2.MA.3.y)
BIC(AR.1.MA.1.y,AR.2.MA.1.y,AR.1.MA.2.y,AR.2.MA.2.y,AR.3.MA.1.y,AR.3.MA.2.y,AR.3.MA.3.y,AR.1.MA.3.y,AR.2.MA.3.y)

# DIAGNOSTIC CHECKING

#perform diagnostics of chosen model: AR(1)MA(1) in our case

#re-estimate using OLS

AR.1.MA.1.y <-dyn$lm(y~lag(y,-1))
coeftest(AR.1.MA.1.y,vcv=NeweyWest)

AR.1.MA.1.y.fitted<-fitted(AR.1.MA.1.y)

plot(y, main="Fitted ARMA(1,1) Estimates", xlab="Time", type = "l", col="blue")
lines(AR.1.MA.1.y.fitted, col="red")

AR.1.MA.1.y.residuals<-residuals(AR.1.MA.1.y)
plot(AR.1.MA.1.y.residuals, main="Residuals of ARMA(1,1) Estimates", xlab="Time", type = "l", col="blue")

acf(AR.1.MA.1.y.residuals, main="Autocorrelation of Residuals for ARMA(1,1) of UK inflation rate")

# plot histogram of residuals and contrast with Gaussian distribution

x <- AR.1.MA.1.y.residuals
h<-hist(x, breaks=40, col="lightblue", xlab="Inflation rate", 
        main="Histogram with Normal Curve") 
xfit<-seq(min(x),max(x),length=40) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="orange", lwd=2)

