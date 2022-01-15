### Code for  Assignment #2
### Nathalie Mayor
### Econ 112 Macroeconomic Data Analysis

library(tseries)
library(strucchange)
library(sandwich)
library(MASS)
library(lmtest)
library(vars)

current_path <- rstudioapi::getActiveDocumentContext()$path
setwd(dirname(current_path))

data.gdp=read.csv(file.choose(),header=T,sep=",")
summary(data.gdp)


rgdp=ts(data.gdp[,2],start=1975,frequency=4)
plot(rgdp,col="pink3")

data.BoE=read.csv(file.choose(),header=T,sep=',')
summary(data.BoE)


BoErate=ts(data.BoE[,2],frequency=12,start=1986)
plot(BoErate)

int=aggregate(BoErate,nfrequency=4,mean)


# compute quarterly real GDP growth rate and short term interest rate 

dlrgdp = 400*diff(log(rgdp))
plot(dlrgdp)

y=window(dlrgdp,start=c(1986,1))

plot(y,col="black",lwd=2,xlim=c(1987,2019),ylim=c(-10,20))
lines(int,col="blue",lwd=2)

#compute pp test to check for stationarity for GDP growth and STIR
adf.test(dlrgdp)
pp.test(dlrgdp)
kpss.test(dlrgdp)

# p.value smaller than 1
adf.test(inf)
pp.test(int)
kpss.test(int)
# p.value smaller than 1

### interest rate and GDP growth are stationary

#VAR analysis begins here

#bind data (pay attention to order)

data.y.int<-ts(cbind(y,int))

#compute information criteria and select order of VAR

VARselect(data.y.int,lag.max=16,type="const")
### Select VAR(2), lowest AIC and BIC

#run VAR estimation and report summary

var.y.int = VAR(data.y.int,p=2)

summary(var.y.int)

#diagnostic: fit and residuals

plot(var.y.int)

#Structural Impulse Response using Sims (1980) solution (Cholesky decomposition)

irf.y.int<-irf(var.y.int,ortho=TRUE,ci=0.95,runs=100,n.ahead=16)

plot(irf.y.int,lwd=2)

#What do you conclude from Impulse Response about effect of U.S. Monetary Policy on Economic Activity?

#What theoretical assumptions are implemented by the Cholesky decomposition?


#Additional Steps (not required for writing assignment 2)

#Compute and plot structural shocks to nominal interest rates. How can you interpret these shocks?

P.cholesky = Psi(var.y.int)

P = as.matrix(P.cholesky[,,1])

e = as.matrix(residuals(var.y.int))

shocks = P%*%t(e)

varepsilon_y = ts(shocks[1,],frequency=4,start=1986)

varepsilon_i = ts(shocks[2,],frequency=4,start=1986)


plot(varepsilon_i)

#Cumulative Structural Impulse Response

irf.y.int<-irf(var.y.int,ortho=TRUE,cumulative=TRUE,ci=0.95,runs=100,n.ahead=16)
plot(irf.y.int,lwd=2)

#Forecast Error Variance Decomposition according to Structural Shocks

fevd.y.int<-fevd(var.y.int,ortho=TRUE,n.ahead=32)
plot(fevd.y.int,lwd=2)


