source('R/mdoow.R')
library(httpuv)

app <- list(call = http.call)
startServer('0.0.0.0', 8888, app)
