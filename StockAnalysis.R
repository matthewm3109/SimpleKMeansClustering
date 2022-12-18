#Load necessary packages 
library('quantmod')

#Define start and end dates 
end <- Sys.time()
start <- seq(from=end,by = paste(-12,"months"),length=2)[2]

#I got a list of all S&P 500 stocks in a flat CSV file. Lets load these records 
sp500 <- read.csv('sp500.csv')
counter <- 0

#Load functions 
source('functions.R')

getSymbolsWithErrorHandling <- function(ticker){
  getSymbols(ticker, src='yahoo',from=start,to=end,env=NULL)
}

#Create vectors to store different values. These equal-length vectors will be aggregated into a single dataframe 
processedTicker <- c()
priceGrowth <- c()
divRate <- c()

for (x in sp500$Symbol){
  counter <- counter + 1 
  symbol <- tryCatch(getSymbols(x, src='yahoo',from=start,to=end,env=NULL),error = function(e) e)
  dividend <- tryCatch(getDividends(x, src='yahoo',from=start,to=end),error = function(e) e)
  if(inherits(symbol, "error")){
    print(paste("ERROR in getting stock prices with ", x))
    next 
  }
  if(inherits(dividend, "error")){
    print(paste("ERROR in getting dividend with ", x))
    next 
  }
  else {
    #Get growth of stock price 
    initialPrice <- as.numeric(symbol[1,1])
    finalPrice <- as.numeric(symbol[nrow(symbol),1])
    growth <- (finalPrice/initialPrice - 1) * 100 
    #Store records with no issues into vectors initialized above 
    Yield <- (as.numeric(dividend[nrow(dividend),1])/finalPrice) * 100
    if (length(Yield) == 0){Yield <- 0}
    
    #Add to vectors 
    processedTicker <- append(processedTicker,x)
    priceGrowth <- append(priceGrowth,growth)
    divRate <- append(divRate,Yield)
    print(paste("Processed ",x))
  }
}

df <- data.frame(ticker = processedTicker, yearOverYearGrowth = priceGrowth, dividendYield = divRate )
write.csv(df,"Sample.csv")


