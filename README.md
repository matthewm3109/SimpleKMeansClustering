# SimpleKMeansClustering
 
The goal of this small personal project is to understand clustering techniques with R. I also wanted to explore building my own dataset, using the 'quantmod' package. I created my own dataset of S&P 500 stocks with two predictors - Dividend Yield and the most recent Year-over-year growth. Then, I tried to segment the stocks into clear groups.
 
## Usage
 
1. Use the 'ClusteringStocks' file to pull information from Yahoo Finance for every stock in 'sp500.csv.' Then build a dataset, 'Sample.csv.'
2. Run 'StockAnalysis' to find the optimal number of clusters and segment 'Sample.csv' into clusters. The final CSV with clusters is called 'StocksWithClusters'
 
## Conclusion
 
I found the optimal number of clusters was three. I then used the K-Means Algorithm to divide the dataset into clusters. I was not impressed with the results because most stocks had low Dividend Yield and nearly all experienced negative price growth in the last year. Thus, the clusters I got were not useful for any decision making. In the future, I will use another library to pull more diverse predictors or build my own web scraper.
