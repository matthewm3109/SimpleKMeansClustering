#load the necessary libraries 
library(tidyverse)
library(factoextra)

#Import the stock data 
Sample <- read.csv("Sample.csv")

#Get the predictors and group them in a list 
vars <- c("yearOverYearGrowth","dividendYield")

#Find the optimal number of clusters 
x <- fviz_nbclust(Sample[vars], kmeans, method ="wss")

#The biggest drop in the Total Sum of Squares is with 3 clusters

#Run the kmeans (already loaded into env) with 3 clusters 
km <- kmeans(Sample[vars],3)

#Plot clusters 
plot(Sample[vars], 
     col = km$cluster, 
     main = "Stock Yield vs. Growth",
     xlab = "Year over year growth (%)", 
     ylab = "Dividend yield (%)")


#Output final file with the generated clusters 
Sample[5] = km$cluster
write.csv(Sample,"StocksWithClusters.csv")
