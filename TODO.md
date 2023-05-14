# Things to possibly experiment with


  * Search symbol pairs based on overview.
  * Find formulas for volatility, SMA, MACD ... etc, that work for the overview
  
  
  
### Search symbol pairs based on overview.

For this feature we would want to create a UI with liveview, for which we could build a "query" to search all existing symbols based on their overview.

The query would have options to comapre fields betwen or provided values them with operators like lesser/greater than or equal for any of the keys. 

For example we might want to ask the following: "The current price is lower than the median, and volatility is above %80"

We would have 2 options for this. 

1. Write a text parser so we can provide an input like. 

.current_price < .median && volitility > 0.8



2. Write a dynamic form with 3 dropdowns. The first dropdowns would be used for field, second ofr operator, and the last one the otherfield, which could also be custom



|Dropdown 1 (fields)] [Dropdown 2 (operators)] [Dropdown 3 (fields + custom)] [number field if custom]
|Dropdown 1 (fields)] [Dropdown 2 (operators)] [Dropdown 3 (fields + custom)] 


|current_price| |<| |medial|
|volatility   | |<| |custom| |0.8|





### Search symbol pairs based on overview.


At the moment we don't have any good analysis of the data we get from candles.
We currently use the Overview in the analysis module to run some calculations but they are not very valuable and can't be used to find interesting oportunities.

We want to find formulas commonly used in technical analysis that we can calcualte and include in the overview for our search.

Such formulas might be things like MACD, SMA
