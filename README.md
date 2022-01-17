# Introduction

This repository contains R code for a Macroeconometrics (Bsc, Msc) course at the University of California - San Diego (UCSD).

The data used can be found in the 'data' folder and was extracted from [FRED](https://fred.stlouisfed.org/).

# Specifications on Files

## [A1_modelling_inflation_bj.R](https://github.com/nathaliemayor/Macroeconometrics/blob/main/A1_modelling_inflation_bj.R) / [A1_modelling_ur_bj.R](https://github.com/nathaliemayor/Macroeconometrics/blob/main/A1_modelling_ur_bj.R)



## [A2_svar_modelling_gdp_ir.R](https://github.com/nathaliemayor/Macroeconometrics/blob/main/A2_svar_modelling_gdp_ir.R) : Assessing the Effectiveness of the Monetary Policy in the UK

(As of 13-Dec-2019) Central banks around the world have been loosening their monetary policies these last months, amid intensifying worries about low inflation, slowing global growth and a possible recession. As Brexit uncertainty continues to hang over England, its central bank is holding the monetary policy unchanged and the interest rates stable. However, the Brexit date is currently set for January 31, 2020, and the general concern is the existence or the absence of an agreed trade deal in order to start a new relationship with the European Union. Without this agreement, the country would have to face another extend transition period or to leave the European Union with a "no-deal". In such a hazardous environment, the objectives of the United Kingdom’s monetary policy is to use its tools in the most efficient way to face a declining growth and an increase in prices that leaving the EU without a deal would provoke. Indeed, an abrupt departure from the European Union would not allow business to have a transition period to adjust. Another concern concerning another delay is that it could lead to economic weakness. In this uncertain setting, the impact of the monetary policy on the economic activity represents an especially important concern. 

We analyse the impact of one of the tools used by the United Kingdom’s monetary policy, policy interest rates, on the gross domestic product growth through empirical evidence. In order to address this concern we use the UK’s GDP and short-term interest rates time series data. We face the challenges brought by the fact that both data simultaneously cause each other by using a SVAR model. Indeed, this feature called "endogeneity bias" forbids us to use a traditional OLS regression. Thus, we will then use a solution proposed by Christopher A. Sims (1980) [[1]](#1) and apply it to our analysis in order to select and estimate a vector autoregression (VAR) process. 

Concerning the results : following the vector autoregression methodology, the selected process, based on the Bayesian information criterion and the Akaike information criterion was a second order VAR. The following two models were estimated to describe GDP growth and the nominal short-term interest rate in the United Kingdom :

**GDP Growth**: g<sub>t</sub> = 0.661 + 0.478 g<sub>t-1</sub> + 0.256 g<sub>t-2</sub> - 0.498 i<sub>t-1</sub> + 0.475 i<sub>t-2</sub> + &epsilon;<sub>gt</sub>

**Nominal Short-Term Interest Rate**: i<sub>t</sub> = - 0.137 + 1.253 i<sub>t-1</sub> - 0.271 i<sub>t-2</sub> + 0.009 g<sub>t-1</sub> + 0.071 g<sub>t-2</sub> + &epsilon;<sub>it</sub>

Further analysis based on empirical evidence then suggested that GDP growth actually moves in the opposite direction that economic theory would suggest : a rise in short-term interest rate might cause an increase in GDP growth. This result however is subject to the model’s limitations such as omitted variable bias.


# References

<a id="1">[1]</a> 
Sims, Christopher A. “Macroeconomics and Reality.” Econometrica 48, no. 1 (1980): 1–48. https://doi.org/10.2307/1912017.
